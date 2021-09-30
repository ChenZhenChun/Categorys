//
//  NSObject+GLHUD.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/12/18.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NSObject+GLHUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#define CustomViewHeight 105
#define CustomViewWidth 84

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
@implementation NSObject (GLHUD)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hud_showHudInView:(UIView *)view hint:(NSString *)hint{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:view];
        }
        hud.removeFromSuperViewOnHide = YES;
        [view addSubview:hud];
        hud.labelText = hint;
    //    hud.customView = [self gifImageView:hint];
    //    hud.mode = MBProgressHUDModeCustomView;
    //    hud.color = [UIColor clearColor];
        
        [hud show:YES];
        [self setHUD:hud];
    });
    
}

- (void)hud_showHudInView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:view];
        }
        hud.removeFromSuperViewOnHide = YES;
        [view addSubview:hud];
    //    HUD.labelText = hint;
    //    hud.customView = [self gifImageView:nil];
    //    hud.mode = MBProgressHUDModeCustomView;
    //    hud.color = [UIColor clearColor];
        
        [hud show:YES];
        [self setHUD:hud];
    });
}

- (void)hud_showProgressHudInView:(UIView *)view progress:(CGFloat)progress  {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
            if (!hud) {
                hud = [[MBProgressHUD alloc] initWithView:view];
            }
            hud.removeFromSuperViewOnHide = YES;
            [view addSubview:hud];
            hud.labelText = @"上传中";
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.progress = progress;
            [hud show:YES];
            [self setHUD:hud];
            if (progress==1) {
                hud.labelText = nil;
                hud.detailsLabelText = nil;
                [self hud_showHudInView:view];
            }
        }@catch (NSException *exception) {
            
        }
    });
}

- (void)hud_showProgress:(CGFloat)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [[UIApplication sharedApplication].delegate window];
        [self hud_showProgressHudInView:view progress:progress];
    });
}

- (void)hud_modifyText:(NSString *)text detaiText:(NSString *)detailText {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (!hud) return;
        if (text) hud.labelText = text;
        if (detailText) hud.detailsLabelText = detailText;
    });
    
}

- (void)hud_showHintTip:(NSString *)hint {
    [self hud_showHintTip:hint afterDelay:1];
}

- (void)hud_showHintTip:(NSString *)hint afterDelay:(NSTimeInterval)afterDelay {
    dispatch_async(dispatch_get_main_queue(), ^{
        //显示提示信息
        UIView *view = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }

        hud.userInteractionEnabled = NO;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-happy.png"]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.detailsLabelText = hint;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:afterDelay];
    });
}

- (void)hud_showHintError:(NSString *)hint {
    [self hud_showHintError:hint afterDelay:1];
}

- (void)hud_showHintError:(NSString *)hint afterDelay:(NSTimeInterval)afterDelay {
    dispatch_async(dispatch_get_main_queue(), ^{
        //显示提示信息
        UIView *view = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
        hud.userInteractionEnabled = NO;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-sad.png"]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.detailsLabelText = hint;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:afterDelay];
    });
}



- (void)hud_hide {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self HUD] hide:YES];
    });
    
}

- (void)hud_hideHudAfterDelay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self HUD] hide:YES afterDelay:delay];
    });
}


-(UIImageView*)gifImageView:(NSString *)string {
    @autoreleasepool {
        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CustomViewWidth, CustomViewHeight)];
        NSMutableArray *gifArray = [[NSMutableArray alloc]initWithCapacity:25];
        for (int i = 0; i<83; i++) {
            NSString *imageName = [NSString stringWithFormat:@"gl_loading%d",i];
            [gifArray addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:@"png"]]];
        }
        gifImageView.animationImages = gifArray; //动画图片数组
        gifImageView.animationDuration = 3.0; //执行一次完整动画所需的时长
        gifImageView.animationRepeatCount =0;  //动画重复次数
        [gifImageView startAnimating];



        if (string &&string.length>0) {
            UILabel *alertLable = [[UILabel alloc]initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width/2+gifImageView.frame.size.width/2, gifImageView.frame.size.height-5, [UIScreen mainScreen].bounds.size.width, 30)];
            alertLable.font = [UIFont systemFontOfSize:12];
            alertLable.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
            alertLable.numberOfLines = 0;

            alertLable.text = string;
            alertLable.textAlignment = NSTextAlignmentCenter;
            [gifImageView addSubview:alertLable];
        }
        return gifImageView;
    }
}

- (void)hud_showHintErrorByLocalizedString:(int)code {
//    NSString *errorStr = NSLocalizedString(([NSString stringWithFormat:@"%d",(int)code]),nil);
    NSString *errorStr = NSLocalizedStringFromTable(([NSString stringWithFormat:@"%d",(int)code]),@"GLIMLocalizable", nil);
    if (errorStr&&errorStr.length) {
        [self hud_showHintError:errorStr];
    }
}

@end
