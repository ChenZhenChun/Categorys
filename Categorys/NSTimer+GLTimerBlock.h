//
//  NSTimer+GLTimerBlock.h
//  ZJInternetHospital
//
//  Created by gulu on 2017/10/12.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GLTimerBlock)

/**
 通过block解决NSTimer循环引用问题
 
 @param interval    时间间隔
 @param block       bock回调
 @param repeats     是否重复
 @return            NSTimer
 */
+ (NSTimer *)timer_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                            block:(void(^)(void))block
                                          repeats:(BOOL)repeats;
@end
