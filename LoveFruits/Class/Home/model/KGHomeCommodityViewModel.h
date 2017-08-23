//
//  KGHomeCommodityViewModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class KGHomeCommodityCellModel;

@interface KGHomeCommodityViewModel : KGBaseModel
@property (nonatomic,retain)NSMutableArray<KGHomeCommodityCellModel *> * KDCellModelArry;
@end
