//
//  Teacher.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Teacher.h"
@interface Teacher()
@property(nonatomic,copy) NSString * name;
@end

@implementation Teacher
-(instancetype)initWithName:(NSString *)name
{
    if (self =[super init]) {
        self.name =name;
    }
    return self;
}
@end
