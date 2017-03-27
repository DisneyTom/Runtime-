//
//  TestViewController.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "TestViewController.h"
#import <objc/runtime.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createClass];
   
}

-(void)createClass{
    //1.定义一个Person类，继承于NSObject
    Class Person =objc_allocateClassPair([NSObject class], "Person", 0);
    //2.添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(Person, "name", attrs, 3);
    
    //3.添加方法
    class_addMethod(Person, @selector(name), (IMP)nameGetter, "@@:");
    class_addMethod(Person, @selector(setName:), (IMP)nameSetter, "v@:@");
    
    //4.注册该类
    objc_registerClassPair(Person);
    
    //获取实例
    id instance =[[Person alloc]init];
    [instance setName:@"lxl"];
    unsigned  int count;
    Ivar *ivarlists =class_copyIvarList([Person class], &count);
    for (int i =0; i<count; i++) {
        Ivar  ivar =ivarlists[i];
        const char * ivarName = ivar_getName(ivar);
        NSLog(@"ivarName:%s",ivarName);
    }
    
    
}

//get方法
NSString * nameGetter(id self, SEL _cmd){
    Ivar  ivar =class_getInstanceVariable([self class], "_privateName");
    return object_getIvar(self, ivar);
}

//set方法
void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}


@end
