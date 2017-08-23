//
//  KGHeadNoneRightCell.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHeadNoneRightCell.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@implementation KGHeadNoneRightCell
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
    

    _rightIcon=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-6-22, cellSize.height/2-22/2, 22, 22)];
    self.rightIcon.image=[UIImage imageNamed:@"rightlead"];
    [self addSubview: _rightIcon];
    
    
    
}

@end
