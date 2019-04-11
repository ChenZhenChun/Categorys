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

 @param title
 @param textColor
 @param target
 @param action
 @return
 */
+ (UIBarButtonItem *_Nullable)gl_rightBarButtonItem:(NSString *_Nullable)title color:(UIColor *_Nullable)textColor target:(nullable id)target action:(nullable SEL)action;
@end
