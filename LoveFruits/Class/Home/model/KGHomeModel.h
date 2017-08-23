//
//  KGHomeModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@class KGHomeGoodsAdsModel;
@class  HeadData;
@interface KGHomeModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem            *  KDAdvertRequestItem;
@property (nonatomic,retain)YZRequestItem            *  KDListRequestItem;
@property (nonatomic,retain)YZRequestItem            *  KDShopInfoRequestItem;
@property (nonatomic,retain)NSMutableArray<KGHomeGoodsAdsModel * > * KDAdsModelArr;
@property (nonatomic,retain)HeadData                 *  KDHeadData;
@property (nonatomic,copy)NSString                   *  KDShopInformation;
@end
