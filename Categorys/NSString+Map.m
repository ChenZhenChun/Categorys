//
//  NSString+Map.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/9/14.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSString+Map.h"
#import "NSString+Common.h"

@implementation NSString (Map)

//性别编码转中文
+ (NSString *)gl_sexNameByCode:(id)sexCode {
    if ([sexCode isKindOfClass:[NSString class]]) {
        if ([NSString isBlankString:sexCode]||[@"0"isEqualToString:sexCode]) {
            return @"";
        }else if ([@"1" isEqualToString:sexCode]) {
            return @"男";
        }else {
            return @"女";
        }
    }else if ([sexCode isKindOfClass:[NSNumber class]]) {
        NSInteger code = [sexCode intValue];
        if (code == 0) {
            return @"";
        }else if(code == 1) {
            return @"男";
        }else {
            return @"女";
        }
    }
    return @"";
}

@end
