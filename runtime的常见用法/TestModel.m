//
//  TestModel.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "TestModel.h"
#import "NSObject+LXEncode.h"

@implementation TestModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self lx_initWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self lx_encodeWithCoder:aCoder];
}

@end
