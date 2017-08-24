//
//  demo7Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/8/14.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo7Controller.h"
#import "ReactiveObjC.h"

const CGFloat width = 5.0;

@interface demo7Controller ()
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;
@property (strong, nonatomic) IBOutlet UIView *greenView1;



@end

@implementation demo7Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title =@"maskLayer 简单教程";
    
    __weak typeof(self) weakself=self;
    [[self.Button1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo1];
    }];
    [[self.Button2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo2];
    }];

    
}

-(void)demo1{
    
//    self.greenView.la
    
    //画一个圆
    //圆心是 （20，20）半径是 10 ）
    
    
    CGPoint centerPoint = CGPointMake(20, 20); //圆的中心坐标
    CGFloat width = 10;//圆的半径
    CAShapeLayer *layer =[CAShapeLayer layer];//创建一个图层
    layer.frame = CGRectMake(centerPoint.x-10, centerPoint.y-10, 2*width, 2*width);
    layer.fillColor = [[UIColor redColor]CGColor]; //填充色
    layer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:width startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath; //画圆的方法
    //三个参数分别是 开始点，结束点 ，关闭
    
    [self.greenView1.layer addSublayer:layer];
    
    
}
-(void)demo2{
    
    //创建4 个圆点
    //一个和原点一个宽度的开始动画
    CGPoint centerPoint = CGPointMake(20, 20); //圆的中心坐标
    CGFloat width = 10;//圆的半径
    

    
    CAShapeLayer *layer =[CAShapeLayer layer];//创建一个图层
    layer.frame = CGRectMake(centerPoint.x-10, centerPoint.y-10, 2*width, 2*width);
    layer.fillColor = [[UIColor redColor]CGColor]; //填充色
    layer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:width startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath; //画圆的方法
    //三个参数分别是 开始点，结束点 ，关闭
    [self.greenView1.layer addSublayer:layer];
    
    
}

-(CAShapeLayer*)getLayerWith:(CGPoint)centerPoint fillColor:(UIColor*)fillColor{
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.frame = CGRectMake(centerPoint.x-10, centerPoint.y-10, 2*width, 2*width);
    layer.fillColor = fillColor.CGColor;
    layer.path =[self radioPathWithPoint:centerPoint width:width];
    return layer;
}


-(CGPathRef)radioPathWithPoint:(CGPoint)centerPoint width:(CGFloat)width{
    return [UIBezierPath bezierPathWithArcCenter:centerPoint radius:width startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
}




-(void)demo3{
    
    
}
-(void)demo4{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
