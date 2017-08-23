//
//  KGProductCell.h
//  LoveFruits
//
//  Created by kangxg on 16/5/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@class KGGoods;
@class KGGoodsModel;
@interface KGProductCell : UITableViewCell
@property (nonatomic,copy)KGAddButtonClick   KGAddProductClick;
@property (nonatomic,retain)KGGoods       *  KMGoods;
@property (nonatomic,weak)KGGoodsModel  *  KMGoodsModel;
+(KGProductCell *)cellWithTableView:(UITableView *)tableview;
-(void)updateWithNote:(id)data;
@end
