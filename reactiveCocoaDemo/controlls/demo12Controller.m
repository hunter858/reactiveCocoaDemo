//
//  demo12Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/5.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "demo12Controller.h"
#import "sunny2Model.h"
#import "sunny2TableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface demo12Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *EntitiesFromJSON;
@end

@implementation demo12Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.fd_debugLogEnabled = YES;
    self.myTableView.tableFooterView  = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"sunny2TableViewCell" bundle:nil] forCellReuseIdentifier:@"FDFeedCell"];
    
    
    __weak typeof(self) weakself = self;
    
    [self buildTestDataThen:^{
        
        [weakself.myTableView reloadData];
    }];
  
    
    
}


- (void)buildTestDataThen:(void (^)(void))then {
    
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        //        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //            [entities addObject:[[sunny2Model alloc] initWithData:obj error:nil]];
        //        }];
        for (NSDictionary *dic in feedDicts) {
            sunny2Model *model = [[sunny2Model alloc]initWithDictionary:dic error:nil];
            [entities addObject:model];
        }        
        
        weakself.EntitiesFromJSON = entities.mutableCopy;
        
        NSLog(@"entities:%@",entities);
         NSLog(@"EntitiesFromJSON:%@",weakself.EntitiesFromJSON);
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
        
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.EntitiesFromJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    sunny2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDFeedCell"];
    [self configureCell:cell atIndexPath:indexPath];
    
    
//    if (cell ==nil) {
//        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FDFeedCell"];
//    }
    return cell;
}


- (void)configureCell:(sunny2TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.entity = self.EntitiesFromJSON[indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakself = self;
    
   return  [tableView fd_heightForCellWithIdentifier:@"FDFeedCell" configuration:^(sunny2TableViewCell *cell) {
        [weakself configureCell:cell atIndexPath:indexPath];
    }];
    
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
