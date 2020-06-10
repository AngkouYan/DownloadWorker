//
//  DemoPlayerTask.h
//  WorkerDemo
//
//  Created by Kenny on 2020/6/9.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DownloadWorkerFramework/DownloadWorkerFramework.h>
#import "DemoPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoPlayerTask : DownloadWorkerTask<DemoPlayerDelegate>
@property (nonatomic,assign) DemoPlayer * player;

@end

NS_ASSUME_NONNULL_END
