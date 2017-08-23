//
//  KGSelectedBuyProductCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSelectedBuyProductCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
#import "KGGoodsModelInterface.h"
#import "UIImageView+WebCache.h"
@interface KGSelectedBuyProductCell()

@property (nonatomic,weak)id<KGGoodsModelInterface>   KVModel;

@property (nonatomic,retain)UIImageView   * MVGoodsImageView;
@property (nonatomic,retain)UILabel       * MVNameLabel;
@property (nonatomic,retain)UILabel       * MVBuyCountLabel;
@property (nonatomic,retain)UILabel       * MVMoneyCountLabel;
@property (nonatomic,retain)UILabel       * MVUnitLabel;
@property (nonatomic,retain)UILabel       * MVBottonLine;
@end
@implementation KGSelectedBuyProductCell
@synthesize KVModel             = _KVModel;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVGoodsImageView];
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.MVUnitLabel];
        [self addSubview:self.MVBuyCountLabel];
        [self addSubview:self.MVMoneyCountLabel];
        [self addSubview:self.MVBottonLine];
    }
    return self;
}
-(void)updateViews:(id<KGGoodsModelInterface>)goods
{
    if (goods == nil)
    {
        return;
    }
    
     [_MVGoodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_one"]];
    
    _MVNameLabel.text = goods.name;
    [_MVNameLabel sizeToFit];
    
    _MVBuyCountLabel.text  =[NSString stringWithFormat:@"x %@",goods.userBuyNumber] ;
    [_MVBuyCountLabel sizeToFit];
    
    float count =goods.price.floatValue *goods.userBuyNumber.integerValue;
    _MVMoneyCountLabel.text =[NSString stringWithFormat:@"%.2f",count];
    [_MVMoneyCountLabel sizeToFit];
    
    _MVUnitLabel.text = @"￥";
    [_MVUnitLabel sizeToFit];

}
-(UIImageView *)MVGoodsImageView
{
    if (_MVGoodsImageView == nil)
    {
        _MVGoodsImageView = [[UIImageView alloc]init];
    }
    
    return _MVGoodsImageView;
}
-(UILabel *)MVBottonLine
{
    if (_MVBottonLine == nil)
    {
        _MVBottonLine = [[UILabel alloc]init];
        
        _MVBottonLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _MVBottonLine;
}
-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel = [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _MVNameLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVNameLabel;
}

-(UILabel *)MVMoneyCountLabel
{
    if (_MVMoneyCountLabel == nil)
    {
        _MVMoneyCountLabel = [[UILabel alloc]init];
        _MVMoneyCountLabel.font = [UIFont systemFontOfSize:20.0f];
        _MVMoneyCountLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        _MVMoneyCountLabel.adjustsFontSizeToFitWidth = YES;
        //        _MVMoneyCountLabel.backgroundColor = [UIColor redColor];
    }
    return _MVMoneyCountLabel;
}
-(UILabel *)MVUnitLabel
{
    if (_MVUnitLabel == nil)
    {
        _MVUnitLabel = [[UILabel alloc]init];
        _MVUnitLabel.font = [UIFont systemFontOfSize:15.0f];
        _MVUnitLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        
        
    }
    return _MVUnitLabel;
}
-(UILabel *)MVBuyCountLabel
{
    if (_MVBuyCountLabel == nil)
    {
        _MVBuyCountLabel = [[UILabel alloc]init];
        _MVBuyCountLabel.font = [UIFont systemFontOfSize:14.0f];
        _MVBuyCountLabel.textColor = [UIColor colorWithHexString:@"#323232"];
        _MVBuyCountLabel.textAlignment = NSTextAlignmentCenter;
       
        _MVBuyCountLabel.adjustsFontSizeToFitWidth = YES;
        _MVBuyCountLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _MVBuyCountLabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVGoodsImageView .frame =  CGRectMake(10, 12, 92, 92);

    _MVNameLabel.frame =CGRectMake(_MVGoodsImageView.v_right +17, 12, _MVNameLabel.v_width,_MVNameLabel.v_height);
    float mwith = _MVMoneyCountLabel.v_width;
    _MVUnitLabel.frame =  CGRectMake(_MVGoodsImageView.v_right+17 , self.v_height-14.5-_MVUnitLabel.v_height, _MVUnitLabel.v_width, _MVUnitLabel.v_height);

    _MVMoneyCountLabel.frame =  CGRectMake(_MVUnitLabel.v_right, self.v_height-14.5-_MVMoneyCountLabel.v_height+2, mwith, _MVMoneyCountLabel.v_height);
    _MVBuyCountLabel.frame =  CGRectMake(ScreenWidth-_MVBuyCountLabel.v_width-10, self.v_height-14.5-20, _MVBuyCountLabel.v_width, 21);
    

        _MVBottonLine.frame = CGRectMake(10, self.v_height - 0.5,ScreenWidth-20, 0.5);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
