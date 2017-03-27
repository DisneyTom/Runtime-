//
//  Person.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Person : NSObject
@property(nonatomic,copy)   NSString * name;
@property(nonatomic,assign) NSUInteger  age;
-(instancetype)initWithName:(NSString *)name Age:(NSUInteger)age;
@end
