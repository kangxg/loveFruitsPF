//
//  KGPayTableCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPayTableCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface KGPayTableCell()
@property (nonatomic,retain)UILabel * MVNameLabel;
@property (nonatomic,retain)UIButton      * MVSelectButton;
@end

@implementation KGPayTableCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.MVSelectButton];
    }
    return self;
}

-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel = [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:14];
        _MVNameLabel.text = @"在线支付：";
        _MVNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _MVNameLabel;
}
-(UIButton *)MVSelectButton
{
    if (_MVSelectButton == nil)
    {
        _MVSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
          [_MVSelectButton setImage:[UIImage imageNamed:@"shopping-press"]  forState:UIControlStateNormal];
//        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
//        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping-press"] forState:UIControlStateSelected];
//        [_MVSelectButton addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVSelectButton;
}
-(void)clickSelected:(UIButton *)button
{
    button.selected = ! button.selected ;
    
    if (self.KVDelegate &&[self.KVDelegate respondsToSelector:@selector(pSelectedView:withInfo:)])
    {
        [self.KVDelegate pSelectedView:self withInfo:@{@"seleted":@(button.selected)}];
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    float w = 80;
    _MVNameLabel.frame = CGRectMake(10, 0, w, self.v_height);
     _MVSelectButton.frame = CGRectMake(ScreenWidth-33, (self.v_height-22)/2, 22, 22);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
