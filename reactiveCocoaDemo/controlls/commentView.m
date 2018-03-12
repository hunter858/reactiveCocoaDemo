//
//  commentView.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/9.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "commentView.h"
#import "Masonry.h"
@interface commentView()
@property (nonatomic,readwrite,assign) NSInteger selectIndex;
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (weak, nonatomic) IBOutlet UIView *ButtonView;

@end


@implementation commentView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    _buttonArray =@[].mutableCopy;
    
    if (self) {
      NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"commentView" owner:self options:nil];
        
        [self addSubview:array[0]];
    }
    return self;
    
}

- (void)setButtonWithNumber:(NSInteger )number{
    
    
    
    for (NSInteger i=0; i<number; i++) {
        UIButton *button =[self buttonWithTag:i];
        [self addSubview:button];
        [_buttonArray addObject:button];
        
        if (number>10) {
            break;
        }
    }
    
    /* 等间距排列 */
    [self.buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.5 leadSpacing:30 tailSpacing:30];
    
    
    __weak typeof(self) weakself = self;
    [self.buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(weakself).offset(0);
         make.height.equalTo(@30);
         make.width.equalTo(@30);
    }];
    
}

-(UIButton *)buttonWithTag:(NSInteger)tag{
    UIButton *button =[[UIButton alloc]init];
    [button setTitle:[NSString stringWithFormat:@"%ld",tag] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.cornerRadius =1;
    button.layer.masksToBounds = true;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    return button;
}

-(void)selectButton:(UIButton *)button{

    self.selectIndex = [button.titleLabel.text intValue];
    [self changeSelectStatus:button];
}

-(void)changeSelectStatus:(UIButton *)button{
    
    for (UIButton *normalButton in self.buttonArray) {
        if ([button isEqual:normalButton]) {
            [button setBackgroundColor:[UIColor colorWithRed:43/255.0 green:192/255.0 blue:137/255.0 alpha:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [normalButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [normalButton setBackgroundColor:[UIColor whiteColor]];
        }
    }
}






@end
