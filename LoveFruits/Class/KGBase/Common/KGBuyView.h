//
//  KGBuyView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@class KGGoodsModel;

@interface KGBuyView : UIView
@property (nonatomic,retain)KGGoodsModel       * KGGood;
@property (nonatomic,copy)  KGNomolBlock    KGClickAddShopCar;

@end
