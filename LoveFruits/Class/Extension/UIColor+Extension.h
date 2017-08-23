//
//  UIColor+Extension.h
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
+(UIColor *)colorWithCustom:(CGFloat) red withGreen:(CGFloat) green withBlue:(CGFloat)blue;
+(UIColor *)randomColor;

+ (UIColor *) colorWithHexString: (NSString *)color ;
@end
