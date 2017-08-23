//
//  KGAdsModelInterface.h
//  LoveFruits
//
//  Created by kangxg on 16/10/4.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGEnum.h"
@class KGGoodsAdsModel;
@protocol KGAdsModelInterface <NSObject>
@property (nonatomic,assign)NSInteger              pid;
@property (nonatomic,assign)KGGoodsAdsType        adsType;

@optional

@property (nonatomic,retain)NSMutableArray < KGGoodsAdsModel *>  * goodsArr;
@property (nonatomic,copy)  NSString     *   detailUrl;
@property (nonatomic,copy)  NSString     *   cpName;

@property (nonatomic,copy)  NSString     *   cpNameDown;
@property (nonatomic,copy)  NSString     *   cpNameLeft;
@property (nonatomic,copy)  NSString     *   cpNameUp;
@property (nonatomic,copy)  NSString     *   imgUrl;
@property (nonatomic,copy)  NSString     *   detailUrlDown;
@property (nonatomic,copy)  NSString     *   detailUrlLeft;
@property (nonatomic,copy)  NSString     *   detailUrlUp;
@property (nonatomic,copy)  NSString     *   imgUrlDown;
@property (nonatomic,copy)  NSString     *   imgUrlLeft;
@property (nonatomic,copy)  NSString     *   imgUrlUp;

@end
