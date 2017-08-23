//
//  KGMineViewTableCell.h
//  LoveFruits
//
//  Created by kangxg on 16/9/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGMineViewModel.h"
@interface KGMineViewTableCell : UITableViewCell
@property(strong,nonatomic) UIImageView * iconImage;

@property(strong,nonatomic) UILabel * titltLabel;
@property(strong,nonatomic) UIImageView * rightIcon;


+(instancetype)cellWithTableview:(UITableView*)tableview cellSize:(CGSize)cellSize;

-(void)setMyViewModel:(KGMineViewModel*)model;
@end


