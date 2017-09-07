//
//  layerButton.h
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/9/4.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface layerButton : UIButton

@property (nonatomic,assign) CGFloat radius;

-(void)start;
-(void)stop;

@end
