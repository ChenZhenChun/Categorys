//
//  NSDate+common.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/7.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (common)

//毫秒转date
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSDate *)getLocalDateFormateUTCDate:(NSString *)utcDate;

//NSSting转date 带格式
+ (NSDate*)convertDateFromString:(NSString*)dateString andFormat:(NSString*)formatter;

//毫秒转时间（类似微信到消息时间）（上午8:00、昨天、前天）
+ (NSString *)formattedTimeFromTimeInterval:(double)time;

//获取当前时间是星期几
- (NSString *)getWeek;

// 返回当前时间
+ (NSString *)getCurrentDate;

//根据出生日期计算年龄
+(NSString *)calculateAgeBy:(NSString*)birthday;

//获取毫秒数(1970～ 时间间隔)
- (double)getTimeInterval;

//自定义标准时间 Date按照格式转换成NSSting
- (NSString *)formattedTimeWithFormat:(NSString *)dateFormat;

/*格式化日期描述*/
- (NSString *)formattedDateDescription;

/**
 timesStamp2-timesStamp1

 @param timesStamp1
 @param timesStamp2
 @return 相差的秒数
 */
+ (double)componentsTimesStamp:(double)timesStamp1 toTimeStamp:(double)timesStamp2;

/**
 两个日期的大小比较（toDateStr - fromDateStr）

 @param fromDateStr
 @param toDateStr
 @param format 日期格式
 @param calendarUnit 需要计算的单位
 @return
 */
+ (NSDateComponents *)componentsFromDate:(NSString *)fromDateStr
                                  toDate:(NSString *)toDateStr
                               formatter:(NSString *)format
                          NSCalendarUnit:(NSCalendarUnit)calendarUnit;

@end
