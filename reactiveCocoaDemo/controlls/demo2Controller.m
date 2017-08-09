//
//  demo2Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/7/30.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo2Controller.h"
#import "ReactiveObjC.h"
@interface demo2Controller ()
@property (strong, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation demo2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self demo4];
}

-(void)demo4{
    //1. 点击Button 创建AlertView
    __weak typeof(self) weakself=self;
    [[self.createButton rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             
             [weakself createAlertView];

    }];
    
}

-(void)createAlertView{
    //2. 用RAC 实现Alertview 的代理 方法，并监听点击的 第几个按钮；
    //虽然 UIAlertView 在这里ios 9.0 之后 基本废弃，这里只做案例展示
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"first:%@",tuple.first);
        //tuple.first 是 UIAlertView 对象
        
        NSLog(@"second:%@",tuple.second);
        //tuple.second 是 点击了第几个index的值
        
    }];
    [alertView show];
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
