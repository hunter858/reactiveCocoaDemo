//
//  commentView.h
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/9.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentView : UIView


-(instancetype)initWithFrame:(CGRect)frame;

- (void)setButtonWithNumber:(NSInteger )number;

@property (nonatomic,readonly,assign) NSInteger selectIndex;


@end
