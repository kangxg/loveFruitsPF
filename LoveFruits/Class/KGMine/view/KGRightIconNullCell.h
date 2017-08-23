//
//  KGRightIconNullCell.h
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"

@interface KGRightIconNullCell : KGBaseTableViewCell
@property(strong,nonatomic) UIImageView * iconImage;

@property(strong,nonatomic) UILabel * contenLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
@end
