//
//  KGCouponTalbleCell.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"
@class KGCouponModel;
@interface KGCouponTalbleCell : KGBaseTableViewCell
@property (nonatomic,retain)UIView       * MVBgView;
@property (nonatomic,retain)UIImageView  * MVLeftImage;
@property (nonatomic,retain)UIImageView  * MVRightImage;
@property (nonatomic,retain)UILabel      * MVCoinLabel;
@property (nonatomic,retain)UILabel      * MVNameLabel;
@property (nonatomic,retain)UILabel      * MVUselabel;
@property (nonatomic,retain)UILabel      * MVDateLabel;
@property (nonatomic,retain)UILabel      * MVRestrictionLabel;
@property (nonatomic,retain)UILabel      * MVLineLabel;
@property (nonatomic,retain)UILabel      * MVUnitLabel;
@property (nonatomic,weak)KGCouponModel  * YVModel;
-(void)createSubView;
-(void)createImageView;
-(void)createCoinLabel;
-(void)createNameLabel;
-(void)createUseStateLabel;
-(void)createDateLabel;
-(void)createRestrictionLabel;
-(void)createLineLabel;
-(void)createUnitLabel;


@end

@interface KGUnUseCouponTalbleCell : KGCouponTalbleCell

@end

@interface KGUseCouponTalbleCell : KGCouponTalbleCell

@end


@interface KGExpiredCouponTalbleCell : KGCouponTalbleCell

@end


@interface KGCouponCenterTalbleCell : KGCouponTalbleCell

@end


@interface KGCouponSelectTalbleCell : KGCouponTalbleCell

@end
