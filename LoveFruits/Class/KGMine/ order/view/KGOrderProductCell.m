//
//  KGOrderProductCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderProductCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
#import "UIImageView+WebCache.h"
#import "KGOrderDetailViewModel.h"
@interface KGOrderProductCell()
@property (nonatomic,retain)UIImageView   * MVGoodsImageView;
@property (nonatomic,retain)UILabel       * MVNameLabel;
@property (nonatomic,retain)UILabel       * MVBuyCountLabel;
@property (nonatomic,retain)UILabel       * MVMoneyCountLabel;
@property (nonatomic,retain)UILabel       * MVSpecLabel;
@property (nonatomic,retain)UILabel       * MVBottonLine;
@property (nonatomic,retain)UILabel       * MVUnitLabel;


@end
@implementation KGOrderProductCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.MVGoodsImageView];
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.MVSpecLabel];
        [self addSubview:self.MVUnitLabel];
        [self addSubview:self.MVBuyCountLabel];
        [self addSubview:self.MVMoneyCountLabel];
        [self addSubview:self.MVBottonLine];
    }
    return self;
}
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    KGOrderWaresModel  * goods = model;
    
     [_MVGoodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.wareImg] placeholderImage:[UIImage imageNamed:@"v2_placeholder_one"]];
    
    _MVNameLabel.text = goods.wareName;
    [_MVNameLabel sizeToFit];
    
    _MVSpecLabel.text = goods.wareSpec;
    [_MVSpecLabel sizeToFit];
    
    _MVBuyCountLabel.text  =[NSString stringWithFormat:@"x %@",goods.wareCount] ;
    [_MVBuyCountLabel sizeToFit];
    
    
    _MVMoneyCountLabel.text =[NSString stringWithFormat:@"%.2f",goods.warePrice.floatValue];
    [_MVMoneyCountLabel sizeToFit];
    
    _MVUnitLabel.text = @"共￥";
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
-(UILabel *)MVSpecLabel
{
    if (_MVSpecLabel == nil)
    {
        _MVSpecLabel = [[UILabel alloc]init];
        _MVSpecLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVSpecLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _MVSpecLabel;
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

-(UILabel *)MVBuyCountLabel
{
    if (_MVBuyCountLabel == nil)
    {
        _MVBuyCountLabel = [[UILabel alloc]init];
        _MVBuyCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVBuyCountLabel.textColor = [UIColor colorWithHexString:@"#999999"];
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
    _MVSpecLabel.frame = CGRectMake(_MVGoodsImageView.v_right +17, _MVNameLabel.v_bottom + 16, _MVSpecLabel.v_width,_MVSpecLabel.v_height);

    
    _MVUnitLabel.frame =  CGRectMake(_MVGoodsImageView.v_right+17 , self.v_height-14.5-_MVUnitLabel.v_height, _MVUnitLabel.v_width, _MVUnitLabel.v_height);
    
    float mwith = _MVMoneyCountLabel.v_width;
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
