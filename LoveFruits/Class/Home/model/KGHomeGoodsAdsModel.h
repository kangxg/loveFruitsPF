//
//  KGGoodsClassifiedAdsModel.h
//  LoveFruits
//
//  Created by kangxg on 16/10/4.
//  Copyright © 2016年 kangxg. All rights reserved.
//
/**
 *  Description  首页商品广告 model
 */
#import "KGBaseModel.h"
#import "KGAdsModelInterface.h"

/**
 *  Description
 */
@interface KGHomeGoodsAdsModel : KGBaseModel<KGAdsModelInterface>
//@property (nonatomic,retain)NSMutableArray < KGGoodsAdsModel *>  * goodsArr;
//@property (nonatomic,copy)NSString           *    pid;
@end


/**
 *  Description 第一类广告
 */
@interface KGHomeFirstAdsModel : KGHomeGoodsAdsModel

@end

/**
 *  Description 第2类广告
 */
@interface KGHomeSecondAdsModel : KGHomeGoodsAdsModel

@end
/**
 *  Description 第3类广告
 */
@interface KGHomeThirdAdsModel : KGHomeGoodsAdsModel

@end
/**
 *  Description 第4类广告
 */
@interface KGHomeFourthAdsModel : KGHomeGoodsAdsModel

@end


