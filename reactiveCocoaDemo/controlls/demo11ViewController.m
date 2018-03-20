//
//  demo11ViewController.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2018/3/4.
//  Copyright © 2018年 pengchao. All rights reserved.
//

#import "demo11ViewController.h"

@interface demo11ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *showlabel;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (weak, nonatomic) IBOutlet UILabel *stepperLabel;

@end

@implementation demo11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView  =[UIView new];
    
    self.stepper.continuous = YES;
    self.stepper.wraps = YES;
    self.stepper.minimumValue = 1;
    self.stepper.maximumValue = 3;
    [self.stepper addTarget:self action:@selector(modeChangeAtion:) forControlEvents:UIControlEventTouchUpInside];

    
    /*
      runLoop 是什么？
     runLoop 是一个和多线程紧密相关的基础框架，就是一个事件处理循环，用来处理app的事件和输入事件，
     使你的线程在有工作的时候工作，没工作的时候休眠；
     
     */
    
    /* 当你 开始倒计时的时候，你没有把 timer 加入到 runloop 的track 模式种
     
     当你滚动 scrollView 和 tableView 的时候，timer。停止倒计时
     
     
     
     
     */
    
   
    
}


-(void)modeChangeAtion:(id)sender {
    
    UIStepper *stepper = sender;

    NSInteger index = (NSInteger)stepper.value;
    NSString *modelStr;
    
    NSRunLoopMode model ;
    switch (index) {
        case 1:
            model = NSDefaultRunLoopMode;
            modelStr =@"NSDefaultRunLoopMode";
            break;
        case 2:
            model = NSRunLoopCommonModes;
            modelStr =@"NSRunLoopCommonModes";
            break;
        case 3:
            model = UITrackingRunLoopMode;
            modelStr =@"UITrackingRunLoopMode";
            break;
   
        default:
            model = NSDefaultRunLoopMode;
            modelStr =@"NSDefaultRunLoopMode";
            break;
    }
    [self.stepperLabel setText:[NSString stringWithFormat:@"%@",modelStr]];
    
    NSRunLoop *currentLoop =[NSRunLoop currentRunLoop];
    [currentLoop addTimer:self.timer forMode:model];
    [currentLoop run];
    
  
}


-(void)updateAction{
    if (_tag == NULL) {
        _tag=0;
    }
    _tag ++;
    
    
    //CABasicAnimation *baseAnimation  =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //baseAnimation.toValue = @1.2;
    //baseAnimation.duration = 0.1;
    //baseAnimation.removedOnCompletion = NO;
    //baseAnimation.fillMode = kCAFillModeForwards;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.showlabel.text = [NSString  stringWithFormat:@"%ld",_tag];
        //[self.showlabel.layer addAnimation:baseAnimation forKey:nil];
    }];
    
    
}


- (IBAction)startTimer:(id)sender {
    
    /* 第一种创建timer 的方法 */
    if (self.timer ==nil) {
         self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateAction) userInfo:nil repeats:YES];
    }
    
    /* 第二种创建timer 的方法 */
    
//    if (self.timer ==nil) {
//        self.timer =[NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [self updateAction];
//        }];
//    }
    
}
- (IBAction)stopTimer:(id)sender {
    [self.timer invalidate];
    self.timer =nil;
}
- (IBAction)addRunloopAction:(id)sender {
    
    NSRunLoop *currentLoop =[NSRunLoop currentRunLoop];
    NSRunLoop *mainLoop =[NSRunLoop mainRunLoop];
    
    NSLog(@"currentLoop:%@",currentLoop);
    NSLog(@"mainLoop:%@",mainLoop);
    
    /* 因为当前UI 是在主线程 ，所以 currentLoop 和 mainLoop 一致 */
    
    /*
     苹果公开的2个 runloop 模式
     
     kCFRunLoopDefaultMode //默认模式，通常主线程在这个模式下运行
     
     kCFRunLoopCommonModes //占位符，带有Common标记的字符串，比较特殊的一个mode；
     
     UITrackingRunLoopMode //界面跟踪Mode，用于追踪Scrollview触摸滑动时的状态。
     
     UIInitializationRunLoopMode //刚启动App时进入的第一个Mode，启动后不在使用。
     
     GSEventReceiveRunLoop //内部Mode，接收系事件。
     
     */
    [currentLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [currentLoop run];
    
    /*
     每一个线程都有一个 runLoop ，默认 runloo 是关闭的，只有主线程是打开的；
     所以，当我们在一个线程 获得 runloop 的时候，记得
     */
    
}

- (IBAction)removeRunnLoopAction:(id)sender {
    
    
    
    
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *identifier =@"identifier11";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"CFRunLoopCell %ld",indexPath.row];
    
    return  cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
