//
//  demo1Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/7/30.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo1Controller.h"
#import "ReactiveObjC.h"

@interface demo1Controller ()
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UILabel *label1;

@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UILabel *label2;


@property (strong, nonatomic) IBOutlet UIButton *button1;

@property (strong, nonatomic) IBOutlet UIView *redview;

@end

@implementation demo1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self demo1];
}

-(void)demo1{
    //1.监听textFild 的变化；
    __weak typeof(self) weakself=self;
    [[self.textField1 rac_textSignal] subscribeNext:^(id x) {
        
        weakself.label1.text = x;
    }];
    
    
    [[self.textField2 rac_textSignal] subscribeNext:^(id x) {
        
        weakself.label2.text = x;
    }];
}

-(void)demo2{
    //2.基于UIButton 的点击事件响应
    
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        NSLog(@"点击了button");
        
    }];
    
}



-(void)demo3{
    //3.合并信号1 和信号2 ，当2个textfield 的输入框都符合条件的时候，触发按钮；
    
    
    
    
}


-(void)demo4{
    //4.给我们的某个View添加一个手势动作，我们也可以用简单的RAC代码完成
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        
        NSLog(@"点击view 成功");
        
    }];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
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
