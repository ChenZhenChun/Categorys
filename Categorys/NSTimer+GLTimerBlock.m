//
//  NSTimer+GLTimerBlock.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/10/12.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSTimer+GLTimerBlock.h"

@implementation NSTimer (GLTimerBlock)
+ (NSTimer *)timer_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                            block:(void(^)())block
                                          repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(timer_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)timer_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if(block) {
        block();
    }
}

@end
