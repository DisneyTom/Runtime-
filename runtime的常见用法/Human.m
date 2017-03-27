//
//  Human.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Human.h"
#import <objc/message.h>
@implementation Human
void run (id self, SEL _cmd,  NSNumber *metre) {
    NSLog(@"跑了%@米",metre);
}

//当调用一个未实现的方法来到这里
+(BOOL) resolveInstanceMethod:(SEL)sel{
    if (sel ==NSSelectorFromString(@"run:")) {
        class_addMethod(self, @selector(run:),run,"v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
@end
