//
//  KGPayMethodTableCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPayMethodTableCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
#import "KGChannelModel.h"
@interface KGPayMethodTableCell()
@property (nonatomic,retain)UIImageView   *   MVImageView;
@property (nonatomic,retain)UILabel       *   MVTitlelabel;
@property (nonatomic,retain)UILabel       *   MVContentLabel;
@property (nonatomic,retain)UIImageView   *   MVSelectImageView;

@end

@implementation KGPayMethodTableCell
@synthesize KVLineLabel = _KVLineLabel;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVImageView];
        [self addSubview:self.MVTitlelabel];
        [self addSubview:self.MVContentLabel];
        [self addSubview:self.MVSelectImageView];
        [self addSubview:self.KVLineLabel];
    }
    return self;
}
-(void)updateCell:(id)model
{
    if (model)
    {
         KGChannelModel *    chmodel = model;
      
        _MVImageView.image           = [UIImage imageNamed:chmodel.KDImg];
        _MVTitlelabel.text           = chmodel.KDTitle;
       
        _MVContentLabel.text         = chmodel.KDContent;
       
        [_MVTitlelabel sizeToFit];
        [_MVContentLabel sizeToFit];
    }
}
-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
    }
    return _MVImageView;
}
-(UIImageView *)MVSelectImageView
{
    if (_MVSelectImageView == nil)
    {
        _MVSelectImageView= [[UIImageView alloc]init];
        _MVSelectImageView.image = [UIImage imageNamed:@"shopping"];
        _MVSelectImageView.highlightedImage = [UIImage imageNamed:@"shopping-press"];
    

    }
    return _MVSelectImageView;
}
-(UILabel *)MVTitlelabel
{
    if (_MVTitlelabel == nil)
    {
        _MVTitlelabel = [[UILabel alloc]init];
        _MVTitlelabel.font = [UIFont systemFontOfSize:14];
        _MVTitlelabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _MVTitlelabel;
}
-(UILabel *)KVLineLabel
{
    if (_KVLineLabel == nil)
    {
        _KVLineLabel = [[UILabel alloc]init];
      
        _KVLineLabel.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _KVLineLabel;
}
-(UILabel *)MVContentLabel
{
    if (_MVContentLabel == nil)
    {
        _MVContentLabel = [[UILabel alloc]init];
        _MVContentLabel.font = [UIFont systemFontOfSize:13];
        _MVContentLabel.textColor = [UIColor colorWithHexString:@"#8d8d8d"];
    }
    return _MVContentLabel;
}
//-(UIButton *)MVSelectButton
//{
//    if (_MVSelectButton == nil)
//    {
//        _MVSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
//        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping-press"] forState:UIControlStateSelected];
//        [_MVSelectButton addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _MVSelectButton;
//}

-(void)clickSelected:(UIButton *)button
{
    button.selected = ! button.selected ;
    
    if (self.KVDelegate &&[self.KVDelegate respondsToSelector:@selector(pSelectedView:withInfo:)])
    {
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    _MVSelectImageView.highlighted  = selected;
    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVImageView.frame    = CGRectMake(15, 20, 50, 50);
    _MVTitlelabel.frame   = CGRectMake(_MVImageView.v_right +10, 20, _MVTitlelabel.v_width, _MVTitlelabel.v_height);
    _MVContentLabel.frame = CGRectMake(_MVImageView.v_right +10,  _MVImageView.v_bottom-_MVContentLabel.v_height, _MVContentLabel.v_width, _MVContentLabel.v_height);
    _MVSelectImageView.frame = CGRectMake(ScreenWidth-33, (self.v_height-22)/2, 22, 22);
    _KVLineLabel.frame    = CGRectMake(15, self.v_height-0.5, ScreenWidth-30, 0.5);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
