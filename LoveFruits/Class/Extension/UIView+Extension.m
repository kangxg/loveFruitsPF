//
//  UIView+Extension.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
-(CGFloat)v_x
{
    return self.frame.origin.x;
}
-(CGFloat)v_y
{
    return self.frame.origin.y;
}
-(CGFloat)v_width
{
    return self.frame.size.width;
}
-(CGFloat)v_height
{
    return self.frame.size.height;
}
-(CGSize)v_size
{
    return self.frame.size;
}
-(CGPoint)v_point
{
    return self.frame.origin;
}

-(CGFloat)v_right
{
    return   self.v_x + self.v_width;
}


-(CGFloat)v_bottom
{
    return self.v_y + self.v_height;
}
- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
