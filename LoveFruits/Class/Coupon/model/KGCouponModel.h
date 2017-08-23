//
//  KGCouponModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"

@interface KGCouponModel : KGBaseModel
//优惠券面额
@property(nonatomic,copy)NSString * coupondenom;
//优惠券ID
@property(nonatomic,copy)NSString * couponId;
//优惠券名称
@property(nonatomic,copy)NSString * couponName;

//优惠券限制使用金额
@property(nonatomic,copy)NSString * couponLimit;

//使用截止日期
@property(nonatomic,copy)NSString * couponDate;
//已使用：used  未使用：unused    已过期：expired
@property(nonatomic,copy)NSString * couponType;
@end

//已过期
@interface KGOverCouponModel : KGCouponModel

@end
//已经使用
@interface KGUseCouponModel : KGCouponModel
@end
//未使用
@interface KGUnUserCouponModel : KGCouponModel

@end

@interface KGHomeCouponCenterModel : KGCouponModel

@end
