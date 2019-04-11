//
//  NSString+Map.h
//  ZJInternetHospital
//
//  Created by gulu on 2017/9/14.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Map)
/**
 性别编码转中文
 
 @param sexCode 0：未知；1：男；2：女
 @return
 */
+ (NSString *)gl_sexNameByCode:(id)sexCode;
@end
