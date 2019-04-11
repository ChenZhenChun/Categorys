//
//  NSObject+GLHUD.h
//  ZJInternetHospital
//
//  Created by gulu on 2017/12/18.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GLHUD)
- (void)hud_showHudInView:(UIView *)view hint:(NSString *)hint;
- (void)hud_showHudInView:(UIView *)view;
- (void)hud_showProgressHudInView:(UIView *)view progress:(CGFloat)progress;
- (void)hud_showProgress:(CGFloat)progress;
- (void)hud_modifyText:(NSString *)text detaiText:(NSString *)detailText;
- (void)hud_hide;

//从默认(hideHud:)延迟delay秒
- (void)hud_hideHudAfterDelay:(NSTimeInterval)delay;

- (void)hud_showHintTip:(NSString *)hint;

- (void)hud_showHintError:(NSString *)hint;

- (void)hud_showHintErrorByLocalizedString:(int)code;
@end
