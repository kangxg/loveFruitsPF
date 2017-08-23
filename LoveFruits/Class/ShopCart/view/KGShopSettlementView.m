//
//  KGShopSettlementView.m
//  LoveFruits
//
//  Created by kangxg on 16/10/2.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShopSettlementView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
@interface KGShopSettlementView()
@property (nonatomic,retain)UIButton     *   MVSelectBtn;
@property (nonatomic,retain)UIButton     *   MVSettlementBtn;
@property (nonatomic,retain)UILabel      *   MVSelectDesLable;
@property (nonatomic,retain)UILabel      *   MVSumLable;

@property (nonatomic,retain)UILabel      *   MVUnitLabel;
@property (nonatomic,retain)UILabel      *   MVMoneyCountLabel;
@property (nonatomic,retain)UILabel      *   MVDesLabel;
@property (nonatomic,retain)UILabel      *   MVTopLine;
@end

@implementation KGShopSettlementView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.MVTopLine];
        [self addSubview:self.MVSelectBtn];
        [self addSubview:self.MVSettlementBtn];
        [self addSubview:self.MVSelectDesLable];
      
        [self addSubview:self.MVSumLable];
        [self addSubview:self.MVUnitLabel];
        [self addSubview:self.MVMoneyCountLabel];
        [self addSubview:self.MVDesLabel];
    }
    return self;
}
-(void)resetViews
{
    _MVSelectBtn.selected = false;
    self.hidden = YES;
}
-(void)clickSelected:(UIButton *)button
{
    button.selected = ! button.selected ;
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pSelectedAll:)])
    {
        [self.KVDelegate pSelectedAll:button.selected];
    }
    
}
-(void)clickSettlement:(UIButton *)button
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickSettlement:)])
    {
        [self.KVDelegate pClickSettlement:self];
    }
}
-(void)setTotalAmount:(NSString *)sum
{
    if (sum)
    {
        
        self.MVMoneyCountLabel.text = sum;
        [self.MVMoneyCountLabel sizeToFit];
    }
}
-(void)setAllSeleted:(BOOL)allSeleted
{
    self.MVSelectBtn.selected = allSeleted;
}
-(void)setState:(KGShopCarEditType)state
{
    switch (state)
    {
        case KGSHOPCARTYPENORMAL:
        {
             [_MVSettlementBtn setTitle:@"结算" forState:UIControlStateNormal];
        }
            break;
        case KGSHOPCARTYPEDELETE:
        {
             [_MVSettlementBtn setTitle:@"删除" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVTopLine.frame = CGRectMake(0, 0, self.v_width, 0.5);
    _MVSelectBtn.frame = CGRectMake(11, (self.v_height-22)/2, 22, 22);
    _MVSelectDesLable.frame =CGRectMake( _MVSelectBtn.v_right +10, (self.v_height-_MVSelectDesLable.v_height)/2, _MVSelectDesLable.v_width,_MVSelectDesLable.v_height);
    _MVSettlementBtn.frame = CGRectMake(self.v_width-self.v_height*1.5, 0, self.v_height*1.5, self.v_height);
    _MVMoneyCountLabel.frame = CGRectMake(_MVSettlementBtn.v_x-10-_MVMoneyCountLabel.v_width, 7, _MVMoneyCountLabel.v_width, _MVMoneyCountLabel.v_height);

    _MVUnitLabel.frame =  CGRectMake(_MVMoneyCountLabel.v_x-_MVUnitLabel.v_width, 7, _MVUnitLabel.v_width, _MVUnitLabel.v_height);
    _MVSumLable.frame =  CGRectMake(_MVUnitLabel.v_x-_MVSumLable.v_width -2, 5.5, _MVSumLable.v_width, _MVSumLable.v_height);
    
    _MVDesLabel.frame =  CGRectMake(_MVSettlementBtn.v_x-10 -_MVDesLabel.v_width, _MVSumLable.v_bottom+7, _MVDesLabel.v_width,_MVDesLabel.v_height);
    
}

-(UIButton *)MVSelectBtn
{
    if (_MVSelectBtn == nil)
    {
        _MVSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVSelectBtn setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
        [_MVSelectBtn setImage:[UIImage imageNamed:@"shopping-press"] forState:UIControlStateSelected];
        [_MVSelectBtn addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVSelectBtn;
}

-(UIButton *)MVSettlementBtn
{
    if (_MVSettlementBtn == nil)
    {
        _MVSettlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVSettlementBtn.backgroundColor  = CommonlyUsedBtnColor;
        [_MVSettlementBtn setTitle:@"结算" forState:UIControlStateNormal];
        _MVSettlementBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];

        [_MVSettlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVSettlementBtn addTarget:self action:@selector(clickSettlement:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVSettlementBtn;
}

-(UILabel *)MVSelectDesLable
{
    if (_MVSelectDesLable == nil)
    {
        _MVSelectDesLable = [[UILabel alloc]init];
        _MVSelectDesLable.font = [UIFont systemFontOfSize:14.0f];
        _MVSelectDesLable.text = @"全选";
        [_MVSelectDesLable sizeToFit];
        _MVSelectDesLable.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVSelectDesLable;
}

-(UILabel *)MVSumLable
{
    if (_MVSumLable == nil)
    {
        _MVSumLable = [[UILabel alloc]init];
        _MVSumLable.font = [UIFont systemFontOfSize:13.0f];
        _MVSumLable.text = @"合计:";
        [_MVSumLable sizeToFit];
        _MVSumLable.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVSumLable;
}
-(UILabel *)MVTopLine
{
    if (_MVTopLine == nil)
    {
        _MVTopLine = [[UILabel alloc]init];
        
        _MVTopLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        
    
    }
    return _MVTopLine;
}
-(UILabel *)MVUnitLabel
{
    if (_MVUnitLabel == nil)
    {
        _MVUnitLabel = [[UILabel alloc]init];
        _MVUnitLabel.font = [UIFont systemFontOfSize:11.0f];
        _MVUnitLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        
        _MVUnitLabel.text = @"￥";
        [_MVUnitLabel sizeToFit];
    }
    return _MVUnitLabel;
}
-(UILabel *)MVMoneyCountLabel
{
    if (_MVMoneyCountLabel == nil)
    {
        _MVMoneyCountLabel = [[UILabel alloc]init];
        _MVMoneyCountLabel.font = [UIFont systemFontOfSize:11.0f];
        _MVMoneyCountLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        _MVMoneyCountLabel.text = @"0";
        [_MVMoneyCountLabel sizeToFit];
        //        _MVMoneyCountLabel.backgroundColor = [UIColor redColor];
    }
    return _MVMoneyCountLabel;
}
-(UILabel *)MVDesLabel
{
    if (_MVDesLabel == nil)
    {
        _MVDesLabel = [[UILabel alloc]init];
        _MVDesLabel.textColor = [UIColor colorWithHexString:@"#9a9a9a"];
        
        _MVDesLabel .font = [UIFont systemFontOfSize:11.0f];
        _MVDesLabel.textAlignment = NSTextAlignmentRight;
        _MVDesLabel.text = @"不含运费";
        [_MVDesLabel sizeToFit];
    }
    return _MVDesLabel;
}
@end
