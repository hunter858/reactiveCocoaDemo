//
//  demo7Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/8/14.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo7Controller.h"
#import "ReactiveObjC.h"
#import "layerButton.h"

const CGFloat width = 5.0;


// 启始坐标的点
const CGFloat startPointX = 40;
const CGFloat startPointY = 40;

#define topPointColor    [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor
#define leftPointColor   [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0].CGColor
#define bottomPointColor [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0].CGColor
#define rightPointColor  [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0].CGColor

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


//---demo5 属性
@property (nonatomic,strong)CAShapeLayer *layer1;
@property (nonatomic,strong)CAShapeLayer *layer2;
@property (nonatomic,strong)CAShapeLayer *layer3;
@property (nonatomic,strong)CAShapeLayer *layer4;
@property (nonatomic,strong)CAShapeLayer *line;


//---demo9 属性

@property (nonatomic,strong)CAShapeLayer *circle;
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
    CGFloat width = 30;//圆的半径
    CAShapeLayer *layer =[CAShapeLayer layer];//创建一个图层
    layer.frame = CGRectMake(centerPoint.x-10, centerPoint.y-10, 2*width, 2*width);
    layer.fillColor = [[UIColor redColor]CGColor]; //填充色
    layer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:width startAngle:0 endAngle:M_PI*1.5 clockwise:YES].CGPath; //画圆的方法
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
    self.layer1 = [self updateLayer:layer1 WithPoint:centerPoint1 color:[UIColor redColor]];
    [self.greenView1.layer addSublayer:layer1];
    
    CAShapeLayer *layer2 =[CAShapeLayer layer];
    CGPoint centerPoint2 = CGPointMake(startPointX-ladingWidth, startPointY+ladingWidth);
    
    self.layer2 = [self updateLayer:layer2 WithPoint:centerPoint2 color:[UIColor greenColor]];
    [self.greenView1.layer addSublayer:layer2];
    
    CAShapeLayer *layer3 =[CAShapeLayer layer];
    CGPoint centerPoint3 = CGPointMake(startPointX+ladingWidth, startPointY+ladingWidth);
    self.layer3 = [self updateLayer:layer3 WithPoint:centerPoint3 color:[UIColor blueColor]];
    [self.greenView1.layer addSublayer:layer3];
    
    CAShapeLayer *layer4 =[CAShapeLayer layer];
    CGPoint centerPoint4 = CGPointMake(startPointX, startPointY+2*ladingWidth);
    self.layer4 = [self updateLayer:layer4 WithPoint:centerPoint4 color:[UIColor yellowColor]];
    [self.greenView1.layer addSublayer:layer4];
    
    // 4个颜色不同的点，创建完成了
    // 画一个线 ，可以围绕四个点移动的
    
    CAShapeLayer *line =[[CAShapeLayer alloc]init];
    line.frame = self.greenView1.bounds;
    line.lineWidth = width*2;
    line.lineCap = kCALineCapRound;
    //lineCapStyle：path端点样式
    //kCGLineCapButt：无端点
    //kCGLineCapRound：圆形端点
    //kCGLineCapSquare：方形端点
    //该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
    line.lineJoin = kCALineJoinRound;
    //lineJoinStyle：拐角样式
    //kCGLineJoinMiter：尖角
    //kCGLineJoinRound：圆角
    //kCGLineJoinBevel：缺角
    
    line.fillColor = [UIColor darkGrayColor].CGColor;
    line.strokeColor = [UIColor darkGrayColor].CGColor;
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path moveToPoint:centerPoint1];
    
    [path addLineToPoint:centerPoint2];
    [path moveToPoint:centerPoint2];
    
    [path addLineToPoint:centerPoint3];
    [path moveToPoint:centerPoint3];
    
    [path addLineToPoint:centerPoint4];
    [path moveToPoint:centerPoint4];
    
    line.path = path.CGPath;
    line.strokeStart = 0.0;
    line.strokeEnd = 0.0 ;
    self.line = line;
//    [layer1 insertSublayer:self.line above:layer1];
    
    __weak typeof(self) weakself=self;
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        weakself.line.fillColor =[UIColor redColor].CGColor;
//        weakself.line.strokeColor = [UIColor redColor].CGColor;
//        weakself.line.strokeStart = 0.0;
//        weakself.line.strokeEnd = 0.25 ;
//        
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        weakself.line.fillColor =[UIColor greenColor].CGColor;
//        weakself.line.strokeColor = [UIColor greenColor].CGColor;
//        weakself.line.strokeStart = 0.25;
//        weakself.line.strokeEnd = 0.5 ;
//        
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        weakself.line.fillColor =[UIColor blueColor].CGColor;
//        weakself.line.strokeColor = [UIColor blueColor].CGColor;
//        weakself.line.strokeStart = 0.5;
//        weakself.line.strokeEnd = 0.75 ;
//        
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        weakself.line.fillColor =[UIColor yellowColor].CGColor;
//        weakself.line.strokeColor = [UIColor yellowColor].CGColor;
//        weakself.line.strokeStart = 0.75;
//        weakself.line.strokeEnd = 1 ;
//        
//    }];

    
    UISlider *slider =[[UISlider alloc]initWithFrame:CGRectMake(0, self.greenView1.bounds.size.height -5, self.greenView1.bounds.size.width, 5)];
    
    [self.greenView1 addSubview:slider];
    
    [RACObserve(slider, value)subscribeNext:^(id  _Nullable x) {
        NSNumber *number = x;
        NSLog(@"number-  %@",x);
        [weakself setLineLayerStrokeWithProgress:[number floatValue]];
        
    }];
    
    
}


- (void)setLineLayerStrokeWithProgress:(CGFloat)progress {
    float startProgress = 0.f;
    float endProgress = 0.f;
    
    const CGFloat SURefreshPullLen     = 55.0;
    //隐藏
    if (progress < 0) {
        self.layer1.opacity = 0.f;
        [self adjustPointStateWithIndex:0];
    }
    else if (progress >= 0 && progress < (SURefreshPullLen - 40)) {
        self.layer1.opacity = progress / 20;
        [self adjustPointStateWithIndex:0];
    }
    else if (progress >= (SURefreshPullLen - 40) && progress < SURefreshPullLen) {
        self.layer1.opacity = 1.0;
        //大阶段 0 ~ 3
        NSInteger stage = (progress - (SURefreshPullLen - 40)) / 10;
        //大阶段的前半段
        CGFloat subProgress = (progress - (SURefreshPullLen - 40)) - (stage * 10);
        if (subProgress >= 0 && subProgress <= 5) {
            [self adjustPointStateWithIndex:stage * 2];
            startProgress = stage / 4.0;
            endProgress = stage / 4.0 + subProgress / 40.0 * 2;
        }
        //大阶段的后半段
        if (subProgress > 5 && subProgress < 10) {
            [self adjustPointStateWithIndex:stage * 2 + 1];
            startProgress = stage / 4.0 + (subProgress - 5) / 40.0 * 2;
            if (startProgress < (stage + 1) / 4.0 - 0.1) {
                startProgress = (stage + 1) / 4.0 - 0.1;
            }
            endProgress = (stage + 1) / 4.0;
        }
    }
    else {
        self.layer1.opacity = 1.0;
        [self adjustPointStateWithIndex:NSIntegerMax];
        startProgress = 1.0;
        endProgress = 1.0;
    }
    
    //    NSLog(@"startProgress:%f---endProgress:%f",startProgress,endProgress);
    self.line.strokeStart = startProgress;
    self.line.strokeEnd = endProgress;
}

- (void)adjustPointStateWithIndex:(NSInteger)index { //index : 小阶段： 0 ~ 7
    self.layer2.hidden = index > 1 ? NO : YES;
    self.layer3.hidden = index > 3 ? NO : YES;
    self.layer4.hidden = index > 5 ? NO : YES;
    self.line.strokeColor = index > 5 ? rightPointColor : index > 3 ? bottomPointColor : index > 1 ? leftPointColor : topPointColor;
}



-(void)demo6{
    
    
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.greenView1.frame.size.height-40, 40, 40)];
    imageview.image = [UIImage imageNamed:@"profile"];
    [self.greenView1 addSubview:imageview];
    
    
    //动画 从左下角 飞到 右上角
    CABasicAnimation *flyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    flyAnimation.toValue = [NSNumber numberWithFloat:M_PI*5];
    flyAnimation.duration = 1.0 ;
    flyAnimation.cumulative = YES;
    flyAnimation.repeatCount = 0 ;
    
    
    //执行动画
    // 让旋转动画，稍微晚一点执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [imageview.layer addAnimation:flyAnimation forKey:@"rotationAnimation"];
        
    });
    
    [UIView animateWithDuration:1.0 animations:^{
        
        imageview.frame = CGRectMake(self.greenView1.bounds.size.width-80, 0, 80, 80);
    }completion:^(BOOL finished) {
       
        //[imageview removeFromSuperview];
    }];
    
    
    
    
}

-(void)demo7{
    
    
    UIView *view1 =[self createViewWithColor:[UIColor redColor] frame:CGRectMake(0, 10, 10, 10)];
    UIView *view2 =[self createViewWithColor:[UIColor redColor] frame:CGRectMake(0, 30, 10, 10)];
    UIView *view3 =[self createViewWithColor:[UIColor redColor] frame:CGRectMake(0, 50, 10, 10)];
    UIView *view4 =[self createViewWithColor:[UIColor redColor] frame:CGRectMake(0, 70, 10, 10)];
    
    [self.greenView1 addSubview:view1];
    [self.greenView1 addSubview:view2];
    [self.greenView1 addSubview:view3];
    [self.greenView1 addSubview:view4];
    
    
    
    //UIViewAnimationOptionCurveEaseInOut   //先加速后减速，默认
    //UIViewAnimationOptionCurveEaseIn      //由慢到快
    //UIViewAnimationOptionCurveEaseOut     //由快到慢
    //UIViewAnimationOptionCurveLinear      //匀速
    
    
    
    // UIViewAnimationOptionCurveEaseInOut
    
    [UIView animateWithDuration: 0.5 delay: 0 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
       
        [view1 setCenter:CGPointMake(view1.center.x+150,view1.center.y)];
        
    } completion: nil];

    
    //UIViewAnimationOptionCurveEaseInOut
    [UIView animateWithDuration: 0.5 delay: 0 options: UIViewAnimationOptionCurveEaseIn animations: ^{
        
        [view2 setCenter:CGPointMake(view2.center.x+150,view2.center.y)];
        
    } completion: nil];
    
    //UIViewAnimationOptionCurveEaseOut
    [UIView animateWithDuration: 0.5 delay: 0 options: UIViewAnimationOptionCurveEaseOut animations: ^{
        
        [view3 setCenter:CGPointMake(view3.center.x+150,view3.center.y)];
        
    } completion: nil];
    
    //UIViewAnimationOptionCurveLinear
    [UIView animateWithDuration: 0.5 delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
        
        [view4 setCenter:CGPointMake(view4.center.x+150,view4.center.y)];
        
    } completion: nil];
    
    
    
    
}

-(UIView *)createViewWithColor:(UIColor *)color frame:(CGRect)frame{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    [view setBackgroundColor:color];
    
    return  view;
}

-(void)demo8{
    
    //翻转动画效果
    
    //UIViewAnimationOptionTransitionNone            //没有效果，默认
    //UIViewAnimationOptionTransitionFlipFromLeft    //从左翻转效果
    //UIViewAnimationOptionTransitionFlipFromRight   //从右翻转效果
    //UIViewAnimationOptionTransitionCurlUp          //从上往下翻页
    //UIViewAnimationOptionTransitionCurlDown        //从下往上翻页
    //UIViewAnimationOptionTransitionCrossDissolve   //旧视图溶解过渡到下一个视图
    //UIViewAnimationOptionTransitionFlipFromTop     //从上翻转效果
    //UIViewAnimationOptionTransitionFlipFromBottom  //从上翻转效果
    
    
    
}

-(void)demo9{
    
    //旋转动画小圆圈
    layerButton *button =[[layerButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setCenter:self.greenView1.center];
    [button setRadius:30];
    
    [button setBackgroundColor:[UIColor orangeColor]];
    [self.greenView1 addSubview:button];
    

    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [button start];
    }];


    
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
