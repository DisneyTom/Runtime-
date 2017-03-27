//
//  HomeCat.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/17.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HomeCat.h"

@implementation HomeCat
//没有实现学习的方法
//实现消息转发的方法

/**
 *  1.当调用HomeCat不存在的方法时，会来到这里。 假如我们想要进行消息转发，就要在想要转发的对象中取出对应的方法签名。
     
    总结： 
       * -(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector  感觉这个方法就是在没找到本类要执行的方法时
       不管是从其他类，还是本类的父类，目的都是为了获取相应的方法签名。
       *。NSMethodSignature  方法签名
 
 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector ==@selector(learn)) { //选定时某个方法时才转发
        return [self.feralCat methodSignatureForSelector:aSelector]; //取出feralCat 中的learn方法
    }
    return [super methodSignatureForSelector:aSelector]; //假如不是选定某个方法，就让它继续在父类的方法中继续查找。
}

/**
 *  2.假如取到方法签名就会来到这里将这个消息当成参数传到这里来，同时设定target为self.feralCat;
      总结：-(void)forwardInvocation:(NSInvocation *)anInvocation 作用就是在上面那个方法找到方法签名之后，它把相应的消息，转发给其他类或者自己的父类。
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (anInvocation.selector ==@selector(learn)) {
        [anInvocation invokeWithTarget:self.feralCat];
    }
}
@end
