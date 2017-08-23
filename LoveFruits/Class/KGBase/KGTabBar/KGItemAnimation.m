//
//  KGItemAnimation.m
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGItemAnimation.h"
#import <UIKit/UIKit.h>
@interface KGItemAnimation()
@property (nonatomic,assign)CGFloat   MDuration;
@property (nonatomic,retain)UIColor * MTextSelectedColor;
@property (nonatomic,retain)UIColor * MIconSelectedColor;
@end

@implementation KGItemAnimation
-(id)init
{
    if (self = [super init])
    {
        _MDuration = 0.6;
        _MTextSelectedColor = [UIColor grayColor];
    }
    return self;
}

-(void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    
}

-(void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    
}
-(void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)defaultTextColor
{
    
}

@end



@implementation KGBounceAnimation


-(void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    [self playBounceAnimation:icon];
    textLabel.textColor = self.MTextSelectedColor;
}

-(void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel
{
    textLabel.textColor = self.MTextSelectedColor;
    if (icon.image)
    {
        UIImage * renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        icon.image = renderImage;
        icon.tintColor  = self.MTextSelectedColor;
    }
}
-(void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)defaultTextColor
{
    textLabel.textColor = defaultTextColor;
    if (icon.image)
    {
        UIImage * renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        icon.image = renderImage;
        icon.tintColor  = defaultTextColor;
    }
}



-(void)playBounceAnimation:(nullable UIImageView *)icon
{
  CAKeyframeAnimation * bounceAnimation =  [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@(1.0),@(1.4), @(0.9), @(1.15), @(0.95), @(1.02), @(1.0)];
    bounceAnimation.duration = self.MDuration;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    [icon.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    if (icon.image)
    {
         UIImage * renderImage = [icon.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        icon.image = renderImage;
        icon.tintColor  = self.MIconSelectedColor;

    }
}
@end