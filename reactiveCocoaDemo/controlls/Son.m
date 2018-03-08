//
//  Son.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/2/27.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "Son.h"

@implementation Son

-(id)init{
    
    
    /*
     
     */
    
    self = [super init];
    if (self) {
        NSLog(@"[self class]== %@",NSStringFromClass([self class]));
        NSLog(@"[super class]== %@",NSStringFromClass([super class]));
    }
    return self;
}

-(void)testRequest:(void (^)(NSDate *))block{
    
    if (block!=nil) {
        block([NSDate new]);
    }
    
    
}


@end
