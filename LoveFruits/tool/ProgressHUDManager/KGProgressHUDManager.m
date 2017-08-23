//
//  KGProgressHUDManager.m
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProgressHUDManager.h"
#import "SVProgressHUD.h"
@implementation KGProgressHUDManager
+(void)setBackgroundColor:(UIColor *)color
{
    [SVProgressHUD setBackgroundColor:color];
}

+(void)setForegroundColor:(UIColor *)color
{
    [SVProgressHUD setForegroundColor:color];
}

+(void)setSuccessImage:(UIImage *)image
{
    [SVProgressHUD setSuccessImage:image];
}

+(void)setErrorImage:(UIImage *)image
{
    [SVProgressHUD setErrorImage:image];
}

+(void)setFont:(UIFont *)font
{
    [SVProgressHUD setFont:font];
}

+(void)showImage:(UIImage *)image status:(NSString *)status
{
    [SVProgressHUD showImage:image status:status];
}
+(void)show
{
    [SVProgressHUD show];
}

+(void)dismiss
{
    [SVProgressHUD dismiss];
}
+(void)showWithStatus:(NSString *)status
{
    [SVProgressHUD showWithStatus:status];
}
+(BOOL)isVisible
{
    return [SVProgressHUD isVisible];
}

+(void)showSuccessWithStatus:(NSString *)status
{
    [SVProgressHUD showSuccessWithStatus:status];
}
@end
