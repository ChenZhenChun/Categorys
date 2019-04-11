//
//  UIView+dashed.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/2.
//  Copyright © 2017年 gulu. All rights reserved.
//  uiview 绘制虚线

#import <UIKit/UIKit.h>

@interface UIView (dashed)


/**
 绘制渐变图层
 startPoint&endPoint 颜色渐变的方向，范围在(0,0)与(1,1)之间，如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param startColor
 @param endColor
 @param startPoint 开始的位置
 @param endPoint 结束的位置
 @param cornerRadius 圆角半径
 */
- (void)gradientStartColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
              cornerRadius:(CGFloat)cornerRadius;

/**
 绘制渐变图层

 startPoint&endPoint 颜色渐变的方向，范围在(0,0)与(1,1)之间，如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param startColor
 @param endColor
 @param startPoint 开始的位置
 @param endPoint 结束的位置
 @param frame
 @param cornerRadius 圆角半径
 */
- (void)gradientStartColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
                     frame:(CGRect)frame
              cornerRadius:(CGFloat)cornerRadius;

/**
 周边模糊渐变

 @param fadeLength 
 */
- (void)applyGradientMaskForFadeLength:(CGFloat)fadeLength;


/**
 *  通过 CAShapeLayer方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 **/

- (void)drawLineOfDashByCAShapeLayerWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
