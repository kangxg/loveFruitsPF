//
//  UIImage+Extension.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef   ref  = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(ref, alpha);
    CGContextSetFillColorWithColor(ref, color.CGColor);
    CGContextFillRect(ref, rect);
    
    UIImage * image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
+(UIImage *)createImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
 
    
    UIImage *  image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)imageClipOvalImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
    CGContextRef  ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    [self drawInRect:rect];
   
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
