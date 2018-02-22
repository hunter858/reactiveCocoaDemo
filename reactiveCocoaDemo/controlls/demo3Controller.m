//
//  demo3Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/7/30.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo3Controller.h"
#import "ReactiveObjC.h"
#import "AFNetworking.h"


@interface demo3Controller ()
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;
@property (strong, nonatomic) IBOutlet UIButton *Button6;

@property (strong, nonatomic) IBOutlet UIButton *Button7;
@property (strong, nonatomic) IBOutlet UIButton *Button8;
@property (strong, nonatomic) IBOutlet UIButton *Button9;

@end

@implementation demo3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addButtonClick];
    __weak typeof(self) weakself=self;
    [[self.Button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself syncConnect];
    }];
    [[self.Button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself asyncConnect];
    }];
    [[self.Button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself syncConnection];
    }];
    [[self.Button4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself syncSerical];
    }];

    [[self.Button5 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself asyncMain];
    }];
    [[self.Button6 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself queue_connectWithOther];
    }];
    [[self.Button7 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself groupSync];
    }];
    
    [[self.Button8 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself group_Afn_async];
    }];
    [[self.Button9 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //[weakself queue_connectWithOther];
    }];
    
}



-(void)addButtonClick{
//    [self testOperactionQueque];
//    [self testGCD];
}




-(void)testOperactionQueque{
    
//  NSOperationQueue 创建依赖队列
    
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    NSOperation *A =[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"function_A");
    }];
    
    NSOperation *B =[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"function_B");
    }];
    
    NSOperation *C =[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"function_C");
    }];
    
    [C addDependency:B];
    [B addDependency:A];
    
    [queue addOperation:A];
    [queue addOperation:B];
    [queue addOperation:C];
}


-(void)testGCD{
    
    /*
     DISPATCH_QUEUE_PRIORITY_HIGH  高优先级
     DISPATCH_QUEUE_PRIORITY_DEFAULT  默认优先级
     DISPATCH_QUEUE_PRIORITY_LOW    低优先级
     DISPATCH_QUEUE_PRIORITY_BACKGROUND  后台级别的优先级
     */
    
    dispatch_queue_t high_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    
    
    
    
    
}


-(void)syncConnect{
    /*
     1.并行队列 + 同步执行
     */
    
    NSLog(@"syncConnect__start");
    dispatch_queue_t connectQueue = dispatch_queue_create("syncConnect", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(connectQueue, ^{
        NSLog(@"1__thread__%@",[NSThread currentThread]);
    });
    dispatch_sync(connectQueue, ^{
        NSLog(@"2__thread__%@",[NSThread currentThread]);
    });
    
    dispatch_sync(connectQueue, ^{
        NSLog(@"3__thread__%@",[NSThread currentThread]);
    });
    NSLog(@"syncConnect__end");
    
}


-(void)asyncConnect{
    
    /*
     2.并行队列+ 异步执行
     */
    NSLog(@"asyncConnect__start");

    dispatch_queue_t connectQueue =  dispatch_queue_create("asyncConnect", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(connectQueue, ^{
        NSLog(@"1__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(connectQueue, ^{
        NSLog(@"2__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(connectQueue, ^{
        NSLog(@"3__thread__%@",[NSThread currentThread]);
    });
    NSLog(@"asyncConnect__end");
    
}
-(void)syncConnection{
    /* 
     3.串行队列 + 同步执行
     */
    
    NSLog(@"syncConnection__end");
    dispatch_queue_t sericalQueue = dispatch_queue_create("syncConnection", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(sericalQueue, ^{
         NSLog(@"1__thread__%@",[NSThread currentThread]);
    });
    dispatch_sync(sericalQueue, ^{
         NSLog(@"2__thread__%@",[NSThread currentThread]);
    });
    dispatch_sync(sericalQueue, ^{
         NSLog(@"3__thread__%@",[NSThread currentThread]);
    });
    NSLog(@"syncConnection__end");
    
}




-(void)syncSerical{
    
    /*
     4.串行队列 + 异步执行
     */
    NSLog(@"syncSerical__start");
    dispatch_queue_t syncQueue = dispatch_queue_create("syncSerical", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(syncQueue, ^{
         NSLog(@"1__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(syncQueue, ^{
         NSLog(@"2__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(syncQueue, ^{
         NSLog(@"3__thread__%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncSerical__end");
    
}


-(void)asyncMain{
    
    /*
     5.主线程 + 异步队列
     */
    NSLog(@"asyncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
         NSLog(@"1__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
         NSLog(@"2__thread__%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
         NSLog(@"3__thread__%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncMain---end");
    
    
}

-(void)queue_connectWithOther{
    
    /* 
     6. 线程之间的通信
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2-------%@",[NSThread currentThread]);
        });
    });

}



-(void)groupSync{
    
    /*
     7.dispatch_group 
     */
    
    dispatch_queue_t queue = dispatch_queue_create("dispatch_group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"任务1");
    });
    dispatch_group_async(group, queue, ^{
        sleep(3);
         NSLog(@"任务2");
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(2);
         NSLog(@"任务3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务都完成了" );
    });
    
}


-(void)group_Afn_async{
    
    
    
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    //0.创建网络请求类
    
    static NSString *url1 =@"http://ooynqqqkg.bkt.clouddn.com/1111.png";
    static NSString *url2 =@"http://ooynqqqkg.bkt.clouddn.com/111-2016-05-24-4.48.10.png";
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       

            // 1.将任务加到group中
        [manager GET:url1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"请求1 success");
            dispatch_group_leave(group);
            //2. 任务请求完成 移除group
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求1 failure");
            dispatch_group_leave(group);
            //2. 任务失败 移除group
        }];
       
    });
    
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1.将任务加到group中
        [manager GET:url2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"请求2 success");
            dispatch_group_leave(group);
            //2. 任务请求完成 移除group
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求2 failure");
            dispatch_group_leave(group);
            //2. 任务失败 移除group
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"所有网络请求均完成");
        
    });
    
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
