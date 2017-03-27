//
//  CATest.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CATest.h"
#import <objc/runtime.h>
unsigned int count;
@implementation CATest
/**
 *  仅能获取本类中
 */

-(void)getAnAttributeList
{
    //获取类属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取协议属性
    objc_property_t * protocolPropertyList =protocol_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char * propertyName =property_getName(protocolPropertyList[i]);
        NSLog(@"propertyProtocol---->%@",[NSString stringWithUTF8String:propertyName]);
    }
    
    

}
-(void)getAnMethodList
{
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
}
-(void)getAnIvarList
{
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
}
-(void)getAnProtocalList
{
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}


@end
