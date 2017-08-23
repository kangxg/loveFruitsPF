//
//  KGMineViewModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/19.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@interface KGMineViewModel : KGBaseModel
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * imageName;
@property(copy,nonatomic)NSString * UserName;

@property (nonatomic,retain)YZRequestItem            *   KDCouponUnuseRequestItem;

@property (nonatomic,assign)NSInteger  KDHaveCouponCount;
@end
