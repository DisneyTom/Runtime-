//
//  Chinese.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/17.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Chinese.h"
#import <objc/objc-runtime.h>

@implementation Chinese
 //动态方法解析。 实例方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    //创建实例方法的实现
    void(^resolveInstaceBlock)(id,SEL) =^(id objc_self, SEL objc_cmd)
    {
        NSLog(@"如果实例方法没有实现，则会执行这里的代码");
    };
    class_addMethod([self class], sel, imp_implementationWithBlock(resolveInstaceBlock), "v@:");
    /**
     *   相关参数：
         __unsafe_unretained Class cls  ： 给那个类添加实现方法
         SEL name： 无法识别的方法名
         IMP imp ：取出方法的实现（比如imp_implementationWithBlock(resolveInstaceBlock)，就是把resolveInstaceBlock的方法的实现取出来，给 name建立连接，让调用未实现的name方法时，通过resolveInstaceBLock的实现来进行信息的传递）
         const char *types ： 函数的类型编码（v->表示void无返回值 ， @ -> 表示id对象，：-> 表示Select ,顺序为第一个字母表示返回值， 第二个字母表示第一个参数，第二个字母表示第三个参数）；
     */
    printf("%s\n",sel_getName(sel));
    return YES;
}

//动态方法解析。 类方法
+(BOOL)resolveClassMethod:(SEL)sel
{
    //创建类方法的实现
    void(^resolveClassBlock)(id,SEL) =^(id objc_self,SEL objc_cmd)
    {
        NSLog(@"如果类方法没有实现，则会执行这里的代码");
    };
    class_addMethod(object_getClass([self class]), sel, imp_implementationWithBlock(resolveClassBlock), "v@:");
    /**
     *  与添加实例方法唯一不同的是 __unsafe_unretained Class cls 这个参数，这个我们通过 object_getClass([self class]) 来实现。
     */
    return YES;
}

/**
 *   runtime是怎么进行方法解析的？
     1. 假如我们的实例调用了一个没有实现的方法，比如 haha。当系统运行时，就会在本类中去对应方法的实现，如果没找到，就会调用
       +(BOOL)resolveInstanceMethod:(SEL)sel{
 
       }
       这个方法
     2. +(BOOL)resolveInstanceMethod:(SEL)sel。这个方法内部怎么实现动态解析方法特定的方法选标?
        +(BOOL)resolveInstanceMethod:(SEL)sel
       {
          if(sel =@selector(resolveThisMethodDynamically)){
              class_addMethod([self class],sel,(IMP)dynmicMethodIMP,"v@:")
          }
 
         return  [super resolveInstanceMethod:sel];
       }
      
       大意：假如我们的实例调用了一个没有实现的方法，就会来到这里 。当判断这个方法，需要我们动态解析的时候，就实现；当不是我们需要动态解析的方法的时候，就不做处理，交给父类，让父类做处理。
 */

@end
