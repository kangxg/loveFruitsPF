//
//  KGHotView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@class HeadData;
@interface KGHotView : UIView
@property (nonatomic,weak)HeadData  * KGHeadData;
-(id)initWithFrame:(CGRect)frame   iconClick:(KGImageClick)block;
@end
