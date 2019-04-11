//
//  UIColor+Hex.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/26.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
//十六进制设置颜色
+ (UIColor *)uks_colorWithHexString:(NSString *)color;
@end
