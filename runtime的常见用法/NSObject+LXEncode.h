//
//  NSObject+LXEncode.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LXEncode)
-(instancetype)lx_initWithCoder:(NSCoder *)aDecoder;
-(void)lx_encodeWithCoder:(NSCoder *)acoder;
@end
