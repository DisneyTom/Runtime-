//
//  NSObject+LXKVO.h
//  CKRuntime
//
//  Created by 梁晓龙 on 15/12/10.
//  Copyright © 2015年  梁晓龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LXKVO)

- (void)ck_addObserver:(id)observer ForKey:(NSString *)key WithBlock:(void(^)(id observedObject,NSString *key,id oldValue,id newValue))block;

- (void)ck_removeObserver:(id)observer ForKey:(NSString *)key;

@end
