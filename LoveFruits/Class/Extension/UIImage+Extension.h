//
//  UIImage+Extension.h
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+(UIImage *)imageWithColor:(UIColor *) color size:(CGSize)size alpha:(CGFloat)alpha;
+(UIImage *)createImageFromView:(UIView *)view;
-(UIImage *)imageClipOvalImage;
@end
