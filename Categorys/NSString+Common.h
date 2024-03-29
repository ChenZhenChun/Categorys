//
//  NSString+Common.m
//  ZJInternetHospital
//
//  Created by gulu on 17/12/31.
//  Copyright © 2017年 gulu. All rights reserved.
//


/*!
 * @brief NSString 的能用扩展
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

// 获取Documents路径
+ (NSString *)documentPath;

//判断是否为空
+ (BOOL) isBlankString:(NSString *)string;

//生成uuid
+ (NSString *)createUUID;

/**
 创建uuid号

 @return uuid
 */
+(NSString *)createNewUUID;

// 获取缓存路径
+ (NSString *)cachePath;

+ (NSString *)imageCachePath;
//根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName;
+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type;

//返回不同颜色的文字字符串
+ (NSMutableAttributedString *)textStr:(NSString *)str withChangeColorStr:(NSString *)rangeStr forColor:(UIColor *)color withFontSize:(NSInteger)size;



//对象转json字符串
+ (NSString*)DataTOjsonString:(id)object;

/// 从html字符串中抽取纯中文文本
/// @param htmlString htmlString description
+ (NSString *)getStringWithHtmlString:(NSString *)htmlString;

//从字符串中获取数字
+ (NSString *)getTheNumberInTheString:(NSString *)string;

//获取字符串的高度和宽度
+ (CGSize)getTextCGSizeForString:(NSString *)str controlWith:(CGFloat)width FontSize:(CGFloat)size;

/**
 *  根据宽度、字体大小获取字符串高度
 *
 *  @param width 宽度
 *  @param font 字体
 *  @return 高度
 */
+ (CGFloat)heightByWidth:(CGFloat)width andFont:(UIFont *)font andLineSpacing:(CGFloat)spacing content:(NSString *)content;

//SQL防注入
+ (NSString *)SQLPreventInjection:(NSString *)sql;

//获取url参数
+ (NSString *)Analysis:(NSString *)CS webaddress:(NSString *)webaddress;

/**
 *  根据身份证获取性别，返回0是女，1是男
 *
 *  @param card 身份证
 *
 *  @return 性别
 */
+ (NSInteger)getIDCardSex:(NSString *)card;

//是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//计算字符串字符个数
- (int)charNumber;

/**
 *  将字符串时间格式化成其他格式
 *
 *  @param formatStr   原本格式
 *  @param toFormatStr 期望格式
 *  @param dateStr     原本时间字符串
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)formatTimeWithFormate:(NSString *)formatStr toFormatStr:(NSString *)toFormatStr dateStr:(NSString *)dateStr;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

/**
 判断是否是纯汉字
 
 @return boolValue
 */
- (BOOL)isChinese;

/**
 判断是否含有汉字
 
 @return boolValue
 */
- (BOOL)includeChinese;


/**
 判断纯数字
 
 @return boolValue
 */
- (BOOL)isNumber;

/**
 返回富文本----用于设置行间距

 @param lineSpacing 行间距
 @param width 宽度
 @param font 字体
 @return 富文本
 */
- (NSMutableAttributedString *)getByLineSpacing:(NSInteger)lineSpacing width:(CGFloat)width font:(UIFont*)font;

/**
 返回富文本

 @param lineSpacing 行间距
 @param font 字体
 @return 富文本
 */
- (NSMutableAttributedString *)getByLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;

/**
 转换成富文本
 （支持html字符串转换）
 <html><font color='#333333'>合理用药系统警告等级<font color='#ff8831'>【4】。</font>药品之间存在配伍禁忌问题</font></html>
 @param linespacing 行间距
 @return 富文本
 */
- (NSMutableAttributedString *)getAttrStrWithLineSpacing:(CGFloat)linespacing;

/**
 递归计算符合规定的文本长度

 @param maxLenth 最大长度
 @return 字符串
 */
- (NSString *)cutBeyondTextInLength:(NSInteger)maxLenth;
- (NSUInteger)utf8Length;
@end
