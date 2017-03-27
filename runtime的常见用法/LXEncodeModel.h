//
//  LXEncodeModel.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXEncodeModel : NSObject<NSCoding>
@property(nonatomic,strong) NSString * name;
@property(nonatomic,assign) NSInteger  age;
@property(nonatomic,assign) NSInteger  range;
@end
