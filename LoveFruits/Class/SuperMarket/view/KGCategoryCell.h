//
//  KGCategoryCell.h
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGBaseTableViewCell.h"
@class KGCategorie;
@class KGClassificationModel;

@interface KGCategoryCell : KGBaseTableViewCell
@property (nonatomic,weak)KGClassificationModel *  KVModel;
@property (nonatomic,weak)KGCategorie * KCateorie;
+(KGCategoryCell *)cellWithTableView:(UITableView * )tableview;
@end
