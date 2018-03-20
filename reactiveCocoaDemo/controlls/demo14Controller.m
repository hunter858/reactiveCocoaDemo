//
//  demo14Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/20.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "demo14Controller.h"

#import "AppDelegate.h"

@interface demo14Controller ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,assign) NSInteger selectCount;
@end

@implementation demo14Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image =[UIImage imageNamed:@"setting_image"];
    [self addLayer];
    // Do any additional setup after loading the view from its nib.
}

-(void)addLayer{
    
    
//    self.imageView.alpha = 0.8;
//
//    CGFloat width  =[UIScreen mainScreen].bounds.size.width;
//    CGFloat height  =[UIScreen mainScreen].bounds.size.height;
//    UIBezierPath *path  = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, 50)];
////    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:5]];
//    CAShapeLayer *shaplayer  = [CAShapeLayer layer];
//    shaplayer.path = path.CGPath;
//    self.imageView.layer.mask =shaplayer;
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [bgView addGestureRecognizer:tap];
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
//    // 这里添加第二个路径 (这个是圆)
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width - 30, 100) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
//    // 这里添加第二个路径 (这个是矩形)
//
//    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width/2.0-1, 234, frame.size.width/2.0+1, 55) cornerRadius:5] bezierPathByReversingPath]];
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = path.CGPath;
//    //shapeLayer.strokeColor = [UIColor blueColor].CGColor;
//    [bgView.layer setMask:shapeLayer];
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width -300,72,270, 137)];
//    [imageView setBackgroundColor:[UIColor blackColor]];
//    imageView.alpha = 0.5;
//    [bgView addSubview:imageView];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [window addSubview:bgView];
    
    
    self.selectCount = 1;

}


- (void)sureTapClick:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    
    
   

    
    view.layer.sublayers =nil;
//    [view.layer addSublayer:[self getScreenBezierPathWithTag:self.selectCount]];
    
    view.layer.mask =[self getScreenBezierPathWithTag:self.selectCount];
    self.selectCount++;
    if (self.selectCount>5) {
        [UIView animateWithDuration:0.3 animations:^{
            [view removeFromSuperview];
            [view removeGestureRecognizer:tap];
        }];
    }

}

-(CAShapeLayer *)getScreenBezierPathWithTag:(NSInteger)tag{
    NSLog(@"selectCount:%ld",self.selectCount);
    CGRect frame = [UIScreen mainScreen].bounds;
    UIBezierPath *bezier =[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:0];
    UIBezierPath *path  =[UIBezierPath bezierPathWithRect:frame];
    
    
    CGSize size = CGSizeMake(100, 55);
    
    
    if (self.selectCount==1) {
        
        //左上角
        
        
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width/2.0-1, 234, frame.size.width/2.0+1, 55) cornerRadius:5] bezierPathByReversingPath]];
    }
    else if(self.selectCount==2){
        //右上角
        
        
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width-size.width, 0, size.width, size.height) cornerRadius:5] bezierPathByReversingPath]];
    }
    else if(self.selectCount==3){
        //左下角
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, frame.size.height-size.height, size.width, size.height) cornerRadius:5] bezierPathByReversingPath]];
    }
    else if(self.selectCount==4){
        //右下角
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width-size.width, frame.size.height-size.height, size.width, size.height) cornerRadius:5] bezierPathByReversingPath]];
    }
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = path.CGPath;
    
    return shapLayer;
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
