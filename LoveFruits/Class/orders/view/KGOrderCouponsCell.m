//
//  KGOrderCouponsCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderCouponsCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface  KGOrderCouponsCell()
@property (nonatomic,retain)UILabel  * MVNameLabel;

@property (nonatomic,retain)UILabel  * MVDesValueLabel;
@end
@implementation KGOrderCouponsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.KVCouponValueLabel];
        [self addSubview:self.MVDesValueLabel];
    }
    return self;
}

-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel = [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:14];
        _MVNameLabel.text = @"优惠券 ";
        _MVNameLabel.textColor = [UIColor colorWithHexString:@"#323232"];
    }
    return _MVNameLabel;
}

-(UILabel *)KVCouponValueLabel
{
    if (_KVCouponValueLabel == nil)
    {
        _KVCouponValueLabel = [[UILabel alloc]init];
        _KVCouponValueLabel.font = [UIFont systemFontOfSize:12];
        _KVCouponValueLabel.text = @"0张可用";
        _KVCouponValueLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _KVCouponValueLabel;
}

-(UILabel *)MVDesValueLabel
{
    if (_MVDesValueLabel == nil)
    {
        _MVDesValueLabel = [[UILabel alloc]init];
        _MVDesValueLabel.font = [UIFont systemFontOfSize:12];
        _MVDesValueLabel.text = @"已抵扣0.00元";
        _MVDesValueLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _MVDesValueLabel;
}
-(void)setUseCouponcount:(NSInteger )count
{
    if (count>=0)
    {
        _KVCouponValueLabel.text = [NSString stringWithFormat:@"%ld张可用",count];
        _MVDesValueLabel.text = @"已抵扣0.00元";
    }
    
}
-(void)setUserCoupon:(NSString *)coupondenom
{
    _KVCouponValueLabel.text = @"已选1张";
    _MVDesValueLabel.text = [NSString stringWithFormat:@"抵扣%@元",coupondenom];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    float w = 80;
    _MVNameLabel.frame = CGRectMake(10, 0, w, self.v_height);
    _KVCouponValueLabel.frame = CGRectMake(_MVNameLabel.v_right+5, 0, w, self.v_height);
    _MVDesValueLabel.frame  = CGRectMake(ScreenWidth-10-w, 0, w, self.v_height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
