//
//  demo10Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/9/7.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo10Controller.h"
#import "ReactiveObjC.h"
#import "Son.h"

typedef  void(^myBlock)();

@interface demo10Controller ()


@property (copy,nonatomic) myBlock myBlock;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;
@property (strong, nonatomic) IBOutlet UIButton *Button6;
@property (strong, nonatomic) IBOutlet UIButton *Button7;
@property (strong, nonatomic) IBOutlet UIButton *Button8;

@end

@implementation demo10Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakself = self;
    
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
    
    
    
    
}

-(void)demo1{
    Son *son_one = [[Son alloc]init];
    
    
}
-(void)demo2{
    /*
     调用系统的api 能使用控制器 正常dealloc 说明没有发生循环引用
     */
    
    self.showLabel.text = @"调用系统的api 能使用控制器 正常dealloc 说明没有发生循环引用";
    
    [UIView animateWithDuration:1.0 animations:^{
        NSLog(@"self.view:%@",self.view);
    }];
    
}
-(void)demo3{
    /*
     自定义Block 发生循环引用
     
     系统提示: Capturing 'self' strongly in this block is likely to lead to a retain cycle
     */
    self.showLabel.text = @"自定义Block 发生循环引用 \n 系统提示: Capturing 'self' strongly in this block is likely to lead to a retain cycle";
    
    _myBlock =^{
        NSLog(@"self.view:%@",self.view);
    };
    
}
-(void)demo4{
    
}
-(void)demo5{
    
}
-(void)demo6{
    
}
-(void)demo7{
    
}
-(void)demo8{
    
}

-(void)dealloc{
    /*
     看是否会调用 dealloc 方法
     */
    NSLog(@"%s--> oneVC -dealloc",__func__);
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
