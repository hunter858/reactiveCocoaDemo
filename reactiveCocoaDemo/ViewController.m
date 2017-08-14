//
//  ViewController.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/7/30.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "ViewController.h"


@implementation viewModel
@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *MyTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyTableView.tableFooterView  =[[UIView alloc]init];
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    self.dataArray;
    
    
}

-(NSMutableArray *)dataArray{
    if(_dataArray==nil){
        _dataArray = [NSMutableArray array];
        
        viewModel *model1 = [[viewModel alloc]init];
        model1.title = @"demo1";
        model1.subTitle = @"demo1";
        model1.controller = @"demo1Controller";
        
        viewModel *model2= [[viewModel alloc]init];
        model2.title = @"demo2";
        model2.subTitle = @"demo3";
        model2.controller = @"demo2Controller";
        
        
        viewModel *model3= [[viewModel alloc]init];
        model3.title = @"GCD";
        model3.subTitle = @"GCD 实用指南";
        model3.controller = @"demo3Controller";
        
        viewModel *model4 = [[viewModel alloc]init];
        model4.title = @"刮刮乐";
        model4.subTitle = @"刮刮乐";
        model4.controller = @"demo4Controller";
        
        viewModel *model5 = [[viewModel alloc]init];
        model5.title = @"demo5";
        model5.subTitle = @"";
        model5.controller = @"demo5Controller";
        
        viewModel *model6 = [[viewModel alloc]init];
        model6.title = @"demo6";
        model6.subTitle = @"";
        model6.controller = @"demo6Controller";
        
        viewModel *model7 = [[viewModel alloc]init];
        model7.title = @"demo7";
        model7.subTitle = @"";
        model7.controller = @"demo7Controller";
        

        
        _dataArray = @[model1,model2,model3,model4,model5,model6,model7].mutableCopy;
    }
    return _dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID  = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    viewModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    viewModel *model = self.dataArray[indexPath.row];
    Class controllerName =  NSClassFromString(model.controller);
    
#if __has_feature(objc_arc)
    
    UIViewController *controller = [[controllerName alloc] init];
    
#else
    controller = [[[controller alloc] init] autorelease];
    
#endif
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
