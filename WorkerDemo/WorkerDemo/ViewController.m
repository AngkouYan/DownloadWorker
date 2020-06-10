//
//  ViewController.m
//  WorkerDemo
//
//  Created by Kenny on 2020/6/8.
//  Copyright © 2020 Kenny. All rights reserved.
//
// 优先级逻辑：
// 播放器正在播放+正在缓冲时，其余所有任务暂停下载
// 播放器不在播放+正在缓冲时，若有正在播放的播放器，则暂停缓冲，待该播放器进入播放状态时重新缓冲，若无正在播放的播放器，则优先进行缓冲，之后恢复其余下载任务
// 播放器不在缓冲时，恢复其余下载任务。

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.player1 = [[DemoPlayer alloc]init];
    self.player2 = [[DemoPlayer alloc]init];

    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    button1.frame = CGRectMake(100, 100, 200, 100);
    [button1 addTarget:self action:@selector(player1Start) forControlEvents:UIControlEventTouchDown];
    [button1 setTitle:@"player1 start play" forState:UIControlStateNormal];
    
    button3.frame = CGRectMake(100, 200, 200, 100);
    [button3 addTarget:self action:@selector(player1Stop) forControlEvents:UIControlEventTouchDown];
    [button3 setTitle:@"player1 stop playing" forState:UIControlStateNormal];

    button2.frame = CGRectMake(100, 300, 200, 100);
    [button2 addTarget:self action:@selector(player2Start) forControlEvents:UIControlEventTouchDown];
    [button2 setTitle:@"player2 start play" forState:UIControlStateNormal];

    button4.frame = CGRectMake(100, 400, 200, 100);
    [button4 addTarget:self action:@selector(player2Stop) forControlEvents:UIControlEventTouchDown];
    [button4 setTitle:@"player2 stop playing" forState:UIControlStateNormal];

    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];

    // player tasks
    DemoPlayerTask* playerTask1 = [[DemoPlayerTask alloc]init];
    playerTask1.player = self.player1;
    
    DemoPlayerTask* playerTask2 = [[DemoPlayerTask alloc]init];
    playerTask2.player = self.player2;


    // other download tasks
    OtherDownloadTasks* downloadTask1 = [[OtherDownloadTasks alloc]init];
    OtherDownloadTasks* downloadTask2 = [[OtherDownloadTasks alloc]init];
    OtherDownloadTasks* downloadTask3 = [[OtherDownloadTasks alloc]init];

    DownloadWorker * worker = [DownloadWorker currentDownloadWorker];
    [worker addTask:playerTask1];
    [worker addTask:playerTask2];
    [worker addTask:downloadTask1];
    [worker addTask:downloadTask2];
    [worker addTask:downloadTask3];
}

-(void)player1Start {
    [self.player1 startPlay];
}
-(void)player2Start {
    [self.player2 startPlay];
}
-(void)player1Stop {
    [self.player1 stopPlaying];
}
-(void)player2Stop {
    [self.player2 stopPlaying];
}
@end
