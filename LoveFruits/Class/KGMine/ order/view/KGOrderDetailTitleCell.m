//
//  KGOrderDetailTitleCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderDetailTitleCell.h"
#import "KGOrderDetailViewModel.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface KGOrderDetailTitleCell()
@property (nonatomic,retain)UIImageView   * MVHeadImageView;
@property (nonatomic,retain)UILabel       * MVOrderTitleLabel;
@property (nonatomic,retain)UILabel       * MVOrderNumLabel;

@property (nonatomic,retain)UILabel       * MVOrderNumValueLabel;
@end
@implementation KGOrderDetailTitleCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
         [self createImageView];
         [self createLabelView];
    }
    return self;
}
-(void)createLabelView
{
    [self addSubview:self.MVOrderTitleLabel];
    [self addSubview:self.MVOrderNumLabel];
    [self addSubview:self.MVOrderNumValueLabel];
}

-(void)createImageView
{
    [self addSubview:self.MVHeadImageView];
}
-(UILabel *)MVOrderNumLabel
{
    if (_MVOrderNumLabel == nil)
    {
        _MVOrderNumLabel = [[UILabel alloc]init];
        _MVOrderNumLabel.font = [UIFont systemFontOfSize:16];
        _MVOrderNumLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _MVOrderNumLabel;
}
-(UIImageView *)MVHeadImageView
{
    if (_MVHeadImageView == nil)
    {
        _MVHeadImageView = [[UIImageView alloc]init];
        _MVHeadImageView.image = [UIImage imageNamed:@"头部"];
    }
    return _MVHeadImageView;
}
-(UILabel *)MVOrderNumValueLabel
{
    if (_MVOrderNumValueLabel == nil)
    {
        _MVOrderNumValueLabel = [[UILabel alloc]init];
        _MVOrderNumValueLabel.font = [UIFont systemFontOfSize:16];
        _MVOrderNumValueLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _MVOrderNumValueLabel;
}
-(UILabel *)MVOrderTitleLabel
{
    if (_MVOrderTitleLabel == nil)
    {
        _MVOrderTitleLabel = [[UILabel alloc]init];
        _MVOrderTitleLabel.font = [UIFont systemFontOfSize:22];
        _MVOrderTitleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _MVOrderTitleLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVHeadImageView.frame = CGRectMake(0, 0, ScreenWidth, 80);
    _MVOrderTitleLabel.frame = CGRectMake(40, 0, ScreenWidth-80, 80);
    _MVOrderNumLabel.frame   = CGRectMake(10, 80, _MVOrderNumLabel.v_width, 48);
    _MVOrderNumValueLabel.frame   = CGRectMake(_MVOrderNumLabel.v_right +20, 80, ScreenWidth-40-_MVOrderNumLabel.v_width, 48);
}
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    KGOrderDetailModel * orderModel = model;
    
    _MVOrderTitleLabel.text = orderModel.KDTypeMessage;
    [_MVOrderTitleLabel sizeToFit];
    
    _MVOrderNumLabel.text = @"订单号";
    [_MVOrderNumLabel sizeToFit];
    
    _MVOrderNumValueLabel.text = orderModel.KDOrderId;
    
    [_MVOrderNumValueLabel sizeToFit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
