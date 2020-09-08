//
//  NSString+Valid.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/19.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

//是否是合法邮箱
- (BOOL)isValidEmail;

//是否是合法号码
- (BOOL)isValidPhoneNumber;

//是否是合法的18位身份证号码
- (BOOL)isValidPersonID;

//判断是否在地区码内;参数：地区码
- (BOOL)areaCode:(NSString *)code;

//验证密码格式（6-16位数字或字母）
+ (BOOL)validatePassword:(NSString *)passWord;
//验证密码格式（6-16位数字和字母组合）
+ (BOOL)validatePasswordNumAndLetter:(NSString *)passWord;

/// 验证密码格式（8-16位数字、字母、特殊字符组合）
/// @param passWord passWord description
+ (BOOL)validatePasswordLevel3:(NSString *)passWord;

//只能输入0和非0打头的数字
+ (BOOL)isIntergerNumber:(NSString *)number;

//0或非0开头的数字，包括小数
+(BOOL)isDecimalOrInter:(NSString*)number;

//是否是‘digit’位小数的数字。digit:几位小数位。d:整数位位数
+ (BOOL)isDecimalForNumber:(NSString *)number WithIntergerD:(NSInteger)d withDigit:(NSInteger)digit;
/**
 *  正则@ @昵称
 *
 *  @return 正则
 */
+ (NSRegularExpression *)regexAt;
/**
 *  正则话题 #这是话题#
 *
 *  @return 正则
 */
+ (NSRegularExpression *)regexTopic;

/**
 *  正则email
 *
 *  @return 正则
 */
+ (NSRegularExpression *)regexEmail;

/**
 *  正则URL
 *
 *  @return 正则
 */
+ (NSRegularExpression *)regexUrl;
+ (NSRegularExpression *)regexPhoneNumber;
/**
 *  正则 微博表情
 *
 *  @return 正则
 */
+ (NSRegularExpression *)regexEmoticon;
@end
