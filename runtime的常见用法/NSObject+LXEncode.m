//
//  NSObject+LXEncode.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "NSObject+LXEncode.h"
#import <objc/runtime.h>

@implementation NSObject (LXEncode)
//归档
-(void)lx_encodeWithCoder:(NSCoder *)acoder
{
    if (!acoder) return;
    if (self == (id)kCFNull) {
        [((id<NSCoding>)self)encodeWithCoder:acoder];
        return;
    }
    //创建count保存实例变量个数
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    //循环遍历实例变量链表
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        //获取实例变量名
        NSString *key = [NSString stringWithUTF8String:name];
        //通过KVC获取实例变量的值
        id value = [self valueForKey:key];
        //对此值，以实例变量名为key进行归档
        [acoder encodeObject:value forKey:key];
    }
    free(ivars);
}

//反归档
-(instancetype)lx_initWithCoder:(NSCoder *)aDecoder
{
    if (!aDecoder) return self;
    if (self == (id)kCFNull) return self;
    unsigned int count = 0; //创建count保存实力变量的个数
    Ivar *ivars = class_copyIvarList([self class], &count);
    //循环遍历实例变量链表
    for (int i = 0; i < count; i++) {
        //取出i对应位置的成员变量
        Ivar ivar = ivars[i];
        //查看成员变量
        const char *name = ivar_getName(ivar);
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        
        id value = [aDecoder decodeObjectForKey:key];
        //设置到成员变量身上
        [self setValue:value forKey:key];
    }
    free(ivars);
    return self;
}

@end
