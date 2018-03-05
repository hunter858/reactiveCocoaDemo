//
//  sunny2TableViewCell.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/5.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "sunny2TableViewCell.h"

@interface sunny2TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Content;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *useDate;

@end

@implementation sunny2TableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    // Initialization code
}

-(void)setEntity:(sunny2Model *)entity{
    
    self.title.text = entity.title;
    self.Content.text = entity.content;
    self.showImageView.image = entity.imageName.length > 0 ? [UIImage imageNamed:entity.imageName] : nil;;
    
//    if (!(entity.imageName.length>0)) {
//        self.showImageView removeFromSuperview
//    }
    
    self.userName.text = entity.username;
    self.useDate.text = entity.time;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
