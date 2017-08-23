//
//  KGCouponModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponModel.h"

@implementation KGCouponModel
-(BOOL)putInDataFordic:(id)data
{
    if (!data) {
        return false;
    }
    NSDictionary * dic = data;
    _couponId     = [dic valueForKey:@"coupon_id"];
    _couponName   = [dic valueForKey:@"coupon_name"];
    _couponLimit  = [dic valueForKey:@"coupon_limit"];
    _coupondenom  = [dic valueForKey:@"coupon_denom"];
    _couponDate   = [dic valueForKey:@"expiry_date"];
    _couponType   = [dic valueForKey:@"coupon_type"];
    
    
    return YES;
}
@end
#pragma mark
#pragma mark ------ 已过期 ---------
@implementation KGOverCouponModel

@end
#pragma mark
#pragma mark ------ 已经使用 -------
@implementation KGUseCouponModel
@end
#pragma mark
#pragma mark ------ 未使用------
@implementation KGUnUserCouponModel
@end

@implementation KGHomeCouponCenterModel

@end
