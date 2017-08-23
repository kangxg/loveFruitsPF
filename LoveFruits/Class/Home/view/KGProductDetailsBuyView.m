//
//  KGProductDetailsBuyView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsBuyView.h"
#import "KGProductDetailsModel.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "GlobelDefine.h"
@interface KGProductDetailsBuyView()
@property (nonatomic,retain)UILabel       * MVTopLine;
@property (nonatomic,retain)UILabel       * MVBottonLine;
@property (nonatomic,retain)UILabel       * MVPriceLabel;
@property (nonatomic,retain)UILabel       * MVSpecLabel;
@property (nonatomic,retain)UIButton      * MVBuyButton;
@end


@implementation KGProductDetailsBuyView
@synthesize  MVPriceLabel = _MVPriceLabel;
@synthesize  MVSpecLabel  = _MVSpecLabel;
@synthesize  MVBuyButton  = _MVBuyButton;
@synthesize  MVTopLine    = _MVTopLine;
@synthesize  MVBottonLine = _MVBottonLine;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self addSubview:self.MVPriceLabel];
     
        [self addSubview:self.MVSpecLabel];
        [self addSubview:self.MVBuyButton];
        
        [self addSubview:self.MVTopLine];
        [self addSubview:self.MVBottonLine];
     
    }
    return self;
}
-(void)updateView:(KGProductDetailsModel *)model
{
    if (model)
    {
        _MVPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        //@"2.5元";
        _MVSpecLabel.text = [NSString stringWithFormat:@"/%@",model.spec];
        [_MVPriceLabel sizeToFit];
        [_MVSpecLabel sizeToFit];
    }
    
   
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

-(UILabel *)MVBottonLine
{
    if (_MVBottonLine == nil)
    {
        _MVBottonLine = [[UILabel alloc]init];
        _MVBottonLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        
    }
    return _MVBottonLine;
}
-(UILabel *)MVPriceLabel
{
    if (_MVPriceLabel == nil)
    {
        _MVPriceLabel = [[UILabel alloc]init];
        _MVPriceLabel.font = [UIFont systemFontOfSize:20.0f];
        _MVPriceLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        
    }
    return _MVPriceLabel;
}

-(UILabel *)MVSpecLabel
{
    if (_MVSpecLabel == nil)
    {
        _MVSpecLabel = [[UILabel alloc]init];
        _MVSpecLabel.font = [UIFont systemFontOfSize:15.0f];
        _MVSpecLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];;
    }
    return _MVSpecLabel;
}

-(UIButton *)MVBuyButton
{
    if (_MVBuyButton == nil)
    {
        _MVBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVBuyButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
          [_MVBuyButton setImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateHighlighted];
        [_MVBuyButton addTarget:self action:@selector(buyCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _MVBuyButton;
}

-(void)buyCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pAddOperation:)])
    {
        [self.KVDelegate pAddOperation:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //(self.v_height-_MVPriceLabel.v_height)/2
    _MVPriceLabel.frame =CGRectMake(11,0.5, _MVPriceLabel.v_width, self.v_height-1);
    _MVSpecLabel.frame  =CGRectMake(_MVPriceLabel.v_right,0.5 , _MVSpecLabel.v_width, self.v_height-1);
    
    _MVBuyButton.frame =CGRectMake(self.v_width-self.v_height,0.5 , self.v_height-10, self.v_height-1);
    
    _MVTopLine.frame= CGRectMake(0,0 , self.v_width, 0.5);
     _MVBottonLine.frame= CGRectMake(0,self.v_height-0.5 , self.v_width, 0.5);
}
@end
