//
//  CATest.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@protocol CATestDelegate <NSObject>
-(void)cATestDelegateDidTouch;
@end
@interface CATest : CAAnimation
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * hobby;
-(void)getAnAttributeList;
-(void)getAnMethodList;
-(void)getAnIvarList;
-(void)getAnProtocalList;
@end
