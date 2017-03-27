//
//  Person.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Person.h"

@implementation Person
-(instancetype)initWithName:(NSString *)name Age:(NSUInteger)age
{    if(self =[super init]){
         self.name = name;
         self.age =age;
     }
    return self;
}

@end
