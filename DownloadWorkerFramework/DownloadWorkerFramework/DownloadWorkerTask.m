//
//  DownloadWorkerTask.m
//  DownloadWorkerFramework
//
//  Created by Kenny on 2020/6/9.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import "DownloadWorkerTask.h"
@implementation DownloadWorkerTask
- (instancetype)init
{
    self = [super init];
    if (self) {
        _status = notStarted;
        _priority = done;
    }
    return self;
}
- (void)setPriority:(TaskPriority)priority {
    if(_priority != priority) {
        NSDictionary * dict = @{
            @"previous" : [NSNumber numberWithInt:_priority],
            @"current" : [NSNumber numberWithInt:priority]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"taskPriorityChanged" object:self userInfo:dict];
        //NSLog(@"[%lu]: priority changed from %u to %u",(unsigned long)[self hash], _priority,priority);
    }
    _priority = priority;
}

- (void)start {
    self.status = running;
}

- (void)stop {
    self.status = stopped;
}

- (void)resume {
    self.status = running;
}
@end
