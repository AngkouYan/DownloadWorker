//
//  DemoPlayerTask.m
//  WorkerDemo
//
//  Created by Kenny on 2020/6/9.
//  Copyright © 2020 Kenny. All rights reserved.
//

#import "DemoPlayerTask.h"

@implementation DemoPlayerTask
@synthesize priority = _priority;

- (void)setPlayer:(DemoPlayer *)player {
    _player = player;
    _player.delegate = self;
}
- (void)setPriority:(TaskPriority)priority {
    [super setPriority:priority];
    //_priority = priority;
    //NSLog(@"[%lu]: priority %u",(unsigned long)[self.player hash], priority);
}
- (void)start {
    [self.player startBuffering];
    [super start];
}

- (void)stop {
    [self.player stopBuffering];
    [super stop];
}

- (void)resume {
    [self.player startBuffering];
    [super resume];
}

// 优先级逻辑：
// 正在播放+正在缓冲 = high(3)
// 不在播放+正在缓冲 = medium(2)
// 不在缓冲 = done(0)
- (void)playerStatusChanged {
    if(self.player.isPlaying) {
        if(self.player.isBuffering) {
            self.priority = high;
        } else {
            self.priority = done;
        }
    } else{
        if(self.player.isBuffering) {
            self.priority = medium;
        } else {
            self.priority = done;
        }
    }    
}
@end
