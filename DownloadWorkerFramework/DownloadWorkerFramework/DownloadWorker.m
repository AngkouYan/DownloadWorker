//
//  DownloadWorker.m
//  DownloadWorkerFramework
//
//  Created by Kenny on 2020/6/8.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import "DownloadWorker.h"

@implementation DownloadWorker

static DownloadWorker* sharedInstance = nil;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskPriorityChanged:) name:@"taskPriorityChanged" object:nil];
    }
    return self;
}

+ (instancetype)currentDownloadWorker {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[super allocWithZone:NULL]init];
        if(sharedInstance.highLevelQueue == nil) {
            sharedInstance.highLevelQueue = [NSMutableArray arrayWithCapacity:0];
        }
        if(sharedInstance.mediumLevelQueue == nil) {
            sharedInstance.mediumLevelQueue = [NSMutableArray arrayWithCapacity:0];
        }
        if(sharedInstance.lowLevelQueue == nil) {
            sharedInstance.lowLevelQueue = [NSMutableArray arrayWithCapacity:0];
        }
        if(sharedInstance.doneQueue == nil) {
            sharedInstance.doneQueue = [NSMutableArray arrayWithCapacity:0];
        }

    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [DownloadWorker currentDownloadWorker];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [DownloadWorker currentDownloadWorker];
}

- (void)taskPriorityChanged:(NSNotification*) notification {
    NSNumber* prePriority = [notification.userInfo objectForKey:@"previous"];
    NSNumber* currPriority = [notification.userInfo objectForKey:@"current"];
    // 维护队列
    if(prePriority.intValue == high) {
        [self.highLevelQueue removeObject:notification.object];
    } else if (prePriority.intValue == medium) {
        [self.mediumLevelQueue removeObject:notification.object];
    } else if (prePriority.intValue == low) {
        [self.lowLevelQueue removeObject:notification.object];
    } else {
        [self.doneQueue removeObject:notification.object];
    }
    
    if(currPriority.intValue == high) {
        if([self.highLevelQueue indexOfObject:notification.object] == NSNotFound) {
            [self.highLevelQueue addObject:notification.object];
        }
    } else if (currPriority.intValue == medium) {
        if([self.mediumLevelQueue indexOfObject:notification.object] == NSNotFound) {
            [self.mediumLevelQueue addObject:notification.object];
        }
    } else if (currPriority.intValue == low) {
        if([self.lowLevelQueue indexOfObject:notification.object] == NSNotFound) {
            [self.lowLevelQueue addObject:notification.object];
        }
    } else {
        if([self.doneQueue indexOfObject:notification.object] == NSNotFound) {
            [self.doneQueue addObject:notification.object];
        }
    }
    
    // 更新任务状态
    [self updateTaskStatus];
}

- (void)addTask:(DownloadWorkerTask *)task {
    switch (task.priority) {
        case high:
            [self.highLevelQueue addObject:task];
            break;
        case medium:
            [self.mediumLevelQueue addObject:task];
        case low:
            [self.lowLevelQueue addObject:task];
        default:
            [self.doneQueue addObject:task];
            break;
    }
    [self updateTaskStatus];
}

- (void)updateTaskStatus {
    if(self.highLevelQueue.count != 0) {
        for(int i = 0;i<self.highLevelQueue.count;i++) {
            [self startTask:[self.highLevelQueue objectAtIndex:i]];
        }
        for(int i=0;i<self.mediumLevelQueue.count;i++) {
            [self stopTask:[self.mediumLevelQueue objectAtIndex:i]];
        }
        for(int i=0;i<self.lowLevelQueue.count;i++) {
            [self stopTask:[self.lowLevelQueue objectAtIndex:i]];
        }
    } else if (self.mediumLevelQueue.count != 0) {
        for(int i=0;i<self.mediumLevelQueue.count;i++) {
            [self startTask:[self.mediumLevelQueue objectAtIndex:i]];
        }
        for(int i=0;i<self.lowLevelQueue.count;i++) {
            [self stopTask:[self.lowLevelQueue objectAtIndex:i]];
        }
    } else if (self.lowLevelQueue.count != 0) {
        for(int i=0;i<self.lowLevelQueue.count;i++) {
            [self startTask:[self.lowLevelQueue objectAtIndex:i]];
        }
    } else if (self.doneQueue.count != 0) {
        for(int i=0;i<self.doneQueue.count;i++) {
            [self stopTask:[self.doneQueue objectAtIndex:i]];
        }

    }
}

- (void)startTask:(DownloadWorkerTask*)task {
    if(task.status == notStarted) {
        [task start];
    } else if (task.status == stopped) {
        [task resume];
    }
}
- (void)stopTask:(DownloadWorkerTask*)task {
    [task stop];
}
@end
