//
//  CALayer+IJColorLayer.m
//  IJHealth
//
//  Created by gulu on 17/8/26.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "CALayer+IJXibConfiguration.h"

@implementation CALayer (IJColorLayer)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
