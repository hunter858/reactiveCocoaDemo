//
//  sunny2Model.h
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/5.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface sunny2Model : JSONModel

@property (nonatomic, copy ) NSString *identifier;
@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy ) NSString *content;
@property (nonatomic, copy ) NSString *username;
@property (nonatomic, copy ) NSString *time;
@property (nonatomic, copy ) NSString *imageName;


@end
