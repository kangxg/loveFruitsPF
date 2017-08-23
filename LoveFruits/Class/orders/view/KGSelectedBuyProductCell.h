//
//  KGSelectedBuyProductCell.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"
#import "KGGoodsModelInterface.h"
@interface KGSelectedBuyProductCell : KGBaseTableViewCell
-(void)updateViews:(id<KGGoodsModelInterface>)goods;
@end
