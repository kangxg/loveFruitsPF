//
//  KGAnimatedTabBarItem.m
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAnimatedTabBarItem.h"

@implementation KGAnimatedTabBarItem
-(void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    if (!_KGAnimation)
    {
        NSLog(@"add animation in UITabBarItem");
        return;
    
    }
    [_KGAnimation playAnimation:icon textLabel:textLabel];
}

-(void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    if (_KGAnimation)
    {
        [_KGAnimation selectedState:icon textLabel:textLabel];
//        self.image = icon.image;
//        self.title = textLabel.text;
        
    }
}
-(void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)defaultTextColor
{
//    if (_KGAnimation)
//    {
//        [_KGAnimation deselectAnimation:icon textLabel:textLabel defaultTextColor:defaultTextColor];
//    }
}


@end

