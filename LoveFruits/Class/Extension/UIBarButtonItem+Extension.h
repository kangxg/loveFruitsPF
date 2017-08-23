//
//  UIBarButtonItem+Extension.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGEnum.h"
@interface UIBarButtonItem (Extension)
+(UIBarButtonItem  *)barButton:(NSString *)title titleColor:(UIColor *)titleColor withImage:(UIImage *) image hightLightImage:(UIImage *)hightLightImage  target:(id)target action:(SEL) selector type:(KGNavItemButtonType)type;

+(UIBarButtonItem  *)barButton:(UIImage *) image   target:(id)target action:(SEL) selector ;
+(UIBarButtonItem  *)barButton:(NSString *)title titleColor:(UIColor *)titleColor  target:(id)target action:(SEL) selector ;
@end
