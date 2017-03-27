//
//  Person+Category.h
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "Person.h"
#import "Student.h"
typedef void (^ActionBlock)(Student *stu);

//在分类中@property不会生成_变量，也不会实现getter和setter方法,也不会生成变量
@interface Person (Category)
/**
 *   系统类型
 */
@property(nonatomic,copy) NSString * hobby;
/**
 * 自定义类型
 */
@property(nonatomic,strong) Student  * stu;

/**
 *  block 类型
 */
@property(nonatomic,copy) ActionBlock  actionBlock;

/**
 *  SEL 类型
 */

-(void)disconnectTheAttribute;

@end
