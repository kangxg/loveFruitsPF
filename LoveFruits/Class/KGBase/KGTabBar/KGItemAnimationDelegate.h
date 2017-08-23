//
//  KGItemAnimationDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol KGItemAnimationDelegate <NSObject>
@optional
-(void)playAnimation:(UIImageView *)icon textLabel:(UILabel*)textLabel;
-(void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel*)textLabel defaultTextColor:(UIColor * )defaultTextColor;
-(void)selectedState:(UIImageView *)icon textLabel:(UILabel*)textLabel;
@end
