//
//  OtherDownloadTasks.m
//  WorkerDemo
//
//  Created by Kenny on 2020/6/10.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import "OtherDownloadTasks.h"

@implementation OtherDownloadTasks
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.priority = low;
    }
    return self;
}
- (void)start {
    if(self.status == running) {
        return;
    }
    NSLog(@"DownloadTask [%lu]: start",(unsigned long)[self hash]);
    [super start];
}

- (void)stop {
    if(self.status == stopped) {
        return;
    }
    NSLog(@"DownloadTask [%lu]: stop",(unsigned long)[self hash]);

    [super stop];
}

- (void)resume {
    if(self.status == running) {
        return;
    }
    NSLog(@"DownloadTask [%lu]: resume",(unsigned long)[self hash]);

    [super resume];
}
@end
