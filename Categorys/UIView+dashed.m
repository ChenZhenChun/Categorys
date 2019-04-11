//
//  UIView+dashed.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/2.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UIView+dashed.h"

@implementation UIView (dashed)

- (void)gradientStartColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
              cornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    //位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)gradientStartColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
                     frame:(CGRect)frame
              cornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    //位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = frame;
    gradientLayer.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)applyGradientMaskForFadeLength:(CGFloat)fadeLength {
    
    // Remove any in-flight animations
    [self.layer.mask removeAllAnimations];
    
    // Configure gradient mask without implicit animations
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CAGradientLayer *gradientMask = (CAGradientLayer *)self.layer.mask;
    
    // Set up colors
    NSObject *transparent = (NSObject *)[[UIColor clearColor] CGColor];
    NSObject *opaque = (NSObject *)[[UIColor blackColor] CGColor];
    
    if (!gradientMask) {
        // Create CAGradientLayer if needed
        gradientMask = [CAGradientLayer layer];
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        gradientMask.startPoint = CGPointMake(0.0f, 0.5f);
        gradientMask.endPoint = CGPointMake(1.0f, 0.5f);
    }
    
    // Check if there is a mask-to-bounds size mismatch
    if (!CGRectEqualToRect(gradientMask.bounds, self.bounds)) {
        // Adjust stops based on fade length
        CGFloat leftFadeStop = fadeLength/self.bounds.size.width;
        CGFloat rightFadeStop = fadeLength/self.bounds.size.width;
        gradientMask.locations = @[@(0.0f), @(leftFadeStop), @(1.0f - rightFadeStop), @(1.0f)];
    }
    
    gradientMask.bounds = self.layer.bounds;
    gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // Set mask
    self.layer.mask = gradientMask;
    
    // Determine colors for non-scrolling label (i.e. at home)
    NSArray *adjustedColors;
    adjustedColors = @[(transparent),
                       opaque,
                       opaque,
                       opaque];
    gradientMask.colors = adjustedColors;
    [CATransaction commit];
}

/**
 *  通过 CAShapeLayer方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 **/

- (void)drawLineOfDashByCAShapeLayerWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing],nil]];
    //  设置路径
    CGMutablePathRef path =CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL, 0,0);
    CGPathAddLineToPoint(path,NULL,CGRectGetWidth(self.frame),0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end
