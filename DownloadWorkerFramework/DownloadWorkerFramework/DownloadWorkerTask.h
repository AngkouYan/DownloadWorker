//
//  DownloadWorkerTask.h
//  DownloadWorkerFramework
//
//  Created by Kenny on 2020/6/8.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum TaskPriority : int {
    high = 3,
    medium = 2,
    low = 1,
    done = 0
} TaskPriority;

typedef enum TaskStatus {
    notStarted,
    running,
    stopped,
    finished
} TaskStatus;

@interface DownloadWorkerTask : NSObject
@property (nonatomic) TaskPriority priority;
@property (nonatomic) TaskStatus status;
//@property (nonatomic) int taskTime; // 任务等待时间，相同优先级任务等待时间越高，优先执行

-(void)start;
-(void)stop;
-(void)resume;
@end

NS_ASSUME_NONNULL_END
