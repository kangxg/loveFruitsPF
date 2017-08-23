//
//  KGGoodsPriceView.h
//  LoveFruits
//
//  Created by kangxg on 16/10/2.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"
@class KGGoodsModel;
@interface KGGoodsPriceView : KGBaseView
@property (nonatomic,assign)CGSize   MVSize;
-(void)updateViews:(KGGoodsModel *)model;
@end
