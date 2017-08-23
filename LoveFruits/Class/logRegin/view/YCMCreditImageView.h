//
//  YCMCreditImageView.h
//  YZJOB-2
//
//  Created by kangxg on 15/12/2.
//  Copyright (c) 2015年 lfh. All rights reserved.
//
/**
 *  Description 用于上传图片视图
 */
#import <UIKit/UIKit.h>

#import "KGBaseView.h"
@class KGCreditImageModel;
@interface YCMCreditImageView : KGBaseView
@property (nonatomic,weak,readonly)KGCreditImageModel * MModel;

@property (nonatomic,retain,readonly)UIButton         * MBackGroundBtn;
-(void)putinModel:(KGCreditImageModel *)model;
-(void)putinImage:(UIImage *)image;
@end

@interface YCMAddCreditImageView : KGBaseView
@end