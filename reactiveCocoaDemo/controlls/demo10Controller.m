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


@interface demo10Controller ()

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
    [[self.Button6 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo6];
    }];
    [[self.Button7 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo7];
    }];
    [[self.Button8 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo8];
    }];
    
    
    
    
}

-(void)demo1{
    Son *son_one = [[Son alloc]init];
}
-(void)demo2{
    
}
-(void)demo3{
    
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
