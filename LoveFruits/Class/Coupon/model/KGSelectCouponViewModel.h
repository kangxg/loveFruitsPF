//
//  KGSelectCouponViewModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "YZRequestItem.h"
@class KGUnUserCouponModel;
@class KGCouponModel;
@interface KGSelectCouponViewModel : KGBaseModel
@property (nonatomic,retain)NSMutableArray<KGUnUserCouponModel  *> * YDCouponModelArr;
@property (nonatomic,retain)YZRequestItem            *  KDCouponRequestItem;

@property (nonatomic,retain)NSMutableDictionary      *  KDSelectedCouponDic;

-(void)resetSelectedCoupon:(KGCouponModel  *)model;
@end
