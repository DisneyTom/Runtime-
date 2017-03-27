//
//  ViewController.m
//  runtime的常见用法
//
//  Created by 梁晓龙 on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Category.h"
#import "CATest.h"
#import "Teacher.h"
#import "GithubUser.h"
#import "NSObject+Model.h"
#import "Human.h"
#import "Chinese.h"
#import "FeralCat.h"
#import "HomeCat.h"
#import "NSObject+KVO.h"
#import <objc/message.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [self verificationTwo];
}
//


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
   NSLog(@"age==>");
}



//动态添加方法
-(void)verificationSix
{
    Chinese * hum =[[Chinese alloc]init];
    [hum performSelector:@selector(run:) withObject:@10];
}

//分类添加属性
-(void)verificationOne{
    [super viewDidLoad];
    Person * person =[[Person alloc]initWithName:@"胡晓" Age:15];
    person.hobby =@"撸代码";
    person.stu =[[Student alloc]init];
    person.stu.name =@"程序员";
    person.actionBlock=^(Student * stu){
        NSLog(@"block回掉");
    };
    NSLog(@"%@喜欢%@,他的土徒弟是%@",person.name,person.hobby,person.stu.name);
}
//消息的转发
-(void)verificationTwo{
    HomeCat * homeCat =[HomeCat new];
    homeCat.feralCat =[FeralCat new];
    [homeCat performSelector:@selector(learn)];
}

-(void)verificationThree{
    CATest *  test = [CATest new];
    [test getAnMethodList]; //方法列表
    [test getAnIvarList];   //变量列表
    [test getAnProtocalList]; //协议列表
    [test getAnAttributeList]; //属性列表
}

-(void)verificationFour
{
   
    Teacher * teacher =[[Teacher alloc]initWithName:@"毛泽东"];
    
    /**
     * 通过KVC 方法实现
     */
    //访问私有属性
    NSString * name =[teacher  valueForKey:@"name"];
    NSLog(@"KVC修改之前teacher->name:%@",name);
    //修改私有属性
    [teacher setValue:@"孙中山" forKey:@"name"];
    name =[teacher  valueForKey:@"name"];
    NSLog(@"KVC修改之后teacher->name：%@",name);
    
    
    /**
     * 通过Runtime的方式实现
     */
    NSString * teacherName;
    Ivar  m_name =NULL;
    unsigned int count =0;
    Ivar * members =class_copyIvarList([Teacher class], &count);
    for (int i =0; i<count; i++) {
        Ivar  var =members[i];
        const char *memberName = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"%s----%s", memberName, memberType);
        if(strcmp(memberName, "_name") == 0) {
            m_name = members[i];
        }
    }
    
    //访问私有属性的值
    teacherName = (NSString *)object_getIvar(teacher, m_name);
    NSLog(@"Runtime-修改前teacherName:%@",teacherName);
    
    //访问私有属性的值
    object_setIvar(teacher, m_name, @"炎黄子孙");
//  teacherName = (NSString *)object_getIvar(teacherName, m_name);
    NSLog(@"Runtime-修改后teacherName:%@",teacherName);
}

-(void)verificationfive{
#pragma mark - Private Methods
    NSString *githubAPI = @"https://api.github.com/users/Tuccuay";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:githubAPI]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                
                                                // 因为 Github 的 API 中有一个字段是 id
                                                // 而 id 在 Objective-C 中已经被占用
                                                // GithubUser *tuccuay = [GithubUser modelWithDict:dict];
                                                
                                                // 所以把 id 替换成 ID
                                                GithubUser *tuccuay = [GithubUser modelWithDict:dict updateDict:@{@"ID":@"id"}];
                                                
                                                
                                                // 给下面的 NSLog 打个断点
                                                // 从调试器里能看见上面的 tuccuay 模型已经转好了
                                                NSLog(@"mew~");
                                            }];
    [task resume];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
