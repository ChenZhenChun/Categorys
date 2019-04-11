//
//  UINavigationItem+GLNavigationItem.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/10/13.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UINavigationItem+GLNavigationItem.h"

@implementation UINavigationItem (GLNavigationItem)
+ (UIBarButtonItem *)gl_rightBarButtonItem:(NSString *)title color:(UIColor *)textColor target:(nullable id)target action:(nullable SEL)action  {
    if (!title) {
        return nil;
    }
    if (!textColor) {
        textColor = [UIColor colorWithRed:255/255.0 green:97/255.0 blue:124/255.0 alpha:1];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
    [rightItem setTintColor:textColor];
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    NSDictionary *disabledDic = [NSDictionary dictionaryWithObjectsAndKeys:[textColor colorWithAlphaComponent:0.6] ,NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    [rightItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    [rightItem setTitleTextAttributes:fontDic forState:UIControlStateSelected|UIControlStateHighlighted];
    [rightItem setTitleTextAttributes:disabledDic forState:UIControlStateDisabled];
    return rightItem;
}
@end
