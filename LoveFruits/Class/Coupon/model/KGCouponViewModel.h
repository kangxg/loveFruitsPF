//
//  KGCouponViewModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGCouponModel.h"
@class YZRequestItem;
@interface KGCouponViewModel : KGBaseModel
@property (nonatomic,retain)NSMutableArray<KGCouponModel *> * YDUnUseArr;
@property (nonatomic,retain)NSMutableArray<KGCouponModel *> * YDUsedArr;
@property (nonatomic,retain)NSMutableArray<KGCouponModel *> * YDExpiredArr;
@property (nonatomic,retain)YZRequestItem            *  KDCouponUnuseRequestItem;

@property (nonatomic,retain)YZRequestItem            *  KDCouponUsedRequestItem;

@property (nonatomic,retain)YZRequestItem            *  KDCouponExpiredRequestItem;
@end
