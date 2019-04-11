//
//  UIColor+Hex.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/26.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UIColor+Hex.h"
#import "NSString+Common.h"

@implementation UIColor (Hex)
+ (UIColor *)uks_colorWithHexString:(NSString *)color {
    if ([NSString isBlankString:color]) return nil;
    // 转换成标准16进制数
    if ([color hasPrefix:@"#"]) {
       color = [color stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    }else {
        color = [@"0x" stringByAppendingString:color];
    }
    
    // 十六进制字符串转成整型。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    //string转color
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
}
@end
