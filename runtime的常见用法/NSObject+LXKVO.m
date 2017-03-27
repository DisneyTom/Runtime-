
//
//  NSObject+LXKVO.m
//  CKRuntime
//
//  Created by 梁晓龙 on 15/12/10.
//  Copyright © 2015年 梁晓龙. All rights reserved.
//

#import "NSObject+LXKVO.h"
#import <objc/objc-runtime.h>

NSString *const kLXKVOClassPrefix = @"LXKVOClassPrefix_";
NSString *const LXKObserversAssociatedKey = @"CKObserversAssociatedKey";

typedef void(^ObserverBlock)(id observedObject, NSString *key, id oldValue, id newValue);
// 创建一个用于存放观察者info的类
@interface CKObserverInfo : NSObject
// 观察者属性
@property (nonatomic, weak) id observer;
// key属性
@property (nonatomic, copy) NSString *key;
// 回调block
@property (nonatomic, copy) ObserverBlock block;
@end
@implementation CKObserverInfo
// 初始化方法
- (instancetype)initWithObserver:(id)observer ForKey:(NSString *)key WithBlock:(ObserverBlock)block {
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}


@end

@implementation NSObject (LXKVO)

- (void)ck_addObserver:(id)observer ForKey:(NSString *)key WithBlock:(void(^)(id,NSString *,id,id))block {
    // 获取 setterName
    NSString *setName = setterName(key);
    SEL setSelector = NSSelectorFromString(setName);
    // 通过SEL获得方法
    Method setMethod = class_getInstanceMethod(object_getClass(self), setSelector);
    if (!setMethod) {
        @throw [NSException exceptionWithName:@"LXKVO Error" reason:@"若无setter方法，无法KVO" userInfo:nil];
    }
    // 获得当前类
    // 判断是否已经创建衍生类
    Class thisClass = object_getClass(self);
    NSString *thisClassName = NSStringFromClass(thisClass);
    if (![thisClassName hasPrefix:kLXKVOClassPrefix]) {
        thisClass = [self makeKVOClassWithOriginalClassName:thisClassName];
        // 改变类的标识
        object_setClass(self, thisClass);
    }
    // 判断衍生类中是否实现了setter方法
    if(![self hasSelector:setSelector]) {
        const char *setType = method_getTypeEncoding(setMethod);
        class_addMethod(object_getClass(self), setSelector, (IMP)ck_setter, setType);
    }
    // 将observer添加到观察者数组
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(LXKObserversAssociatedKey));
    if (!observers) {
        observers = [NSMutableArray new];
        objc_setAssociatedObject(self, (__bridge const void *)(LXKObserversAssociatedKey), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 创建观察者info类
    CKObserverInfo *observerInfo = [[CKObserverInfo alloc]initWithObserver:observer ForKey:key WithBlock:block];
    [observers addObject:observerInfo];
}
void ck_setter(id objc_self, SEL cmd_p, id newValue) {
    // setterName转为name
    NSString *setName = NSStringFromSelector(cmd_p);
    NSString *key = nameWithSetName(setName);
    // 通过KVC获取key对应的value
    id oldValue = [objc_self valueForKey:key];
    // 将set消息转发给父类
    struct objc_super selfSuper = {
        .receiver = objc_self,
        .super_class = class_getSuperclass(object_getClass(objc_self))
    };
    objc_msgSendSuper(&selfSuper,cmd_p,newValue);
    // 调用block
    NSMutableArray *observers = objc_getAssociatedObject(objc_self, (__bridge const void *)LXKObserversAssociatedKey);
    for (CKObserverInfo *info in observers) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([info.key isEqualToString:key]) {
                info.block(objc_self,key,oldValue,newValue);
            }
        });
    }
}
// 从setterName转为name
NSString *nameWithSetName(NSString *setName) {
    if (setName.length <= 4 || ![setName hasPrefix:@"set"] || ![setName hasSuffix:@":"]) {
        @throw [NSException exceptionWithName:@"LXKVO Error" reason:@"set方法not available" userInfo:nil];
    }
    NSString *Name = [setName substringWithRange:NSMakeRange(3, setName.length - 4)];
    NSString *firstCharacter = [Name substringToIndex:1];
    return [[firstCharacter lowercaseString] stringByAppendingString:[Name substringFromIndex:1]];
}
// 判断set方法是否存在
- (BOOL)hasSelector:(SEL)aSelector {
    unsigned int mCount = 0;
    Method *methods = class_copyMethodList(object_getClass(self), &mCount);
    for (int i = 0; i < mCount; i ++) {
        Method method = methods[i];
        SEL setSelector = method_getName(method);
        if (setSelector == aSelector) {
            free(methods);
            return YES;
        }
    }
    free(methods);
    return NO;
}
// 通过runtime创建类
- (Class)makeKVOClassWithOriginalClassName:(NSString *)className {
    NSString *kvoClassName = [kLXKVOClassPrefix stringByAppendingString:className];
    Class kvoClass = NSClassFromString(kvoClassName);
    if (kvoClass) {
        return kvoClass;
    }
    // objc_allocateClassPair创建类
    kvoClass = objc_allocateClassPair(object_getClass(self), kvoClassName.UTF8String, 0);
    objc_registerClassPair(kvoClass);
    return kvoClass;
}
// 通过key获取对应的setterName
NSString *setterName(NSString *key) {
    if (key.length == 0) {
        @throw [NSException exceptionWithName:@"LXKVO Error" reason:@"没有对应的key" userInfo:nil];
    }
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *Name = [[firstCharacter uppercaseString]stringByAppendingString:[key substringFromIndex:1]];
    return [NSString stringWithFormat:@"set%@:",Name];
}
- (void)ck_removeObserver:(id)observer ForKey:(NSString *)key {
    // 删除观察者
    CKObserverInfo *removeInfo = nil;
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(LXKObserversAssociatedKey));
    for (CKObserverInfo *info in observers) {
        if (info.observer == observer && [info.key isEqualToString:key]) {
            removeInfo = info;
        }
    }
    [observers removeObject:removeInfo];
}
@end
