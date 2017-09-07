//
//  layerButton.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/9/4.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "layerButton.h"

@interface layerButton ()
@property (nonatomic,strong)CAShapeLayer * circle;
@property (nonatomic,weak)NSTimer *timer;
@end


@implementation layerButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGRect rect = CGRectMake((width-self.radius)/2.0, (height-self.radius)/2.0, _radius, _radius);
    
    self.circle.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
}

-(CAShapeLayer *)circle{
    if (!_circle) {
        _circle = [CAShapeLayer layer];
        _circle.fillColor = [UIColor clearColor].CGColor;
        _circle.strokeColor = [UIColor whiteColor].CGColor;
        _circle.lineWidth = 1;
        _circle.opacity = 0;
        _circle.strokeEnd = _circle.strokeStart = 0;
        [self.layer addSublayer: _circle];
    }
    return _circle;
}

const NSTimeInterval duration = 1.2;


-(void)start{
 
    [self addAnimate];
    if (_timer) {
        [_timer invalidate];
    }
    
   self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addAnimate) userInfo:nil repeats:YES];
    
    [UIView animateWithDuration:0.15 animations:^{
        _circle.opacity = 1;
        [self setTitleColor: [UIColor colorWithWhite: 1 alpha: 0] forState: UIControlStateNormal];
    }];
    
}



-(void)stop{
    if (_timer) {
        [_timer invalidate];
    }
    
    [self.circle removeAllAnimations];
    [UIView animateWithDuration: 0.15 animations: ^{
        _circle.opacity = 0;
        [self setTitleColor: [UIColor colorWithWhite: 1 alpha: 1] forState: UIControlStateNormal];
    }];
}

-(void)addAnimate{
    CABasicAnimation *endAnimate =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimate.fromValue = @0;
    endAnimate.toValue = @1;
    endAnimate.duration = duration;
    [self.circle addAnimation:endAnimate forKey:@"end"];
    
    CABasicAnimation *startAnimate =[CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimate.beginTime = CACurrentMediaTime() +duration/2;
    startAnimate.fromValue = @0;
    startAnimate.toValue = @1;
    startAnimate.duration = duration/2;
    [self.circle addAnimation:startAnimate forKey:@"start"];
    
}

@end
