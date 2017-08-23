//
//  KGProductCell.m
//  LoveFruits
//
//  Created by kangxg on 16/5/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//


#import "KGProductCell.h"
#import "KGBuyView.h"
#import "KGDiscountPriceView.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "UIImageView+WebCache.h"
#import "KGHomeFreshHot.h"
#import "UIView+Extension.h"
#import "KGGoodsModel.h"
#import "KGGoodsPriceView.h"
static NSString * indentifer = @"ProductCell";
@interface KGProductCell()
{
  
}
@property (nonatomic,retain)UIImageView         *  MGoodsImageView;
@property (nonatomic,retain)UIImageView         *  MFineImageView;
@property (nonatomic,retain)UIImageView         *  MGiveImageView;

@property (nonatomic,retain)UILabel             *  MNameLabel;
@property (nonatomic,retain)UILabel             *  MSpecificsLabel;
@property (nonatomic,retain)KGBuyView           *  MBuyView;
@property (nonatomic,retain)UIView              *  MLineView;
//@property (nonatomic,retain)KGDiscountPriceView *  MPriceview;
@property (nonatomic,retain)KGGoodsPriceView    *  MPriceview;

@end
@implementation KGProductCell
@synthesize KMGoodsModel = _KMGoodsModel;
@synthesize MPriceview   = _MPriceview;
-(UIImageView *)MGoodsImageView
{
    if (_MGoodsImageView == nil)
    {
        _MGoodsImageView = [[UIImageView alloc]init];
    }
    return _MGoodsImageView;
}

-(UIImageView *)MFineImageView
{
    if (_MFineImageView == nil)
    {
        _MFineImageView = [[UIImageView alloc]init];
        _MFineImageView.image = [UIImage imageNamed:@"jingxuan.png"];

    }
    return _MFineImageView;
}
-(UIImageView *)MGiveImageView
{
    if (_MGiveImageView == nil)
    {
        _MGiveImageView = [[UIImageView alloc]init];
        _MGiveImageView.image =  [UIImage imageNamed:@"buyOne.png"];
    }
        return _MGiveImageView;
}

-(UILabel *)MNameLabel
{
    if (_MNameLabel == nil)
    {
        _MNameLabel = [[UILabel alloc]init];
        _MNameLabel.textAlignment = NSTextAlignmentLeft;
        _MNameLabel.font = [UIFont systemFontOfSize:11];
        _MNameLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MNameLabel;
}
-(UILabel *)MSpecificsLabel
{
    if (_MSpecificsLabel == nil)
    {
        _MSpecificsLabel = [[UILabel alloc]init];
        _MSpecificsLabel.textColor = [UIColor colorWithHexString:@"#9a9a9a"];

        _MSpecificsLabel .font = [UIFont systemFontOfSize:10.0f];
        _MSpecificsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _MSpecificsLabel;
}
-(KGBuyView *)MBuyView
{
    if (_MBuyView == nil)
    {
        _MBuyView = [[KGBuyView alloc]init];
    }
    return _MBuyView;
}

-(UIView *)MLineView
{
    if (_MLineView == nil)
    {
        _MLineView = [[UIView alloc]init];
        _MLineView.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
//        _MLineView.alpha = 0.05;
    }
    return _MLineView;
}

-(KGGoodsPriceView *)MPriceview
{
    if (_MPriceview == nil)
    {
        _MPriceview = [[KGGoodsPriceView alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
        
    }
    return _MPriceview;
}
//-(KGDiscountPriceView *)MPriceview
//{
//    if (_MPriceview == nil)
//    {
//        
//    }
//    return _MPriceview;
//}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:indentifer])
    {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.MGoodsImageView];
        [self addSubview:self.MLineView];
        [self addSubview:self.MNameLabel];
//        [self addSubview:self.MFineImageView];
//        [self addSubview:self.MGiveImageView];
        [self addSubview:self.MSpecificsLabel];
        [self addSubview:self.MPriceview];
        [self addSubview:self.MBuyView];
        
        __weak  KGProductCell * temSelf = self;
        
        self.MBuyView.KGClickAddShopCar = ^{
            [temSelf backImageView];
        };
        
    }
    
    return self;
}

-(void)backImageView
{
    if (self.KGAddProductClick)
    {
        _KGAddProductClick(self.MGoodsImageView);
        
    }
}

+(KGProductCell *)cellWithTableView:(UITableView *)tableview
{
    KGProductCell * cell = [tableview dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil)
    {
        cell = [[KGProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    return cell;
}
-(void)updateWithNote:(id)data
{
    _KMGoodsModel = data;
    if (_KMGoodsModel)
    {
        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:_KMGoodsModel.img] placeholderImage:[UIImage imageNamed:@"today-test"]];
        self.MNameLabel.text = _KMGoodsModel.name;
        [self.MNameLabel sizeToFit];
        self.MSpecificsLabel.text = @"已售出的件数不明，后台没有提供";
        [self.MSpecificsLabel sizeToFit];
        
        if (_KMGoodsModel.price.length)
        {
            
            [_MPriceview updateViews:_KMGoodsModel];
        }
    }
}
-(void)setKMGoodsModel:(KGGoodsModel *)KMGoodsModel
{
    if (KMGoodsModel)
    {
        _KMGoodsModel = KMGoodsModel;
        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:_KMGoodsModel.img] placeholderImage:[UIImage imageNamed:@"today-test"]];
        self.MNameLabel.text = _KMGoodsModel.name;
        [self.MNameLabel sizeToFit];
//        self.MSpecificsLabel.text = @"已售出的件数不明，后台没有提供";
        [self.MSpecificsLabel sizeToFit];
        self.MBuyView.KGGood = _KMGoodsModel;
        if (KMGoodsModel.price.integerValue>0)
        {
    
            [_MPriceview updateViews:KMGoodsModel];
        }

    }
}
-(void)setKMGoods:(KGGoods *)KMGoods
{
    if (KMGoods)
    {
        _KMGoods = KMGoods;
        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:_KMGoods.img] placeholderImage:[UIImage imageNamed:@"today-test"]];
        self.MNameLabel.text = _KMGoods.name;
        self.MGiveImageView .hidden = ![_KMGoods.pm_desc isEqualToString:@"买一赠一"];
        self.MFineImageView.hidden = !(_KMGoods.is_xf.integerValue ==1);
        if (_MPriceview)
        {
            [_MPriceview removeFromSuperview];
        }
      
//        
//        _MPriceview = [[KGDiscountPriceView alloc]initWithPriceView:_KMGoods.price markPrice:_KMGoods.market_price];
//        [self addSubview:_MPriceview];

        
        self.MSpecificsLabel.text = _KMGoods.specifics;
//        self.MBuyView.KGGood = KMGoods;

    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _MGoodsImageView.frame = CGRectMake(10, 12, self.v_height-28, self.v_height-28);

     _MNameLabel.frame = CGRectMake(CGRectGetMaxX(self.MGoodsImageView.frame) + 13.5, 12, self.v_width - CGRectGetMaxX(self.MFineImageView.frame)-37, _MNameLabel.v_height);

    _MSpecificsLabel.frame = CGRectMake(CGRectGetMaxX(self.MGoodsImageView.frame)+13.5, CGRectGetMaxY(self.MNameLabel.frame)+6, self.v_width-37, _MSpecificsLabel.v_height);

    _MPriceview.frame = CGRectMake(_MSpecificsLabel.v_x, self.v_height-18-12, _MPriceview.MVSize.height,18);
   
  
    self.MLineView.frame = CGRectMake(0, self.v_height - 0.5,self.v_width,0.5);
    self.MBuyView.frame = CGRectMake(self.v_width - 32, self.v_height - 34, 22, 22);
}
@end
