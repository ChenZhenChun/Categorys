//
//  UIImage+Making.h
//  ZJInternetHospital
//
//  Created by gulu on 17/8/23.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Making)

//制作纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
+(UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;
- (UIImage *)thumbnailWithSize:(CGSize)asize;


/**
 绘制渐变色image

 @param colors 颜色数组
 @param size 大小
 @param gradientType 0：从上到下 1：从左到右 2：左上到右下 3：右上到左下
 @return
 */
+ (UIImage*)imageFromColors:(NSArray *)colors size:(CGSize)size ByGradientType:(NSInteger)gradientType;
@end
