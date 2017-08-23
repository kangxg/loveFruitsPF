//
//  KGShopCartCell.m
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShopCartCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
@interface KGShopCartCell()
@property (nonatomic,retain)UILabel       * MVNameLabel;
@property (nonatomic,retain)UILabel       * MVUnitLabel;
@property (nonatomic,retain)UILabel       * MVBuyCountLabel;
@property (nonatomic,retain)UILabel       * MVMoneyCountLabel;
@property (nonatomic,retain)UILabel       * MVBottonLine;

@property (nonatomic,retain)UIButton      * MVAddButton;
@property (nonatomic,retain)UIButton      * MVSubButton;
@property (nonatomic,retain)UIButton      * MVSelectButton;

@property (nonatomic,retain)UIImageView   * MVGoodsImageView;

@property (nonatomic,assign)CGSize          MVSize;
@end

@implementation KGShopCartCell
@synthesize KVDelegate          = _KVDelegate;
@synthesize MVSize              = _MVSize;
@synthesize MVGoodsImageView    = _MVGoodsImageView;
@synthesize MVSelectButton      = _MVSelectButton;
@synthesize MVSubButton         = _MVSubButton;
@synthesize MVAddButton         = _MVAddButton;
@synthesize MVBottonLine        = _MVBottonLine;

@synthesize MVMoneyCountLabel   = _MVMoneyCountLabel;
@synthesize MVUnitLabel         = _MVUnitLabel;
@synthesize MVNameLabel         = _MVNameLabel;
@synthesize MVBuyCountLabel     = _MVBuyCountLabel;
@synthesize KVModel             = _KVModel;

+(instancetype)cellWithTableview:(UITableView*)tableview cellSize:(CGSize)cellSize
{
    static NSString * str=@"shopCartcell";
    KGShopCartCell *  cell= [[KGShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str cellSize:cellSize];
    return cell;

    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _MVSize = cellSize;
        [self addSubview:self.MVSelectButton];
        [self addSubview:self.MVGoodsImageView];
        
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.MVBuyCountLabel];
        [self addSubview:self.MVAddButton];
        [self addSubview:self.MVSubButton];
        
        [self addSubview:self.MVUnitLabel];
        [self addSubview:self.MVMoneyCountLabel];
        [self addSubview:self.MVBottonLine];
//        [self addSubview:self.MVNameLabel];
//        [self addSubview:self.MVNameLabel];
        
        
    }
    
    return self;
    
}

-(void)clickSelected:(UIButton *)button
{
    button.selected = ! button.selected ;
    _KVModel.isSelected = button.selected;
    if (self.KVDelegate &&[self.KVDelegate respondsToSelector:@selector(pSelectedView:)])
    {
        [self.KVDelegate pSelectedView:self];
    }
}
-(void)updateViews:(id<KGGoodsModelInterface>)goods
{
//    if (goods == nil)
//    {
//        return;
//    }
    _KVModel = goods;
    
    [_MVGoodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"today-test"]];
//    [UIImage imageNamed:@"today-test"];
    _MVNameLabel.text = goods.name;
    [_MVNameLabel sizeToFit];
    
    _MVBuyCountLabel.text  =[NSString stringWithFormat:@"%@",goods.userBuyNumber] ;
    [_MVBuyCountLabel sizeToFit];
    
     float count =goods.price.floatValue *goods.userBuyNumber.integerValue;
    _MVMoneyCountLabel.text =[NSString stringWithFormat:@"%.2f",count];
    [_MVMoneyCountLabel sizeToFit];
    
    _MVSelectButton.selected = _KVModel.isSelected;
    _MVUnitLabel.text = @"￥";
    [_MVUnitLabel sizeToFit];
    
}

-(void)clickAdd:(UIButton *)button
{
    NSInteger  count = _KVModel.userBuyNumber.integerValue +1;
    _KVModel.userBuyNumber = @(count);
    self.MVBuyCountLabel.text = [NSString stringWithFormat:@"%@",_KVModel.userBuyNumber];
    [self.MVBuyCountLabel sizeToFit];
    [self resetMoneyView:count];
    if (self.KVDelegate &&[self.KVDelegate respondsToSelector:@selector(pAddGoods:)])
    {
        [self.KVDelegate pAddGoods:self];
    }
}

-(void)clickSub:(UIButton *)button
{
    NSInteger  count = _KVModel.userBuyNumber.integerValue;
    if (count >1)
    {
        count--;
        _KVModel.userBuyNumber = @(count);
        self.MVBuyCountLabel.text = [NSString stringWithFormat:@"%@",_KVModel.userBuyNumber];
         [self.MVBuyCountLabel sizeToFit];
        
        [self resetMoneyView:count];
        
        if (self.KVDelegate &&[self.KVDelegate respondsToSelector:@selector(pSubGoods:)])
        {
            [self.KVDelegate pSubGoods:self];
        }
    }
   
}

-(void)resetMoneyView:(NSInteger )count
{
    CGFloat  price = (CGFloat)_KVModel.price.floatValue;
    NSString * result =[NSString stringWithFormat:@"%.2lf",count * price];
//    NSString  * resultStr  = [result cleanDecimalPointZear];
    self.MVMoneyCountLabel.text = result;
    
    [self.MVMoneyCountLabel sizeToFit];
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
-(UILabel *)MVBottonLine
{
    if (_MVBottonLine == nil)
    {
        _MVBottonLine = [[UILabel alloc]init];
      
        _MVBottonLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _MVBottonLine;
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
        _MVBuyCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVBuyCountLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVBuyCountLabel.textAlignment = NSTextAlignmentCenter;
        _MVBuyCountLabel.layer.masksToBounds = YES;
        _MVBuyCountLabel.layer.borderColor   = [UIColor colorWithHexString:@"#999999"].CGColor;
        _MVBuyCountLabel.layer.borderWidth = 0.5;
        _MVBuyCountLabel.layer.cornerRadius = 3.0;
        _MVBuyCountLabel.adjustsFontSizeToFitWidth = YES;
        _MVBuyCountLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _MVBuyCountLabel;
}

-(UIImageView *)MVGoodsImageView
{
    if (_MVGoodsImageView == nil)
    {
        _MVGoodsImageView = [[UIImageView alloc]init];
    }
    
    return _MVGoodsImageView;
}

-(UIButton *)MVSelectButton
{
    if (_MVSelectButton == nil)
    {
        _MVSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
        [_MVSelectButton setImage:[UIImage imageNamed:@"shopping-press"] forState:UIControlStateSelected];
         [_MVSelectButton addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVSelectButton;
}

-(UIButton *)MVAddButton
{
    if (_MVAddButton == nil)
    {
        _MVAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVAddButton setImage:[UIImage imageNamed:@"add-normal"] forState:UIControlStateNormal];
        [_MVAddButton setImage:[UIImage imageNamed:@"add-press-icon"] forState:UIControlStateHighlighted];
        [_MVAddButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVAddButton;
}

-(UIButton *)MVSubButton
{
    if (_MVSubButton == nil)
    {
        _MVSubButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVSubButton setImage:[UIImage imageNamed:@"minus-normal"] forState:UIControlStateNormal];
        [_MVSubButton setImage:[UIImage imageNamed:@"minus-press"] forState:UIControlStateSelected];
         [_MVSubButton addTarget:self action:@selector(clickSub:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVSubButton;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVSelectButton.frame = CGRectMake(11, (_MVSize.height-22)/2, 22, 22);
    _MVGoodsImageView .frame =  CGRectMake(_MVSelectButton.v_right +15, 12, 92, 92);
    _MVNameLabel.frame =CGRectMake(_MVGoodsImageView.v_right +17, 12, _MVNameLabel.v_width,_MVNameLabel.v_height);
    _MVSubButton.frame = CGRectMake(_MVGoodsImageView.v_right +17, _MVSize.height-14.5-21, 21, 21);
    _MVBuyCountLabel.frame =  CGRectMake(_MVSubButton.v_right +2.5, _MVSize.height-14.5-21, 36, 21);
    _MVAddButton.frame =  CGRectMake(_MVBuyCountLabel.v_right +2.5, _MVSize.height-14.5-21, 21, 21);
    float mwith = _MVMoneyCountLabel.v_width;
    mwith = MIN(mwith, self.v_width-_MVAddButton.v_right -11);
    _MVMoneyCountLabel.frame =  CGRectMake(_MVSize.width-11 -_MVMoneyCountLabel.v_width, _MVSize.height-14.5-_MVMoneyCountLabel.v_height+2, mwith, _MVMoneyCountLabel.v_height);
    
     _MVUnitLabel.frame =  CGRectMake(_MVSize.width-11-_MVMoneyCountLabel.v_width-_MVUnitLabel.v_width , _MVSize.height-14.5-_MVUnitLabel.v_height, _MVUnitLabel.v_width, _MVUnitLabel.v_height);
    _MVBottonLine.frame = CGRectMake(0, _MVSize.height - 0.5, _MVSize.width, 0.5);

}

@end
