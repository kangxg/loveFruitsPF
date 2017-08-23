//
//  KGMineViewTableCell.m
//  LoveFruits
//
//  Created by kangxg on 16/9/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMineViewTableCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface KGMineViewTableCell()

-(void)createUIWithSize:(CGSize)cellSize;
-(void)setMyViewModel:(KGMineViewModel *)model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
@end
@implementation KGMineViewTableCell
@synthesize titltLabel = _titltLabel;
@synthesize rightIcon  = _rightIcon;
@synthesize iconImage  = _iconImage;
+(instancetype)cellWithTableview:(UITableView*)tableview cellSize:(CGSize)cellSize
{
    
    static NSString * str=@"cell";
    KGMineViewTableCell *  cell= [[KGMineViewTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str cellSize:cellSize];
    
    return cell;
    
    
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createUIWithSize:cellSize];
        
    }
    
    return self;
    
}
-(void)createUIWithSize:(CGSize)cellSize
{
    
    _titltLabel= [[UILabel alloc]initWithFrame:CGRectMake(54, 0, 150, 50)];
    _titltLabel.font= [UIFont systemFontOfSize:16.0f];
    _titltLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
    
    [self addSubview:_titltLabel];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(14, 10, 30, 30)];
    [self addSubview:_iconImage];
    
    _rightIcon=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-6-22, cellSize.height/2-22/2, 22, 22)];
    self.rightIcon.image=[UIImage imageNamed:@"rightlead"];
    [self addSubview: _rightIcon];
    
    
    
}

-(void)setMyViewModel:(KGMineViewModel *)model
{
    self.titltLabel.text=model.name;
    self.iconImage.image=[UIImage imageNamed:model.imageName];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
