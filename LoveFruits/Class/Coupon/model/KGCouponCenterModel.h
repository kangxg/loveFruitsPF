//
//  KGCouponCenterModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/27.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "YZRequestItem.h"
@class KGHomeCouponCenterModel ;
@interface KGCouponCenterModel : KGBaseModel
@property (nonatomic,retain)NSMutableArray<KGHomeCouponCenterModel  *> * YDCouponModelArr;

@property (nonatomic,retain)YZRequestItem            *  KDCouponRequestItem;

@property (nonatomic,retain)YZRequestItem            *  KDGetCouponRequestItem;
@end
