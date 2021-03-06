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
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) IBOutlet UIButton *notificationButton;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel2;


@property (strong, nonatomic) IBOutlet UIScrollView *myScrollview;


@end

@implementation demo2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self demo4];
    
    [self demo5];
    
    [self demo6];
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
    __weak typeof(self) weakself=self;
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {

        NSLog(@"first:%@",tuple.first);
        //tuple.first 是 UIAlertView 对象
        
        NSLog(@"second:%@",tuple.second);
        //tuple.second 是 点击了第几个index的值
        
        if([tuple.second isKindOfClass:[NSNumber class]]){
            NSNumber *number = (NSNumber *) tuple.second;
            
            NSString *valueStr  =[NSString stringWithFormat:@"点击了第 %@ 个按钮",number];
            weakself.resultLabel.text = valueStr;
        }
        
    }];
    alertView.delegate =self;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
}


-(void)demo5{
    
    
    __weak typeof(self) weakself=self;
    static NSString *notificationName = @"notificationName";
    NSMutableArray *array =@[@"1",@"2",@"3"].mutableCopy;
    //1.创建要发送的对象
    [[self.notificationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:array];
        //2.发送通知
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:notificationName object:nil]subscribeNext:^(NSNotification * _Nullable notification) {
        
        //3.监听发送的对象
        
        weakself.resultLabel2.text = [NSString stringWithFormat:@"接受到通知 name：%@",notification.name];
        
        NSLog(@"%@",notification.name);
        NSLog(@"%@",notification.object);
    }];
    
}


-(void)demo6{
    
    CGSize size = CGSizeMake(self.myScrollview.bounds.size.width*3, self.myScrollview.bounds.size.height);
    self.myScrollview.contentSize = size;
    
    [RACObserve(self.myScrollview, contentOffset) subscribeNext:^(id  _Nullable x) {

        
        NSLog(@"%@",[x class]);
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
