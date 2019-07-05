//
//  UIImage+Common.h
//  IJHealth
//
//  Created by gulu on 17/8/20.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Common)
+ (UIImage*)imageCompressWithSimple:(UIImage*)image toSize:(CGSize)newImageSize;

-(UIImage *)TransformtoSize:(CGSize)Newsize;

/**
 *  将图片修改成灰色
 *  @return image
 */
- (UIImage *)renderingModeAlwaysTemplate;

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

//gif图片处理
+ (UIImage *)gl_animatedGIFNamed:(NSString *)name;

+ (UIImage *)gl_animatedGIFWithData:(NSData *)data;

//设置图片的透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage *)image;

- (UIImage *)gl_animatedImageByScalingAndCroppingToSize:(CGSize)size;

/**
 压缩图片
 
 @param size 压缩尺寸
 @return image
 */
- (UIImage *)glOriginCompressScaleToSize:(CGSize)size;

@end
