//
//  DefaultTableViewCell.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/7.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "DefaultTableViewCell.h"


@interface DefaultTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end

@implementation DefaultTableViewCell


-(void )setTitle:(NSString *)title subTitle:(NSString *)subTitle{
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray  =[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    }
    return self;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
