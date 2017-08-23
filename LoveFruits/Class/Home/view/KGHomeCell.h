//
//  KGHomeCell.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
#import "KGHomeCellDelegate.h"
#import "KGEnum.h"
@class Activities;
@class KGGoods;
@class KGHomeGoodsAdsModel;
@class KGGoodsAdsModel;
@interface KGHomeCell: UICollectionViewCell
@property (nonatomic,retain)KGHomeGoodsAdsModel   * KGActivty;
@property (nonatomic,retain)KGGoodsAdsModel       * KGGood;
@property (nonatomic,weak)id<KGHomeCellDelegate>    KVDelegate;

-(void)setGoods:(KGGoodsAdsModel *)goods withType:(KGGoodsAdsType )type;
@end;
@interface KGHomeOherCell : KGHomeCell



//@property (nonatomic,retain)Activities * KGActivty;
//@property (nonatomic,retain)KGGoods    * KGGood;
@property (nonatomic,copy)KGAddButtonClick KGAddButtonBlock;
@end


@interface KGHomeSecondCell : KGHomeCell


@end