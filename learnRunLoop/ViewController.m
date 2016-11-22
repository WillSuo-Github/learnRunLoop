//
//  ViewController.m
//  learnRunLoop
//
//  Created by 岩柯李 on 2016/11/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) NSTimer *myTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.myScrollView = ({
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 300000000);
//        scrollView.delegate = self;
//        [self.view addSubview:scrollView];
//        scrollView;
//    });
    
    self.myTimer = ({
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCount) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        timer;
    });
}
                          
- (void)timeCount{
//    NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%f", [[NSDate date] timeIntervalSince1970]);

}




//MARK: UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scroll-----%@", [NSRunLoop currentRunLoop].currentMode);
    
    /*
     依次打印了
     kCFRunLoopDefaultMode
     UITrackingRunLoopMode
     UITrackingRunLoopMode
     UITrackingRunLoopMode
     UITrackingRunLoopMode
     
     当timer被添加到UITrackingRunLoopMode中时候方法并不会被调用了，只有在滑动scrollView的时候才会调用定时的方法 而且还是保持一秒一次  并没有被阻塞
     
     好像UITrackingRunLoopMode就是ui交互时候的runloopMode了？ 其实并不是  下边的touch方法 无论是点击还是move的时候调用的并不是 UITrackingRunLoopMode 而是 kCFRunLoopDefaultMode
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchBegan-----%@", [NSRunLoop currentRunLoop].currentMode);
    //kCFRunLoopDefaultMode  timer在同一个mode中的时候也不会阻塞
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchMoved-----%@", [NSRunLoop currentRunLoop].currentMode);
}


@end
