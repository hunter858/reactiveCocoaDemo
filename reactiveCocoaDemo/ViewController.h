//
//  ViewController.h
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/7/30.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "ReactiveObjC.h"

@interface viewModel : JSONModel
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subTitle;
@property (nonatomic,strong)NSString *controller;
@end


@interface ViewController : UIViewController

@end

