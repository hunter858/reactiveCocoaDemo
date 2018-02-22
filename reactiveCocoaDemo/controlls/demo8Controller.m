//
//  demo8Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/9/7.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo8Controller.h"
#import "ReactiveObjC.h"
@interface demo8Controller ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;

@end

@implementation demo8Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = [UIImage imageNamed:@"photoFile"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [[self.Button1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo1];
    }];

    [[self.Button2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo2];
    }];
    [[self.Button3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo3];
    }];
    [[self.Button4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo4];
    }];
    [[self.Button5 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo5];
    }];
}


-(void)demo1{
    // coreImage 实现
    
    //1. 获取图片
    CIImage *ciimage = [[CIImage alloc]initWithImage:self.imageView.image];
    
    //2. 高斯模糊滤镜
    CIFilter *blurFilter =[CIFilter filterWithName:@"CIGaussianBlur"];
    
    [blurFilter setValue:ciimage forKey:kCIInputImageKey];
    
    //3.设置模糊程度
    [blurFilter setValue:@(20) forKey:@"inputRadius"];
    
    //4. 输出图片
    CIImage * outCIImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    //5. 获取图片上下文
    CIContext *context  = [CIContext contextWithOptions:nil];
    
    //6. 从数据流中取出图片
    CGImageRef CGimage  = [context createCGImage:outCIImage fromRect:[outCIImage extent]];
    
    NSLog(@"iamgebouds %f- %f ",self.imageView.bounds.size.width,self.imageView.bounds.size.height);
    NSLog(@"cgrect %f -%f",[outCIImage extent].size.width,[outCIImage extent].size.height);
    
    //7. 通过CGimage 创建Image
    UIImage *resultImage =[UIImage imageWithCGImage:CGimage];
    
    
    self.imageView.image = resultImage;

    
}

-(void)demo2{
    //UIVisualEffectView只适用用户iOS 8
    
    UIImage *defaultImage =  [UIImage imageNamed:@"photoFile"];
    self.imageView.image = defaultImage;
    
    
    /*
     UIBlurEffectStyleExtraLight, //白色偏多的毛玻璃
     UIBlurEffectStyleLight, //接近原图的毛玻璃效果（大致轮廓）
     UIBlurEffectStyleDark,  //黑色偏多的毛玻璃
     UIBlurEffectStyleExtraDark , 适用于TVos 系统
     UIBlurEffectStyleRegular,  // 接近原图效果的毛玻璃 和 UIBlurEffectStyleLight类似
     UIBlurEffectStyleProminent,
     */
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectView =  [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    
    //加上毛玻璃效果
    [self.imageView addSubview:effectView];
    
    
}
-(void)demo3{
//    /创建信号量/
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    /创建全局并行/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件A");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印i %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件B");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印j %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件C");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印k %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件D");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印l %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        //四个请求对应四次信号等待/
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"处理事件E");
    });
}
-(void)demo4{
    
}
-(void)demo5{
    
}
-(void)demo6{
    
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
