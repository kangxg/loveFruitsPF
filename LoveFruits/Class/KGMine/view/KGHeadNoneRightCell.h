//
//  KGHeadNoneRightCell.h
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"

@interface KGHeadNoneRightCell : KGBaseTableViewCell
@property(strong,nonatomic) UILabel * titltLabel;
@property(strong,nonatomic) UIImageView * rightIcon;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
@end
