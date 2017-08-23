//
//  KGHaveNavViewVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseVCTR.h"

@interface KGHaveNavViewVCTR : KGBaseVCTR
@property (nonatomic,retain) UILabel  * KVTitleLabel;
@property (nonatomic,retain)UIButton  *  KGNavBackButton;
@property (nonatomic,assign)BOOL KGIsAnimation;
@property (nonatomic,assign)BOOL KGHideBackView;
-(void)setBackView:(BOOL)hiden;
-(void)backBtnClick;

@end
