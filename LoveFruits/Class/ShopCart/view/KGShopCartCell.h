//
//  KGShopCartCell.h
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGShopCartCellDelegate.h"
#import "KGGoodsModelInterface.h"
@interface KGShopCartCell : UITableViewCell
@property (nonatomic,weak)id<KGShopCartCellDelegate>  KVDelegate;
@property (nonatomic,weak)id<KGGoodsModelInterface>   KVModel;
+(instancetype)cellWithTableview:(UITableView*)tableview cellSize:(CGSize)cellSize;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
-(void)updateViews:(id<KGGoodsModelInterface>)goods;
@end
