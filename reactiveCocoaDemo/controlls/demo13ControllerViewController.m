//
//  demo13ControllerViewController.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/9.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "demo13ControllerViewController.h"
#import "commentView.h"
#import "UIImage+destructive.h"

@interface demo13ControllerViewController ()
@property (weak, nonatomic) IBOutlet UIView *sectionView1;
@property (weak, nonatomic) IBOutlet UIView *sectionView2;
@property (weak, nonatomic) IBOutlet UIView *sectionView3;
@property (weak, nonatomic) IBOutlet UIView *sectionView4;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;



@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation demo13ControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self addcommentsDemo];
    [self addAttributeStringDemo];
    [self addMinButtonOrMaxButton_demo];
    
    
}


-(void)addcommentsDemo{
    
    CGFloat width =   [UIScreen mainScreen].bounds.size.width;
    commentView *comment_View =[[commentView alloc]initWithFrame:CGRectMake(0, 0, width, 93)];
    [self.sectionView1 addSubview:comment_View];
    [comment_View setButtonWithNumber:10];
}

-(void)addAttributeStringDemo{
    //富文本对象
    
    NSString * aString = @"¥150 元/位";
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:aString];
    
    //富文本样式
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                              value:[UIColor redColor]
                              range:NSMakeRange(0, 4)];
    
    [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                              value:[UIFont systemFontOfSize:25]
                              range:NSMakeRange(0, 4)];
    
    self.label.attributedText = aAttributedString;
}

/* 无损拉伸 */

-(void)addMinButtonOrMaxButton_demo{
    
    self.imageView1.image  = [UIImage imageNamed:@"icon_star"];
    self.imageView2.image  = [UIImage CC_imageNamed:@"icon_star"];
    self.imageView3.image  = [UIImage CC2_imageNamed:@"icon_star"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
