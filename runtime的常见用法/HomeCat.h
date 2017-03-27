//
//  HomeCat.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/17.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeralCat.h"
@interface HomeCat : NSObject
//接收转发消息的对象
@property(nonatomic) FeralCat* feralCat;
@end
