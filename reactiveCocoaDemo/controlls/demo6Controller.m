//
//  demo6Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/8/14.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo6Controller.h"

@interface demo6Controller ()

@property (strong, nonatomic) IBOutlet UIView *lightGrayView;

@property (strong, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutlet UIView *orangeView;

@end

@implementation demo6Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [self.lightGrayView addGestureRecognizer:tap];
    [self.greenView addGestureRecognizer:tap];
    [self.orangeView addGestureRecognizer:tap];
    
    self.lightGrayView.userInteractionEnabled = YES;
    self.greenView.userInteractionEnabled = YES;
    self.orangeView.userInteractionEnabled = YES;
    
}

-(void)tapView:(UIView *)view{
    NSLog(@"点击了");
    /*
     如果父控件不能接受触摸事件，子控件就不可能接受到触摸事件；
     
     UIView 不能接收触摸事件的三种情况
     1.不允许交互 UserInterfactionEnabled = NO；
     2.隐藏，隐藏的控件不能接受事件
     3.
     */
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
