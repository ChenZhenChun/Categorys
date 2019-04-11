//
//  UIView+borderLayer.h
//  AiyoyouDemo
//
//  Created by aiyoyou on 2017/3/9.
//  Copyright © 2017年 aiyoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (borderLayer)

/**
 绘制边框
 
 @param frame 边框的大小及位置
 @param width 边框宽度
 @param color 边框颜色
 @param cornerRadius 边框圆角
 */
- (void)shapeLayerWithFrame:(CGRect)frame borderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 绘制边框，边框紧贴当前view的边界
 
 @param width 边框宽度
 @param color 边框颜色
 */
- (void)shapeLayerWithborderWidth:(CGFloat)width borderColor:(UIColor *)color;
@end
