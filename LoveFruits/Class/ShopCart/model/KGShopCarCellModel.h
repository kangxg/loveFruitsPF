//
//  KGShopCarCellModel.h
//  LoveFruits
//
//  Created by kangxg on 16/10/2.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGGoodsModelInterface.h"
@interface KGShopCarCellModel : KGBaseModel
@property (nonatomic,assign)BOOL  KDIsSelected;
@property (nonatomic,copy)NSString * KDPid;
@property (nonatomic,weak)id<KGGoodsModelInterface>   KDModel;
@end
