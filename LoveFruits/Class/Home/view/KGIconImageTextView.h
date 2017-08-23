//
//  KGIconImageTextView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activities;
@interface KGIconImageTextView : UIView
@property (nonatomic,retain)Activities * KGActivity;
-(instancetype)initWithFrame:(CGRect)frame withPlaceholderImage:(UIImage * )placeholderImage;
@end
