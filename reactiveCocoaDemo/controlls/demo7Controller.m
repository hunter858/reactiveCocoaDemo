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


// 启始坐标的点
const CGFloat startPointX = 40;
const CGFloat startPointY = 40;

@interface demo7Controller ()
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;
@property (strong, nonatomic) IBOutlet UIButton *Button6;
@property (strong, nonatomic) IBOutlet UIButton *Button7;
@property (strong, nonatomic) IBOutlet UIButton *Button8;
@property (strong, nonatomic) IBOutlet UIButton *Button9;
@property (strong, nonatomic) IBOutlet UIButton *Button10;






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

    [[self.Button3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo3];
    }];
    [[self.Button4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo4];
    }];
    [[self.Button5 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo5];
    }];
    [[self.Button6 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo6];
    }];
    [[self.Button7 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo7];
    }];

    [[self.Button8 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo8];
    }];
    [[self.Button9 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo9];
    }];
    [[self.Button10 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo10];
    }];
}

-(void)demo1{
    
    [self clearLayer];
    
    
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
    [self clearLayer];

    
    
    //创建4 个圆点
    //         *
    //
    //     *       *
    //
    //         *

    
    //一个和原点一个宽度的开始动画 （）
    
    //水平 和垂直间隔距离是 8 吧
    const CGFloat ladingWidth = 8;

    
    CGPoint centerPoint1 = CGPointMake(startPointX, startPointY); //圆的中心坐标
    CAShapeLayer *layer1 =[CAShapeLayer layer];//创建一个图层
    layer1 = [self updateLayer:layer1 WithPoint:centerPoint1 color:[UIColor redColor]];
    [self.greenView1.layer addSublayer:layer1];
    
    CAShapeLayer *layer2 =[CAShapeLayer layer];
    CGPoint centerPoint2 = CGPointMake(startPointX-ladingWidth, startPointY+ladingWidth);
    
    layer2 = [self updateLayer:layer2 WithPoint:centerPoint2 color:[UIColor greenColor]];
    [self.greenView1.layer addSublayer:layer2];
    
    CAShapeLayer *layer3 =[CAShapeLayer layer];
    CGPoint centerPoint3 = CGPointMake(startPointX+ladingWidth, startPointY+ladingWidth);
    layer3 = [self updateLayer:layer3 WithPoint:centerPoint3 color:[UIColor blueColor]];
    [self.greenView1.layer addSublayer:layer3];
    
    CAShapeLayer *layer4 =[CAShapeLayer layer];
    CGPoint centerPoint4 = CGPointMake(startPointX, startPointY+2*ladingWidth);
    layer4 = [self updateLayer:layer4 WithPoint:centerPoint4 color:[UIColor yellowColor]];
    [self.greenView1.layer addSublayer:layer4];
    
    // 4个颜色不同的点，创建完成了
    
    
    
    
}

-(CAShapeLayer *)updateLayer:(CAShapeLayer *)layer WithPoint:(CGPoint)point color:(UIColor *)color{
    layer.frame = CGRectMake(point.x-10, point.y-10, 2*width, 2*width);
    layer.fillColor = color.CGColor; //填充色
    layer.path = [UIBezierPath bezierPathWithArcCenter:point radius:width startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath; //画圆的方法
    return layer;
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
    [self clearLayer];
    
    
    //画一个矩形 ，线用黑色 表示，中间 空白
    
    CAShapeLayer *layer =[[CAShapeLayer alloc]init];
    layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(startPointX, startPointY, 40, 30)].CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.greenView1.layer addSublayer:layer];
    
}
-(void)demo4{
    [self clearLayer];
    
    //画一个带圆角的矩形
    CAShapeLayer *layer =[[CAShapeLayer alloc]init];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(startPointX, startPointY, 60, 30) cornerRadius:5 ].CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.greenView1.layer addSublayer:layer];
}


-(void)demo5{

  
    

}


-(void)demo6{
    
    
}

-(void)demo7{
    
    
}

-(void)demo8{
    
    
}
-(void)demo9{
    
    
}
-(void)demo10{
    
    [self clearLayer];
}


-(void)clearLayer{
    //清除layer 已经存在的layer
    //用一个新的涂层，覆盖在上面，
    CAShapeLayer *newlayer =[[CAShapeLayer alloc]init];
    newlayer.path = [UIBezierPath bezierPathWithRect:self.greenView1.bounds].CGPath;
    newlayer.fillColor = self.greenView1.backgroundColor.CGColor;
    [self.greenView1.layer addSublayer:newlayer];
    
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
