//
//  UIView+borderLayer.m
//  AiyoyouDemo
//
//  Created by aiyoyou on 2017/3/9.
//  Copyright © 2017年 aiyoyou. All rights reserved.
//

#import "UIView+borderLayer.h"
@implementation UIView (borderLayer)
- (void)shapeLayerWithborderWidth:(CGFloat)width borderColor:(UIColor *)color {
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;//设置shapeLayer的尺寸和位置
    shapeLayer.position = CGPointMake(self.bounds.size.width/2.0,self.bounds.size.height/2.0);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = width;
    shapeLayer.strokeColor = color.CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:shapeLayer];
}

- (void)shapeLayerWithFrame:(CGRect)frame borderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame;//设置shapeLayer的尺寸和位置
    shapeLayer.position = CGPointMake(frame.size.width/2.0,frame.size.height/2.0);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = width;
    shapeLayer.strokeColor = color.CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:shapeLayer];
}
@end
