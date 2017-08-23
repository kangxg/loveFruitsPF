//
//  KGDiscountPriceView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGDiscountPriceView.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "NSString+Extension.h"
#import "UIView+Extension.h"
@interface KGDiscountPriceView()
@property (nonatomic,retain)UILabel    *  MMarketPriceLabel;
@property (nonatomic,retain)UILabel    *  MPriceLabel;
@property (nonatomic,retain)UIView     *  MLineView;
@property (nonatomic,assign)BOOL          MHasMarketPrice;
@end

@implementation KGDiscountPriceView
-(id)initWithPriceView:(NSString *)price markPrice:(NSString *)markPrice
{
    if (self = [super init])
    {
        if (price && price.length)
        {
            self.MPriceLabel.text = [NSString stringWithFormat:@"$%@",[price cleanDecimalPointZear]];
            [self.MPriceLabel sizeToFit];
        }
        
        if (markPrice && markPrice.length)
        {
            self.MMarketPriceLabel.text = [NSString stringWithFormat:@"$%@",[markPrice cleanDecimalPointZear]];
            [self.MMarketPriceLabel sizeToFit];
        }
        else
        {
            _MHasMarketPrice = false;
        }
        
        _MHasMarketPrice  =  !(price == markPrice);
        self.MMarketPriceLabel.hidden = !_MHasMarketPrice;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _MHasMarketPrice = false;
        [self addSubview:self.MMarketPriceLabel];
        [self addSubview:self.MLineView];
        [self addSubview:self.MPriceLabel];
    }
    return self;
}
-(void)setKGPriceColor:(UIColor *)KGPriceColor
{
    if (KGPriceColor)
    {
        self.MPriceLabel.textColor = KGPriceColor;
    }
}

-(void)setKGMarketPriceColor:(UIColor *)KGMarketPriceColor
{
    if (KGMarketPriceColor)
    {
        self.MMarketPriceLabel.textColor = KGMarketPriceColor;
    }
}

-(UILabel *)MPriceLabel
{
    if (_MPriceLabel == nil)
    {
        _MPriceLabel = [[UILabel alloc]init];
        _MPriceLabel.font = HomeCollectionTextFont;
        _MPriceLabel.textColor = [UIColor redColor];
    
    }
    
    return _MPriceLabel;
}

-(UILabel *)MMarketPriceLabel
{
    if (_MMarketPriceLabel  == nil)
    {
        _MMarketPriceLabel = [[UILabel alloc]init];
        _MMarketPriceLabel.font = HomeCollectionTextFont;
        _MMarketPriceLabel.textColor = [UIColor colorWithCustom:80 withGreen:80 withBlue:80];

    }
    return _MMarketPriceLabel;
}

-(UIView *)MLineView
{
    if (_MLineView == nil)
    {
        _MLineView = [[UIView alloc]init];
        _MLineView.backgroundColor = [UIColor colorWithCustom:80 withGreen:80 withBlue:80];
    }
    return _MLineView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.MPriceLabel.frame = CGRectMake(0, 0, _MPriceLabel.v_width, self.v_height);
    if (_MHasMarketPrice)
    {
        self.MMarketPriceLabel.frame =  CGRectMake(CGRectGetMaxX(_MPriceLabel.frame) + 5, 0, _MMarketPriceLabel.v_width, self.v_height);
        self.MLineView.frame  = CGRectMake(0, _MMarketPriceLabel.v_height * 0.5 - 0.5, _MMarketPriceLabel.v_width, 1);
    }
}
@end
