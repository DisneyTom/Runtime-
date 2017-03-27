//
//  Person+Category.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Person+Category.h"
#import <objc/runtime.h>

@implementation Person (Category)
//定义常量。必须是c语言字符
/**
 *  由于分类中不允许定义变量，所以只能通过c语言相关基本类型存储相应的外界传过来的数据，存储起来。
 */
static char * PersonHobbyKey ="PersonNameKey";
static char * PersonStudent  ="PersonStudent";
static char * PersonBlock    ="PersonBlock";


/**  涉及到runtime的两个方法
  1.objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy) //创建关联
   相关参数：
    id object 给哪个对象的属性赋值
    const void *key 属性对应的key
    id value  设置属性值为value
    objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 
    OBJC_ASSOCIATION_ASSIGN;            //assign策略
    OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
    OBJC_ASSOCIATION_RETAIN_NONATOMIC;  //retain策略
 
    OBJC_ASSOCIATION_RETAIN;
    OBJC_ASSOCIATION_COPY;//

  2.objc_getAssociatedObject(id object, const void *key) ／／获取到关联
    相关参数（参考1中的参数）：
     id object 被关联的对象
     const void *key 属性对应的key
 
 
  3.objc_removeAssociatedObjects(id object） ／／断开关联
    相关参数：
      id object 被关联的对象
      
    注意：objc_removeAssociatedObjects（id object） 是断开所有与对象object关联的对象。 
         一般不建议使用， 替代方案
          断开关联是使用objc_setAssociatedObject函数，传入nil值即可
          例：
         objc_setAssociatedObject(array, &overviewKey, nil, OBJC_ASSOCIATION_ASSIGN);
 
 */
/**
 * hobby 属性
 */
-(void)setHobby:(NSString *)hobby{
    objc_setAssociatedObject(self, PersonHobbyKey, hobby, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)hobby
{
    
    return objc_getAssociatedObject(self, PersonHobbyKey);
}

/**
 * stu 属性
 */
-(void)setStu:(Student *)stu{
    objc_setAssociatedObject(self, PersonStudent, stu, OBJC_ASSOCIATION_RETAIN);
}

-(Student*)stu
{
   return   objc_getAssociatedObject(self, PersonStudent);
}
/**
 * block 类型
 */
-(void)setActionBlock:(ActionBlock)actionBlock
{
    objc_setAssociatedObject(self, PersonBlock, actionBlock, OBJC_ASSOCIATION_RETAIN);
}

-(ActionBlock)actionBlock
{
    return  objc_getAssociatedObject(self, PersonBlock);
}


/**
 * 断开关联属性
 */
-(void)disconnectTheAttribute{
//    objc_removeAssociatedObjects(self); //会断开所有关联的属性，一般不用；
    objc_setAssociatedObject(self, PersonHobbyKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
