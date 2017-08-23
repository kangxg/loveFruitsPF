//
//  KGAnimatedTabBarItem.h
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGItemAnimationDelegate.h"
#import "KGItemAnimation.h"
@interface KGAnimatedTabBarItem : UITabBarItem<KGItemAnimationDelegate>
@property (nonatomic,retain)KGItemAnimation * KGAnimation;
-(void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel;
@end
