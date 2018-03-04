//
//  demo5Controller.m
//  reactiveCocoaDemo
//
//  Created by pengchao on 2017/8/14.
//  Copyright © 2017年 pengchao. All rights reserved.
//

#import "demo5Controller.h"
#import "ReactiveObjC.h"
@interface demo5Controller ()
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UIButton *Button2;
@property (strong, nonatomic) IBOutlet UIButton *Button3;
@property (strong, nonatomic) IBOutlet UIButton *Button4;
@property (strong, nonatomic) IBOutlet UIButton *Button5;
@property (strong, nonatomic) IBOutlet UIButton *Button6;
@property (strong, nonatomic) IBOutlet UIButton *Button7;
@property (strong, nonatomic) IBOutlet UIButton *Button8;


@property (nonatomic,strong)NSString *strongString;
@property (nonatomic,copy)NSString *CopyString;

@end

@implementation demo5Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakself=self;
    [[self.Button1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo1];
    }];
    [[self.Button2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo2];
    }];
    [[self.Button3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo3];
    }];
    [[self.Button4 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo4];
    }];
    [[self.Button5 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself demo5];
    }];
    [[self.Button6 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo6];
    }];
    [[self.Button7 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo7];
    }];
    [[self.Button8 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
         [weakself demo8];
    }];
    
    
}


-(void)demo1{
 
    // 1.copy 和 mutableCopy 的区别
    NSDictionary *dict =[NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    NSLog(@"dict:%p",dict);
    NSLog(@"dict-copy:%p",dict.copy);
    NSLog(@"dict-mutableCopy:%p",dict.mutableCopy);
    
    //浅拷贝只是在之前的对象上引用计数器加1
    //深拷贝是重新开辟一块内存 并把之前的对象复制一份
}

-(void)demo2{
/*
 作者：黄兢成
 链接：https://www.zhihu.com/question/29023547/answer/109570584
 来源：知乎
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 block 和 delegate 都可以通知外面。block 更轻型，使用更简单，能够直接访问上下文，这样类中不需要存储临时数据，使用 block 的代码通常会在同一个地方，这样读代码也连贯。delegate 更重一些，需要实现接口，它的方法分离开来，很多时候需要存储一些临时数据，另外相关的代码会被分离到各处，没有 block 好读。应该优先使用 block。而有两个情况可以考虑 delegate。1. 有多个相关方法。假如每个方法都设置一个 block, 这样会更麻烦。而 delegate 让多个方法分成一组，只需要设置一次，就可以多次回调。当多于 3 个方法时就应该优先采用 delegate。比如一个网络类，假如只有成功和失败两种情况，每个方法可以设计成单独 block。但假如存在多个方法，比如有成功、失败、缓存、https 验证，网络进度等等，这种情况下，delegate 就要比 block 要好。在 swift 中，利用 enum,  多个方法也可以合并成一个 block 接口。swift 中的枚举根据情况不同，可以关联不同数据类型。而在 objc 就不建议这样做，objc 这种情况下，额外数据需要使用 NSObject 或者 字典进行强转，接口就不够安全。2. 为了避免循环引用，也可以使用 delegate。使用 block 时稍微不注意就形成循环引用，导致对象释放不了。这种循环引用，一旦出现就比较难检查出来。而 delegate 的方法是分离开的，并不会引用上下文，因此会更安全些。假如写一个库供他人使用，不清楚使用者的水平如何。这时为防止误用，宁愿麻烦一些，笨一些，使用 delegate 来替代 block。将 block 简单分类，有三种情形。* 临时性的，只用在栈当中，不会存储起来。比如数组的 foreach 遍历，这个遍历用到的 block 是临时的，不会存储起来。* 需要存储起来，但只会调用一次，或者有一个完成时期。比如一个 UIView 的动画，动画完成之后，需要使用 block 通知外面，一旦调用 block 之后，这个 block 就可以删掉。* 需要存储起来，可能会调用多次。比如按钮的点击事件，假如采用 block 实现，这种 block 就需要长期存储，并且会调用多次。调用之后，block 也不可以删除，可能还有下一次按钮的点击。对于临时性的，只在栈中使用的 block, 没有循环引用问题，block 会自动释放。而只调用一次的 block，需要看内部的实现，正确的实现应该是 block 调用之后，马上赋值为空，这样 block 也会释放，同样不会循环引用。而多次调用时，block 需要长期存储，就很容易出现循环引用问题。Cocoa 中的 API 设计也是这样的，临时性的，只会调用一次的，采用 block。而多次调用的，并不会使用 block。比如按钮事件，就使用 target-action。有些库将按钮事件从 target-action 封装成 block 接口, 反而容易出问题。
 
 
 */
    
    
    
}

-(void)demo3{
    
    NSMutableString *mutableStirng = [NSMutableString stringWithString:@"123"];
    self.CopyString = mutableStirng;
    self.strongString = mutableStirng;
    NSLog(@"======cString:%@   sStrong:%@=====",self.CopyString,self.strongString);
    
    //改变mutableString的值，打印输出 self.copyedString,self.strongString
    [mutableStirng insertString:@"456" atIndex:3];
    NSLog(@"======cString:%@   sStrong:%@=====",self.CopyString,self.strongString);
    /*
     mutableString的值改变了，用strong修饰的时候，strongString的值也跟着改变了，因为strongString和mutableString指向相同的内存地址；用copy修饰NSString的时候是浅复制，相当于把mutableString内存复制了一份给了copyedString，它们两个指向的内存并不相同，当mutableString的内存地址发生改变时并不会影响copyedString的值；
     如果是将NSString *string赋值给 self.copyedString,self.strongString 的情况下，用strong和weak没有区别，个人习惯用copy。
     
     一句话：如果希望你是的sting要跟着赋值给你的那个string 改变，就用strong；如果希望你的sting保持不变，用weak；一般情况下都是希望string保持不变的，所以大部分情况用的是copy。
     */
}
-(void)demo4{
 
    /*数组的循环引用*/
    
    NSMutableArray *array1  =[NSMutableArray array];
    NSMutableArray *array2  =[NSMutableArray array];
    
    [array1 addObject:array2];
    [array2 addObject:array1];
    
}
-(void)demo5{
    
}
-(void)demo6{
    
}

-(void)demo7{
    
}
-(void)demo8{
    
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
