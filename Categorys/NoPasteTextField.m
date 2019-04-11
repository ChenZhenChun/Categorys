//
//  NoPasteTextField.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/8/12.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "NoPasteTextField.h"

@implementation NoPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action ==@selector(paste:)){
        //禁止粘贴
        return NO;
    }
    return[super canPerformAction:action withSender:sender];
}

@end
