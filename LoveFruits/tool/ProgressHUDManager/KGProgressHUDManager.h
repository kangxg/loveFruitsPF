//
//  KGProgressHUDManager.h
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KGProgressHUDManager : NSObject
+(void)setBackgroundColor:(UIColor *)color;
+(void)setForegroundColor:(UIColor *)color;
+(void)setSuccessImage:(UIImage *)image;
+(void)setErrorImage:(UIImage *)image;
+(void)setFont:(UIFont *)font;
+(void)showImage:(UIImage *)image  status:(NSString *)status;
+(void)show;
+(void)dismiss;
+(void)showWithStatus:(NSString *)status;
+(BOOL)isVisible;
+(void)showSuccessWithStatus:(NSString *)status;
@end
