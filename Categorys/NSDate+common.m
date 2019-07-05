//
//  NSDate+common.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/7.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSDate+common.h"
#import "NSString+Common.h"
#import "NSDateFormatter+Category.h"

@implementation NSDate (common)

//毫秒转date
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(double)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time] formattedTime];
}

//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSDate *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    return dateFormatted;
}

//NSSting转date 带格式
+ (NSDate*)convertDateFromString:(NSString*)dateString andFormat:(NSString*)formatter {
    if ([NSString isBlankString:dateString]||[NSString isBlankString:formatter]) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    [dateFormatter setDateFormat:formatter];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//获取当前时间是星期几
- (NSString *)getWeek {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:self];
    NSString *week;
    switch ([comps weekday]) {
        case 1:
            week = @"周日";
            break;
        case 2:
            week = @"周一";
            break;
        case 3:
            week = @"周二";
            break;
        case 4:
            week = @"周三";
            break;
        case 5:
            week = @"周四";
            break;
        case 6:
            week = @"周五";
            break;
        case 7:
            week = @"周六";
            break;
        default:
            week = @"";
            break;
    }
    return week;
}

+ (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    
    NSTimeInterval sec = [date timeIntervalSince1970];
    
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:sec];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *na =[dateFormatter stringFromDate:epochNSDate];
    return na;
}

//根据出生日期计算年龄
+(NSString*)calculateAgeBy:(NSString*)birthday{
    birthday = [NSString stringWithFormat:@"%@ 00:00:00", birthday];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [dateFormatter dateFromString:birthday];
    
    NSDate *now = [NSDate date];
    long long seconds = [now timeIntervalSince1970] - [date timeIntervalSince1970];
    long long age = seconds / (365 * 24 * 60 * 60);
    return [NSString stringWithFormat:@"%lld", age];
}

/*自定义标准时间*/
- (NSString *)formattedTimeWithFormat:(NSString *)dateFormat {
    NSString *ret = @"";
    NSDateFormatter* formatter = [NSDateFormatter dateFormatterWithFormat:dateFormat];
    ret = [formatter stringFromDate:self];
    return ret;
}

//获取毫秒数(1970～ 时间间隔)
- (double)getTimeInterval {
    return [self timeIntervalSince1970]*1000;
}

/*标准时间日期描述*/
-(NSString *)formattedTime{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
        
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

/*格式化日期描述*/
- (NSString *)formattedDateDescription {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSDate *date = [NSDate date];
    NSString *theYear = [dateFormatter stringFromDate:self];//日期的年份
    NSString *currentYear = [dateFormatter stringFromDate:date];//当前年份
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:date];//当前年月日

    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < D_MINUTE) {
        return @"1分钟内";
    } else if (timeInterval < D_HOUR) {//1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)(timeInterval / 60)];
    } else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:@"%ld小时前", (long)(timeInterval / 3600)];
    } else if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == D_DAY) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([theYear isEqualToString:currentYear]) {//当年
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

+ (double)componentsTimesStamp:(double)timesStamp1 toTimeStamp:(double)timesStamp2 {
    if(timesStamp1 > 140000000000) {
        timesStamp1 = timesStamp1 / 1000;
    }
    if(timesStamp2 > 140000000000) {
        timesStamp2 = timesStamp2 / 1000;
    }
    
    return timesStamp2-timesStamp1;
}

+ (NSDateComponents *)componentsFromDate:(NSString *)fromDateStr
                                  toDate:(NSString *)toDateStr
                               formatter:(NSString *)format
                          NSCalendarUnit:(NSCalendarUnit)calendarUnit {
    if ([NSString isBlankString:fromDateStr]||[NSString isBlankString:toDateStr]||[NSString isBlankString:format]) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *fromDate = [NSDate convertDateFromString:fromDateStr andFormat:format];
    NSDate *toDate = [NSDate convertDateFromString:toDateStr andFormat:format];
    NSDateComponents *comps = [gregorian components:calendarUnit fromDate:fromDate toDate:toDate options:0];
    return comps;
}

@end
