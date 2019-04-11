//
//  UINavigationBar+copy.m
//  iosDemo
//
//  Created by gulu on 17/9/21.
//  Copyright © 2015年 zoe. All rights reserved.
//

#import "UINavigationBar+copy.h"

@implementation UINavigationBar (copy)
+ (void)copyNavigationBarFrom:(UITabBarController *)tabBarController to:(UIViewController *)viewController {
    tabBarController.navigationItem.title = viewController.navigationItem.title;
    tabBarController.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    tabBarController.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    tabBarController.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    tabBarController.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
    tabBarController.navigationItem.titleView = viewController.navigationItem.titleView;
}
@end
