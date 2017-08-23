//
//  KGOrderInfoCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderInfoCell.h"
#import "KGOrderDetailViewModel.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface KGOrderInfoCell()

@property (nonatomic,retain)UILabel       * MVCouponLabel;
@property (nonatomic,retain)UILabel       * MVCouponValueLabel;

@property (nonatomic,retain)UILabel       * MVPayMoneyLabel;
@property (nonatomic,retain)UILabel       * MVPayMoneyValueLabel;
@property (nonatomic,retain)UILabel       * MVMidLine;
@end
@implementation KGOrderInfoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVCouponLabel];
        [self addSubview:self.MVCouponValueLabel];
        
        [self addSubview:self.MVPayMoneyLabel];
        [self addSubview:self.MVPayMoneyValueLabel];
        [self addSubview:self.MVMidLine];
    }
    return self;
}
-(UILabel *)MVCouponLabel
{
    if (_MVCouponLabel == nil)
    {
        _MVCouponLabel = [[UILabel alloc]init];
        _MVCouponLabel.font = [UIFont systemFontOfSize:14.0f];
        _MVCouponLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVCouponLabel;
}

-(UILabel *)MVCouponValueLabel
{
    if (_MVCouponValueLabel == nil)
    {
        _MVCouponValueLabel = [[UILabel alloc]init];
        _MVCouponValueLabel.font = [UIFont systemFontOfSize:14.0f];
        _MVCouponValueLabel.textAlignment = NSTextAlignmentRight;
        _MVCouponValueLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVCouponValueLabel;
}

-(UILabel *)MVPayMoneyLabel
{
    if (_MVPayMoneyLabel == nil)
    {
        _MVPayMoneyLabel = [[UILabel alloc]init];
        _MVPayMoneyLabel.font = [UIFont systemFontOfSize:14.0f];
        _MVPayMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _MVPayMoneyLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVPayMoneyLabel;
}

-(UILabel *)MVPayMoneyValueLabel
{
    if (_MVPayMoneyValueLabel == nil)
    {
        _MVPayMoneyValueLabel = [[UILabel alloc]init];
        _MVPayMoneyValueLabel.font = [UIFont systemFontOfSize:14.0f];
        _MVPayMoneyValueLabel.textAlignment = NSTextAlignmentRight;
        _MVPayMoneyValueLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
    }
    return _MVPayMoneyValueLabel;
}

-(UILabel *)MVMidLine
{
    if (_MVMidLine == nil)
    {
        _MVMidLine = [[UILabel alloc]init];
        
        _MVMidLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _MVMidLine;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVCouponLabel.frame = CGRectMake(10, 0, ScreenWidth/2-20, 39.5);
    _MVCouponValueLabel.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2-10, 39.5);
    
    _MVMidLine.frame = CGRectMake(10, 39.5, ScreenWidth-20, 0.5);
    
    _MVPayMoneyLabel.frame = CGRectMake(10, 40, ScreenWidth/2-20, 40);
    _MVPayMoneyValueLabel.frame = CGRectMake(ScreenWidth/2, 40, ScreenWidth/2-10, 40);
}

-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    KGOrderDetailModel * orderModel = model;
    _MVCouponLabel.text = @"优惠券";
    [_MVCouponLabel sizeToFit];
 
    _MVCouponValueLabel.text = [NSString stringWithFormat:@"- ￥%ld",(long)orderModel.KDOrderCoupon.integerValue];
    [_MVCouponValueLabel sizeToFit];
    
    _MVPayMoneyLabel.text = @"实付款";
    [_MVPayMoneyLabel sizeToFit];
    
    _MVPayMoneyValueLabel.text    = [NSString stringWithFormat:@"￥%@",orderModel.KDOrderAmount];
     [_MVPayMoneyValueLabel sizeToFit];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
