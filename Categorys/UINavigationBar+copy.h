//
//  UINavigationBar+copy.h
//  iosDemo
//
//  Created by gulu on 17/9/21.
//  Copyright © 2015年 zoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (copy)
/*
 将tabBar标签页中对应viewController的导航栏配置（NavigationBar）复制给tabBar导航栏.使项目共用一个navigationController.
 */
+ (void)copyNavigationBarFrom:(UITabBarController *)tabBarController to:(UIViewController *)viewController;
@end
