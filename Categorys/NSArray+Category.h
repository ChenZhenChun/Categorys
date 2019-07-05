//
//  NSArray+Category.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/27.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)
/**
 *  解决数组越界问题
 *
 *  @param index 索引
 *
 *  @return obje
 */
- (id)objectAtIndexCheck:(NSInteger)index;

/**
 获取时间段内的所有时间
 
 @param startDate 开始时间  yyyy-MM-dd
 @param endDate 结束时间 yyyy-MM-dd
 @return NSArray
 */
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;
@end
