//
//  KGRightIconNullCell.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGRightIconNullCell.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@implementation KGRightIconNullCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self createUIWithSize:cellSize];
    }
    return self;
}

-(void)createUIWithSize:(CGSize)cellSize
{
    self.KVTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 150, cellSize.height)];
    self.KVTitleLabel.font= [UIFont systemFontOfSize:16.0f];
    self.KVTitleLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:self.KVTitleLabel];
    
    _contenLabel= [[UILabel alloc]initWithFrame:CGRectMake(174, 0, cellSize.width-174-14, cellSize.height)];
    _contenLabel.textAlignment=NSTextAlignmentRight;
    _contenLabel.font= [UIFont systemFontOfSize:14.0f];
    _contenLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
    
    [self addSubview:_contenLabel];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(14, 10, 30, 30)];
    [self addSubview:_iconImage];
    
    
    
    
}
@end
