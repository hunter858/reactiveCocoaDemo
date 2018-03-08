//
//  Son.h
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/2/27.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "Father.h"

@interface Son : Father

@property (nonatomic,copy) void(^testBlock)();

-(void)testRequest:(void(^)(NSDate *))block;

@end
