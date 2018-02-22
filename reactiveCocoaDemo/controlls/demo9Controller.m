//
//  demo9Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/9/7.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo9Controller.h"
#import "ReactiveObjC.h"

@interface demo9Controller ()
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;

@property (copy) NSMutableArray *array;
@property (strong) NSMutableArray *strongArray;

/** 售票员01 */
@property (nonatomic,strong)NSThread *thread1;
/** 售票员02 */
@property (nonatomic,strong)NSThread *thread2;
/** 售票员03 */
@property (nonatomic,strong)NSThread *thread3;
/** 票的总数 */
@property (nonatomic, assign) NSInteger ticketCount;
@end

@implementation demo9Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[self.Button1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo1];
    }];
    [[self.Button2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo2];
    }];
    [[self.Button3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo3];
    }];
    [[self.Button4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self demo4];
    }];
    
    
}
-(void)demo1{
    
    /*
       copy 就是拷贝了一个不可变数组，如果用 NSMutableArray 的方法会因为找不到方法而崩溃
     */
    
    
    self.array = @[@"1",@"2"].mutableCopy;
    
    @try {
         [self.array insertObject:@"3" atIndex:0];
    } @catch (NSException *exception) {
         NSLog(@"copy 就是拷贝了一个不可变数组，如果用nsmutableArray 的方法会因为找不到方法而崩溃");
    } @finally {
       
    }
    
    
}

-(void)demo2{
    
    /* 
     @synchronized 用法
     */
    
    self.ticketCount = 100;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread1.name = @"售票员01";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2.name = @"售票员02";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread3.name = @"售票员03";
    
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}
-(void)demo3{
    
    /* 
     strong 属性 是深拷贝一份，不会出现 找不到方法等问题
     */
    self.strongArray = @[@"1",@"2"].mutableCopy;
    [self.strongArray insertObject:@"3" atIndex:0];

    @try {
        [self.strongArray insertObject:@"3" atIndex:0];
    } @catch (NSException *exception) {
         NSLog(@"  strong 属性 是深拷贝一份，不会出现 找不到方法等问题 ");
    } @finally {
       
    }
    
    /*
     
     weak 不会产生野指针问题。因为weak修饰的对象释放后（引用计数器值为0），指针会自动被置nil，之后再向该对象发消息也不会崩溃。 weak是安全的。
     assign 如果修饰对象，会产生野指针问题；如果修饰基本数据类型则是安全的。修饰的对象释放后，指针不会自动被置空，此时向对象发消息会崩溃。
     
     */
    
    /*
     宏定义属于预编译指令，在程序运行之前已经编译好了，
     例如
     #define  pengchao @“pengchao”
     
     在程序有用到 pengchao 的地方，将所有的 pengchao 替换成 @“pengchao” 相当于每次都开辟一块临时的内存空间，显然浪费内存；
     
     
     如果用 
     NSString *const pengchao = @"pengchao";
     
     则 在程序运行的时候，只开辟了一块内存，节省了资源
     */
    
}
-(void)demo4{
    
}
-(void)demo5{
    
}
-(void)demo6{
    
}


-(void)saleTicket{
    
    while (1) {
        // 先取出总数
        
        @synchronized(self) {
        NSInteger count = self.ticketCount;
        if (count > 0) {
            self.ticketCount = count - 1;
            NSLog(@"%@卖了一张票，还剩下: %zd张", [NSThread currentThread].name, self.ticketCount);
        } else {
            NSLog(@"票已经卖完了");
            break;
        }
        }
    }
    
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
