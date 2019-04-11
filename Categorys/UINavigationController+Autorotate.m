//
//  UINavigationController+Autorotate.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/8/10.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UINavigationController+Autorotate.h"

@implementation UINavigationController (Autorotate)
- (BOOL)shouldAutorotate {
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end
