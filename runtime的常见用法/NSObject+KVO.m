//
//  NSObject+KVO.m
//  响应式编程
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "NSObject+KVO.h"
#import "KVO_Person.h"
#import <objc/runtime.h>
@implementation NSObject (KVO)
-(void)lx_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    //修改对象指针
    object_setClass(self, [KVO_Person class]);
    //保存可以
    objc_setAssociatedObject(self, @"obsever", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"keyPath", keyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
