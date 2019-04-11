//
//  NSArray+Category.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/27.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSArray+Category.h"
#import "NSDate+common.h"

@implementation NSArray (Category)

/**
 *  解决数组越界问题
 *
 *  @param index 索引
 *
 *  @return
 */
- (id)objectAtIndexCheck:(NSInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        //        [componentAarray addObject:start];
        [componentAarray addObject:[start formattedTimeWithFormat:@"yyyy-MM-dd"]];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        
        //对比日期大小
        result = [start compare:end];
    }
    return componentAarray;
}

@end
