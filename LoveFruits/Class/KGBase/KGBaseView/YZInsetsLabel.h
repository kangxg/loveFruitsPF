//
//  YZInsetsLabel.h
//  YZJOB-2
//
//  Created by kangxg on 15/9/2.
//  Copyright (c) 2015年 lfh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZInsetsLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;
@end
