//
//  TestModel.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject<NSObject>
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) int num;
@property(nonatomic,assign) NSRange range;
@property(nonatomic,strong) NSDate *date;

@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) NSArray *array;
@end
