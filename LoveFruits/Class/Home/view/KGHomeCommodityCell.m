//
//  KGHomeCommodityCell.m
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCommodityCell.h"
#import "KGHomeCommodityCellModel.h"
#import "UIImageView+WebCache.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
@interface KGBaseTableViewCell()
@property (nonatomic,retain)UIImageView * MVImageView;
@property (nonatomic,retain)UILabel     * MVNameLabel;
@property (nonatomic,retain)UILabel     * MVSellCountLabel;
@property (nonatomic,retain)UILabel     * MVMoneyTypeLabel;
@property (nonatomic,retain)UILabel     * MVSriceLabel;
@property (nonatomic,retain)UILabel     * MVSriceUnitLabel;
@property (nonatomic,retain)UILabel     * MVLine;
@property (nonatomic,retain)UIButton    * MVBuyButton;
@end

@implementation KGHomeCommodityCell
@synthesize MVImageView       = _MVImageView;
@synthesize MVNameLabel       = _MVNameLabel;
@synthesize MVSellCountLabel  = _MVSellCountLabel;
@synthesize MVSriceLabel      = _MVSriceLabel;
@synthesize MVMoneyTypeLabel  = _MVMoneyTypeLabel;
@synthesize MVSriceUnitLabel  = _MVSriceUnitLabel;
@synthesize MVBuyButton       = _MVBuyButton;
@synthesize MVLine            = _MVLine;
@synthesize KModel            = _KModel;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.MVImageView];
        [self.contentView addSubview:self.MVLine];
        [self.contentView addSubview:self.MVNameLabel];
        [self.contentView addSubview:self.MVBuyButton];
        [self.contentView addSubview:self.MVSellCountLabel];
        [self.contentView addSubview:self.MVMoneyTypeLabel];
        [self.contentView addSubview:self.MVSellCountLabel];
        [self.contentView addSubview:self.MVSriceUnitLabel];
        [self.contentView addSubview:self.MVSriceLabel];
    }
    return self;
}


-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    if ([model isKindOfClass:[KGHomeCommodityCellModel class]])
    {
        _KModel = model;
        self.MVNameLabel.text          =   _KModel.name;
        [self.MVNameLabel sizeToFit];
        
        self.MVSellCountLabel.text     =   [NSString stringWithFormat:@"已售%@件",_KModel.KDSellCount];
        [self.MVSellCountLabel sizeToFit];
        
        self.MVMoneyTypeLabel.text     =   @"￥";
        [self.MVMoneyTypeLabel sizeToFit];
        
//        self.MVSellCountLabel.text     = @"仅剩10000";
//        [self.MVSellCountLabel sizeToFit];
        
        self.MVSriceLabel.text         = [NSString stringWithFormat:@"%@",_KModel.price];;
        [self.MVSriceLabel sizeToFit];
        
        self.MVSriceUnitLabel.text     = [NSString stringWithFormat:@"/%@",_KModel.spec];
        [self.MVSriceUnitLabel sizeToFit];
        
        [_MVImageView sd_setImageWithURL:[NSURL URLWithString:_KModel.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_one"]];
    }
   
    
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVImageView.frame = CGRectMake(11, 12, 92, self.v_height-24);
    _MVNameLabel.frame      = CGRectMake(_MVImageView.v_right+17, 12, _MVNameLabel.v_width, _MVNameLabel.v_height);
    
    _MVSellCountLabel.frame = CGRectMake(_MVImageView.v_right+17, _MVNameLabel.v_bottom+8, _MVSellCountLabel.v_width,_MVSellCountLabel.v_height);
    
    _MVMoneyTypeLabel.frame = CGRectMake(_MVImageView.v_right+17, self.v_height-12-_MVMoneyTypeLabel.v_height, _MVMoneyTypeLabel.v_width,_MVMoneyTypeLabel.v_height);
    
    _MVSriceLabel.frame = CGRectMake(_MVMoneyTypeLabel.v_right+2, self.v_height-12-_MVSriceLabel.v_height, _MVSriceLabel.v_width,_MVSriceLabel.v_height);
    
    _MVSriceUnitLabel.frame = CGRectMake(_MVSriceLabel.v_right+1, self.v_height-12-_MVSriceUnitLabel.v_height, _MVSriceUnitLabel.v_width,_MVSriceUnitLabel.v_height);
    
    _MVLine.frame           = CGRectMake(0, self.v_height-0.5, ScreenWidth, 0.5);
    
    _MVBuyButton.frame           = CGRectMake(ScreenWidth-11-45, self.v_height-12-27, 45, 27);
    _MVSriceLabel.center = CGPointMake(_MVSriceLabel.v_x+_MVSriceLabel.v_width/2, _MVMoneyTypeLabel.center.y);
    
}
-(void)buyCallBack:(UIButton *)button
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickBuy:)])
    {
//        _MVBuyButton.backgroundColor =[UIColor colorWithHexString:@"#ffae02"];
//       
//        [_MVBuyButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self.KVDelegate pClickBuy:self];
    }
}
-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
//        _MVImageView.backgroundColor= [UIColor redColor];
        
        
    }
    return _MVImageView;
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

-(UILabel *)MVSellCountLabel
{
    if (_MVSellCountLabel == nil)
    {
        _MVSellCountLabel = [[UILabel alloc]init];
        _MVSellCountLabel.font = [UIFont systemFontOfSize:12.0f];
        _MVSellCountLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        
    }
    return _MVSellCountLabel;
}
-(UILabel *)MVSriceLabel
{
    if (_MVSriceLabel == nil)
    {
        _MVSriceLabel                = [[UILabel alloc]init];
        _MVSriceLabel.font           = [UIFont systemFontOfSize:20.0f];
        _MVSriceLabel.textColor      = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVSriceLabel;
}
-(UILabel *)MVMoneyTypeLabel
{
    if (_MVMoneyTypeLabel == nil)
    {
        _MVMoneyTypeLabel            = [[UILabel alloc]init];
        _MVMoneyTypeLabel.font       = [UIFont systemFontOfSize:15.0f];
        _MVMoneyTypeLabel.textColor  = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVMoneyTypeLabel;
}
-(UILabel *)MVSriceUnitLabel
{
    if (_MVSriceUnitLabel == nil)
    {
        _MVSriceUnitLabel            = [[UILabel alloc]init];
        _MVSriceUnitLabel.font       = [UIFont systemFontOfSize:15.0f];
        _MVSriceUnitLabel.textColor  = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVSriceUnitLabel;
}
-(UILabel *)MVLine
{
    if (_MVLine == nil)
    {
        _MVLine                      = [[UILabel alloc]init];
       
        _MVLine.backgroundColor      = [UIColor colorWithHexString:@"#d8d8d8"];
        
        
    }
    return _MVLine;
}
-(UIButton *)MVBuyButton
{
    if (_MVBuyButton == nil)
    {
        _MVBuyButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [_MVBuyButton setTitle:@"购买" forState:UIControlStateNormal];
        _MVBuyButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_MVBuyButton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
      
        _MVBuyButton.layer.masksToBounds = YES;
        _MVBuyButton.layer.borderWidth   = 0.5f;
        _MVBuyButton.layer.borderColor   = CommonlyUsedBtnColor.CGColor;
        _MVBuyButton.layer.cornerRadius  = 5.0f;
        [_MVBuyButton addTarget:self action:@selector(buyCallBack:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVBuyButton;
}
@end
