//
//  LXEncodeModel.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LXEncodeModel.h"
#import <objc/runtime.h>
@implementation LXEncodeModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self =[super init];
    if (self) {
        unsigned int count =0;
        Ivar * ivars =class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            const char * name =ivar_getName(ivars[i]);
            NSString * key =[NSString stringWithUTF8String:name];
            id value =[aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count =0;
    Ivar * ivars =class_copyIvarList([self class], &count);
    for (int i =0; i<count; i++) {
        const char * name =ivar_getName(ivars[i]);
        NSString * key =[NSString stringWithUTF8String:name];
        id value =[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}
@end
