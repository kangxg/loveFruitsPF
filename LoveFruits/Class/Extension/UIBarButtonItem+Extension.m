//
//  UIBarButtonItem+Extension.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "KGCustomButton.h"
@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)barButton:(UIImage *)image target:(id)target action:(SEL)selector
{
    KGNavItemLeftImageButton * btn = [KGNavItemLeftImageButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.frame =  CGRectMake(0, 0, 44, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem *)barButton:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)selector
{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    if (btn.titleLabel.text.length== 2)
    {
        btn.contentEdgeInsets =  UIEdgeInsetsMake(0,0,0,-25);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem *)barButton:(NSString *)title titleColor:(UIColor *)titleColor withImage:(UIImage *)image hightLightImage:(UIImage *)hightLightImage target:(id)target action:(SEL)selector type:(KGNavItemButtonType)type
{
    UIButton * btn ;
    if (type == KGNAVITEMBUTTONTYPELEFT)
    {
        btn = [KGNavItemLeftImageButton buttonWithType:UIButtonTypeCustom];
        
    }
    else if (type == KGNAVITEMBUTTONTYPERIGHT)
    {
        btn = [KGNavItemRightImageButton buttonWithType:UIButtonTypeCustom];
    }
    else
    {
        btn = [[UIButton alloc]init];
    }
    
   
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn setImage:hightLightImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    btn.frame =  CGRectMake(0, 0, 60, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}
@end
