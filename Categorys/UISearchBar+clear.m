//
//  UISearchBar+clear.m
//  MH_DOCTOR
//
//  Created by gulu on 17/12/24.
//  Copyright © 2015年 Xiamen Zoenet Tech Co.,Ltd. All rights reserved.
//

#import "UISearchBar+clear.h"

@implementation UISearchBar (clear)
+ (void)clearBackgroundForSearchBar:(UISearchBar *)searchBar{
    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:searchBar.bounds.size];
    UITextField *searchField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
        searchField=[searchBar.subviews objectAtIndex:1];
    }
    else {
        searchField=[((UIView *)[searchBar.subviews objectAtIndex:0]).subviews lastObject];
    }
//    searchField.layer.borderColor = [[UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:1] CGColor];
    searchField.layer.borderColor = [[UIColor grayColor]CGColor];
    searchField.layer.borderWidth = 0.5;
}

+ (void)setBackgroundForSearchBar:(UISearchBar *)searchBar withColor:(UIColor *)color {
    searchBar.backgroundImage = [self imageWithColor:color size:searchBar.bounds.size];
}
//取消searchbar背景色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
