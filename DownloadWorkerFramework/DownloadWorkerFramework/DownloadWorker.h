//
//  DownloadWorker.h
//  DownloadWorkerFramework
//
//  Created by Kenny on 2020/6/8.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadWorkerTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownloadWorker : NSObject
@property (nonatomic) NSMutableArray * highLevelQueue;
@property (nonatomic) NSMutableArray * mediumLevelQueue;
@property (nonatomic) NSMutableArray * lowLevelQueue;
@property (nonatomic) NSMutableArray * doneQueue;

+ (instancetype)currentDownloadWorker;
- (void)addTask:(DownloadWorkerTask*) task;

@end

NS_ASSUME_NONNULL_END
