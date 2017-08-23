//
//  KGBaseTableViewCell.h
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGTableCellDelegate.h"
@interface KGBaseTableViewCell : UITableViewCell
@property (nonatomic,weak)id<KGTableCellDelegate>  KVDelegate;
@property(strong,nonatomic)UILabel * KVTitleLabel;
-(void)updateCell:(id)model;
@end
