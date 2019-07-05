//
//  NSString+Common.m
//  ZJInternetHospital
//
//  Created by gulu on 17/12/31.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

#pragma mark - 获取缓存路径
+ (NSString *)cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

+ (NSString *)imageCachePath {
    NSString *path = [[self cachePath] stringByAppendingPathComponent:@"Images"];
    BOOL isDir = NO;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:path
                                                           isDirectory:&isDir];
    if (!isDir && !isDirExist) {
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                   withIntermediateDirectories:YES
                                                                    attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"success");
        }
    }
    
    return path;
}



#pragma mark - 判断是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName {
    return [self pathWithFileName:fileName ofType:nil];
}

+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}


//生成uuid
+ (NSString *)createUUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    CFRelease(uuidObject);
    return uuidStr;
}
+ (NSMutableAttributedString *)textStr:(NSString *)str withChangeColorStr:(NSString *)rangeStr forColor:(UIColor *)color withFontSize:(NSInteger)size {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    //[attributeStr addAttribute:NSForegroundColorAttributeName value:color range:[str rangeOfString:rangeStr]];
    NSMutableDictionary *attributesDic = [[NSMutableDictionary alloc]init];
    [attributesDic setObject:color forKey:NSForegroundColorAttributeName];
    if (size != 0) {
        [attributesDic setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    }
    [attributeStr addAttributes:attributesDic range:[str rangeOfString:rangeStr]];
    return attributeStr;
}

//对象转json字符串
+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = @"";
    NSError *error;
    if (object == nil || object == [NSNull null]) {
        return jsonString;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//从字符串中获取数字
+(NSString *)getTheNumberInTheString:(NSString *)string
{
    return  [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    
}

//获取字符串的高度和宽度
+ (CGSize)getTextCGSizeForString:(NSString *)str controlWith:(CGFloat)width FontSize:(CGFloat)size {
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
}

/**
 *  根据高度、字体大小获取字符串高度
 *
 *  @param width
 *  @param font
 *  @return
 */
+ (CGFloat)heightByWidth:(CGFloat)width andFont:(UIFont *)font andLineSpacing:(CGFloat)spacing content:(NSString *)content {
    if([NSString isBlankString:content] || !font){
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.maximumLineHeight = font.pointSize;
    paragraphStyle.lineSpacing = spacing;//调整行间距
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributeString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:font} range:NSMakeRange(0,content.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options context:nil];

    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([content includeChinese]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size.height;
}


//SQL防注入
+ (NSString *)SQLPreventInjection:(NSString *)sql {
    sql = [sql stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    sql = [sql stringByReplacingOccurrencesOfString:@"--" withString:@"\\--"];
    return sql;
}

//获取url参数
+ (NSString *)Analysis:(NSString *)CS webaddress:(NSString *)webaddress {
    @try {
        NSError *error;
        //NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
        NSString *regTags=[NSString stringWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        
        NSArray *matches = [regex matchesInString:webaddress
                                          options:0
                                            range:NSMakeRange(0, [webaddress length])];
        for (NSTextCheckingResult *match in matches) {
            NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
            return tagValue;
        }
        return @"";
    }
    @catch (NSException *exception) {
        return @"";
    }
    
}

+ (NSInteger)getIDCardSex:(NSString *)card {
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger defaultValue = 0;
    if ([card length] != 18) {
        return defaultValue;
    }
    NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
    //偶数为女
    if (number % 2 == 0) {
        return 0;
    } else {
        return 1;
    }
}

//是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f9dc) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3 || ls == 0xfe0f) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    if ([NSString isBlankString:urlStr]) {
        return nil;
    }
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

//计算字符串字符个数
- (int)charNumber {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;

//    NSData* da = [self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
//    return [da length];
}

//将字符串时间格式化成其他格式
+ (NSString *)formatTimeWithFormate:(NSString *)formatStr toFormatStr:(NSString *)toFormatStr dateStr:(NSString *)dateStr {
    if ([NSString isBlankString:dateStr] || dateStr.length!=formatStr.length) {
        return dateStr;
    }
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc]init];
    dateFmt.AMSymbol = @"上午";
    dateFmt.PMSymbol = @"下午";
    dateFmt.dateFormat = formatStr;
    [dateFmt setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *date = [dateFmt dateFromString:dateStr];
    dateFmt.dateFormat = toFormatStr;
    return [dateFmt stringFromDate:date];
}

//创建uuid号
+(NSString *)createNewUUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    //uuidString= [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidString;
}

//纯汉字
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

//包含中文
- (BOOL)includeChinese {
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

//纯数字
- (BOOL)isNumber {
    if ([NSString isBlankString:self]) return NO;
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}

/**
 返回富文本----用于设置行间距
 */
- (NSMutableAttributedString *)getByLineSpacing:(NSInteger)lineSpacing width:(CGFloat)width font:(UIFont *)font {
    if([NSString isBlankString:self] || !font){
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;//设置省略号
    paragraphStyle.maximumLineHeight = font.pointSize;
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    if(size.height > font.lineHeight){
        //多行
        paragraphStyle.lineSpacing = lineSpacing;//调整行间距
    }else {
        paragraphStyle.lineSpacing = 1;//单行模式下纯字母底部会被截断如“msg”的“g”的尾巴会没掉，所因单行这里行间距设置为1.
    }
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,[self length])];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return attributedString;
}

- (NSMutableAttributedString *)getByLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font {
    if([NSString isBlankString:self]) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;//设置省略号
    paragraphStyle.lineSpacing = lineSpacing;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    if (font) {
        paragraphStyle.maximumLineHeight = font.pointSize;
        [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,[self length])];
    }
    return attributedString;
}

- (NSMutableAttributedString *)getAttrStrWithLineSpacing:(CGFloat)linespacing {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    if ([self containsString:@"<html"]&&[self containsString:@"</html"]) {
        attrStr = [attrStr initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding]
                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                     documentAttributes:nil error:nil];
    }else {
        attrStr = [attrStr initWithString:self];
    }
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = linespacing;
    
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attrStr.string.length)];
    return attrStr;
}

//递归计算符合规定的文本长度
- (NSString *)cutBeyondTextInLength:(NSInteger)maxLenth {
    size_t length = strlen([self UTF8String]);
    if (length > maxLenth) {
        NSString *text = [self substringToIndex:self.length - 1];
        return [text cutBeyondTextInLength:maxLenth];
    }else {
        return self;
    }
}

- (NSUInteger)utf8Length {
    size_t length = strlen([self UTF8String]);
    return length;
}

@end
