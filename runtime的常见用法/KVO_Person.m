//
//  KVO_Person.m
//  响应式编程
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "KVO_Person.h"
#import "NSObject+KVO.h"
#import <objc/runtime.h>
@implementation KVO_Person
-(void)setAge:(NSInteger)age
{
    [super setAge:age];
    id obsver =objc_getAssociatedObject(self, @"observer");
    id keypath =objc_getAssociatedObject(self, @"key");
    [obsver observeValueForKeyPath:keypath ofObject:nil change:nil context:nil];
}
@end
