//
//  UITableViewCell+Separator.m
//  ZJInternetHospital
//
//  Created by gulu on 17/12/31.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UITableViewCell+Separator.h"

@implementation UITableViewCell (Separator)

- (void)setSeparatorInsetTemp:(UIEdgeInsets)edgeInsets {
    //ios7分割线顶头
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:edgeInsets];
        
    }
    
    //ios8分割线顶头
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:edgeInsets];
    }
}


@end
