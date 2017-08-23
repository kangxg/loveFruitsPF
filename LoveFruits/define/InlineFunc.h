//
//  InlineFunc.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#ifndef InlineFunc_h
#define InlineFunc_h

static inline UIImage * scaleFromImage(UIImage * image,CGSize size)
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

static inline UIImage * imageWithColor(UIColor * color,CGSize size)
{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}

#endif /* InlineFunc_h */
