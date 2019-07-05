//
//  UINavigationItem+GLNavigationItem.h
//  ZJInternetHospital
//
//  Created by gulu on 2017/10/13.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (GLNavigationItem)

/**
 create a UIBarButtonItem object

 @param title 文本
 @param textColor 文本颜色
 @param target 代理对象
 @param action 代理方法
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *_Nullable)gl_rightBarButtonItem:(NSString *_Nullable)title color:(UIColor *_Nullable)textColor target:(nullable id)target action:(nullable SEL)action;
@end
