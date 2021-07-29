//
//  UIView+dashed.m
//  ZJInternetHospital
//
//  Created by gulu on 17/8/2.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UIView+dashed.h"
#import <objc/runtime.h>

NSString  *const kIsUseSetMaskWithImageKey = @"MLCALayer__SetMaskWithImage__isUseSetMaskWithImage";

@interface CALayer (SetMaskWithImage)
//给CALayer添加个标识是否使用UIView的SetMaskWithImage功能设置的mask
@property (nonatomic,strong) NSNumber *isUseSetMaskWithImage;

@end

IB_DESIGNABLE

@implementation CALayer (SetMaskWithImage)

#pragma mark -  add isUseSetMaskWithImage property
- (void)setIsUseSetMaskWithImage:(NSNumber*)isUseSetMaskWithImage{
    [self willChangeValueForKey:kIsUseSetMaskWithImageKey];
    objc_setAssociatedObject(self, &kIsUseSetMaskWithImageKey, isUseSetMaskWithImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kIsUseSetMaskWithImageKey];
}

- (NSNumber*)isUseSetMaskWithImage{
    return objc_getAssociatedObject(self, &kIsUseSetMaskWithImageKey);
}
#pragma mark - hook setMask
- (void)setMask__hook:(CALayer *)mask
{
    [self setMask__hook:mask];
    
    self.isUseSetMaskWithImage = @(NO);
}

@end

@implementation UIView (dashed)


inline static CGRect CGRectCenterRectForResizableImage(UIImage *image) {
    return CGRectMake(image.capInsets.left/image.size.width, image.capInsets.top/image.size.height, (image.size.width-image.capInsets.right-image.capInsets.left)/image.size.width, (image.size.height-image.capInsets.bottom-image.capInsets.top)/image.size.height);
}


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


- (void)setMaskWithImage:(UIImage*)image{
    //需要先hook view的setFrame:,用来能同步设置mask的frame
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这个在整个app的生命周期，只需要替换一次。
        Swizzle([UIView class], NSSelectorFromString(@"setFrame:"), @selector(setFrame__hook:));
        Swizzle([CALayer class], NSSelectorFromString(@"setMask:"), @selector(setMask__hook:));
    });
    //根据
    CALayer *mask = [CALayer layer];
    mask.contents = (id)image.CGImage;
    mask.contentsScale = [UIScreen mainScreen].scale;
    //设置拉伸属性，根据capInsets，找到可拉伸的矩形
    CGRect capRect = CGRectCenterRectForResizableImage(image);
    mask.contentsCenter = capRect;
    mask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.mask = mask;
    self.layer.isUseSetMaskWithImage = @(YES);
}

- (void)setFrame__hook:(CGRect)frame{
    [self setFrame__hook:frame];
    //这里只有当前对象使用过setMaskWithImage方法后才会同步修正mask的frame，否则不修正
    //没办法，因为用了objcruntime，所以需要尽量的去防止意外情况。
    if(self.layer.mask&&self.layer.isUseSetMaskWithImage&&[self.layer.isUseSetMaskWithImage boolValue]){
        self.layer.mask.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
}

//静态就交换静态，实例方法就交换实例方法
void Swizzle(Class c, SEL origSEL, SEL newSEL) {
    //获取实例方法
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        //获取静态方法
        origMethod = class_getClassMethod(c, origSEL);
        newMethod = class_getClassMethod(c, newSEL);
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
    }
    
    if (!origMethod||!newMethod) {
        return;
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        //添加成功一般情况是因为，origSEL本身是在c的父类里。这里添加成功了一个继承方法。
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}


@end
