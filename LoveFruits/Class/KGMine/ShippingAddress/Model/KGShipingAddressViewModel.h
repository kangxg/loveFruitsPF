//
//  KGShipingAddressViewModel.h
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGShipAddressModel.h"
@class YZRequestItem;
@interface KGShipingAddressViewModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem       *   KDRequestItem;
@property (nonatomic,retain)NSMutableArray <KGShipAddressModel *>  *KDAddressModelArr;
@end
