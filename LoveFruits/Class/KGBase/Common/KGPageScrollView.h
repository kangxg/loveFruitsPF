//
//  KGPageScrollView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@class HeadData;
@interface KGPageScrollView : UIView
@property (nonatomic,retain)HeadData * KGHeadData;
-(id)initWithFrame:(CGRect)frame  withPlaceholder:(UIImage *)placeholder withBlock:(KGImageClick)block;
@end
