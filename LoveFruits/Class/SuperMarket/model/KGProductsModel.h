//
//  KGProductsModel.h
//  LoveFruits
//
//  Created by kangxg on 16/10/1.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@class KGGoodsModel;
@interface KGProductsModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem                   * KDRequestItem;
@property (nonatomic,retain)NSMutableArray<KGGoodsModel *>  * KDGoodsModelArr;
@property (nonatomic,assign,readonly)BOOL          KDHasNext;
-(void)resetModel;
@end
