//
//  demo4Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/8/11.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo4Controller.h"

@interface demo4Controller ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation demo4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
//    [self testGCD];
    [self createPan];
}

-(void)initViews{
    //1.放一个lable
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(7, 50, 400, 400)];
    label.text = @"🙏 谢谢惠顾 🙏";
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithRed:(arc4random()%173)/346.0 + 0.5 green:(arc4random()%173)/346.0 + 0.5  blue:(arc4random()%173)/346.0 + 0.5  alpha: 1];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

    //2.放一张蒙版图
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 50, 400, 400)];
    self.imageView.image = [UIImage imageNamed:@"placeImage"];
    [self.view addSubview:self.imageView ];
    
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint centerPoint =[touch locationInView:self.imageView];
    //获取触摸点
    
    CGRect rect = CGRectMake(centerPoint.x, centerPoint.y, 35, 35);

    //获取范围；
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0 );
    //画版
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //把imageview 的layer 映射到上下文中；
    [self.imageView.layer renderInContext:ref];
    
    CGContextClearRect(ref, rect);
    //获取图片  重新绘画好的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = image;
    
    
}


-(void)testGCD{
    
    NSLog(@"1");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_notify(group, queue, ^{
           NSLog(@"2");
    });
    
    dispatch_group_enter(group);
    dispatch_sync(queue, ^{
           NSLog(@"3");
    });
    
    dispatch_group_leave(group);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
    });

    NSLog(@"4");
    NSLog(@"5");
    
}


-(void)createPan{
    
    CGRect InFrame =CGRectMake(0, 500, 100, 100);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blackColor]CGColor]);
    CGContextAddEllipseInRect(ctx, InFrame);
    CGContextMoveToPoint(ctx, CGRectGetMinX(InFrame), CGRectGetMinY(InFrame));
    CGContextMoveToPoint(ctx, CGRectGetMaxX(InFrame), CGRectGetMidY(InFrame));
    CGContextMoveToPoint(ctx, CGRectGetMidX(InFrame), CGRectGetMidY(InFrame));
    CGContextMoveToPoint(ctx, CGRectGetMidX(InFrame), CGRectGetMinY(InFrame));
    CGContextStrokePath(ctx);
    
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
