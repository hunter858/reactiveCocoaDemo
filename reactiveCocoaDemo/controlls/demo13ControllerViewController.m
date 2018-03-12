//
//  demo13ControllerViewController.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/9.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "demo13ControllerViewController.h"
#import "commentView.h"

@interface demo13ControllerViewController ()

@end

@implementation demo13ControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat width =   [UIScreen mainScreen].bounds.size.width;
    
    commentView *comment_View =[[commentView alloc]initWithFrame:CGRectMake(0, 100, width, 93)];
    [self.view addSubview:comment_View];
    
    [comment_View setButtonWithNumber:10];
    
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
