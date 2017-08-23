//
//  KGGoodsPriceView.m
//  LoveFruits
//
//  Created by kangxg on 16/10/2.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGGoodsPriceView.h"
#import "KGGoodsModel.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
@interface KGGoodsPriceView()
@property (nonatomic,retain)UILabel     * MVMoneyTypeLabel;
@property (nonatomic,retain)UILabel     * MVSriceLabel;
@property (nonatomic,retain)UILabel     * MVSriceUnitLabel;
@end

@implementation KGGoodsPriceView
@synthesize MVSriceLabel      = _MVSriceLabel;
@synthesize MVMoneyTypeLabel  = _MVMoneyTypeLabel;
@synthesize MVSriceUnitLabel  = _MVSriceUnitLabel;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.MVMoneyTypeLabel];
        [self addSubview:self.MVSriceLabel];
        [self addSubview:self.MVSriceUnitLabel];
    }
    return self;
}
-(void)updateViews:(KGGoodsModel *)model
{
    if (model)
    {
        _MVMoneyTypeLabel.text = @"￥";
        [_MVMoneyTypeLabel sizeToFit];
        
        _MVSriceLabel.text = [NSString stringWithFormat:@"%@",model.price];
        [_MVSriceLabel sizeToFit];
        
        _MVSriceUnitLabel.text = [NSString stringWithFormat:@"/%@",model.spec];
        [_MVSriceUnitLabel sizeToFit];
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _MVMoneyTypeLabel.frame = CGRectMake(0, 15-_MVMoneyTypeLabel.v_height, _MVMoneyTypeLabel.v_width, _MVMoneyTypeLabel.v_height);
    _MVSriceLabel.frame = CGRectMake(_MVMoneyTypeLabel.v_right, 0, _MVSriceLabel.v_width, _MVSriceLabel.v_height);
    _MVSriceUnitLabel.frame = CGRectMake(_MVSriceLabel.v_right+1, 15-_MVSriceUnitLabel.v_height, _MVSriceUnitLabel.v_width,_MVSriceUnitLabel.v_height);
    _MVSriceLabel.center = CGPointMake(_MVSriceLabel.v_x+_MVSriceLabel.v_width/2, _MVMoneyTypeLabel.center.y);

    _MVSize = CGSizeMake(_MVMoneyTypeLabel.v_width + _MVSriceLabel.v_width+_MVSriceUnitLabel.v_width, _MVSriceLabel.v_height);

}
-(UILabel *)MVMoneyTypeLabel
{
    if (_MVMoneyTypeLabel == nil)
    {
        _MVMoneyTypeLabel            = [[UILabel alloc]init];
        _MVMoneyTypeLabel.font       = [UIFont systemFontOfSize:11.0f];
        _MVMoneyTypeLabel.textColor  = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVMoneyTypeLabel;
}

-(UILabel *)MVSriceLabel
{
    if (_MVSriceLabel == nil)
    {
        _MVSriceLabel                = [[UILabel alloc]init];
        _MVSriceLabel.font           = [UIFont systemFontOfSize:15.0f];
        _MVSriceLabel.textColor      = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVSriceLabel;
}

-(UILabel *)MVSriceUnitLabel
{
    if (_MVSriceUnitLabel == nil)
    {
        _MVSriceUnitLabel            = [[UILabel alloc]init];
        _MVSriceUnitLabel.font       = [UIFont systemFontOfSize:11.0f];
        _MVSriceUnitLabel.textColor  = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVSriceUnitLabel;
}


@end
