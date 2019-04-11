//
//  UIView+Frame_gl.m
//  ZJInternetHospital
//
//  Created by gulu on 2017/7/6.
//  Copyright © 2017年 gulu. All rights reserved.
//

#import "UIView+Frame_gl.h"

@implementation UIView (Frame_gl)

- (CGFloat)x_gl {
    return self.frame.origin.x;
}

- (CGFloat)y_gl {
    return self.frame.origin.y;
}

- (CGFloat)centerX_gl {
    return self.center.x;
}

- (CGFloat)centerY_gl {
    return self.center.y;
}

- (CGFloat)height_gl {
    return self.frame.size.height;
}

- (CGFloat)width_gl {
    return self.frame.size.width;
}

@end
