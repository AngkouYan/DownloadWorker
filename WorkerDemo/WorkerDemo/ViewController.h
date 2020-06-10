//
//  ViewController.h
//  WorkerDemo
//
//  Created by Kenny on 2020/6/8.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoPlayer.h"
#import <DownloadWorkerFramework/DownloadWorkerFramework.h>
#import "DemoPlayerTask.h"
#import "OtherDownloadTasks.h"

@interface ViewController : UIViewController
@property (nonatomic) DemoPlayer * player1;
@property (nonatomic) DemoPlayer * player2;
//@property (nonatomic) DemoPlayerTask * playerTask1;
//@property (nonatomic) DemoPlayerTask * playerTask2;

@end

