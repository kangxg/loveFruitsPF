//
//  KGBuyView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBuyView.h"
#import "KGHomeFreshHot.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
#import "KGShopCarRedDotView.h"
#import "KGUserShopCarTool.h"
#import "KGGoodsModel.h"
@interface KGBuyView()
{
    BOOL _mZearIsShow;
}
@property (nonatomic,retain)UIButton * MAddGoodsButton;
@property (nonatomic,retain)UIButton * MReduceGoodsButton;
@property (nonatomic,retain)UILabel  * MBuyCountLabel;
@property (nonatomic,retain)UILabel  * MSupplementLabel;
@property (nonatomic,assign)NSInteger  MBuyNumber;

@end

@implementation KGBuyView
/**
 *  Description  添加按钮
 *
 *  @return UIButton
 */
-(UIButton *)MAddGoodsButton
{
    if (_MAddGoodsButton == nil)
    {
        _MAddGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MAddGoodsButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_MAddGoodsButton setImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateHighlighted];
        [_MAddGoodsButton addTarget:self action:@selector(addGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _MAddGoodsButton;
}

/**
 *  Description  删除按钮
 *
 *  @return UIButton
 */
-(UIButton * )MReduceGoodsButton
{
    if (_MReduceGoodsButton == nil)
    {
        _MReduceGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MReduceGoodsButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
        [_MReduceGoodsButton addTarget:self action:@selector(reduceGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _MReduceGoodsButton.hidden = false;
    }
    
    return _MReduceGoodsButton;
}

/**
 *  Description  购买数量
 *
 *  @return UILabel
 */
-(UILabel *)MBuyCountLabel
{
    if (_MBuyCountLabel == nil)
    {
        _MBuyCountLabel               =  [[UILabel alloc]init];
        _MBuyCountLabel.hidden        =  false;
        _MBuyCountLabel.text          =  @"0";
        _MBuyCountLabel.textColor     =  [UIColor blackColor];
        _MBuyCountLabel.textAlignment =   NSTextAlignmentCenter;
        _MBuyCountLabel.font          =  HomeCollectionTextFont;
    }
    
    return _MBuyCountLabel;
}
/**
 *  Description  补货中
 *
 *  @return UILabel
 */
-(UILabel *)MSupplementLabel
{
    if (_MSupplementLabel == nil)
    {
        _MSupplementLabel               =  [[UILabel alloc]init];
        _MSupplementLabel.hidden        =  YES;
        _MSupplementLabel.text          =  @"补货中";
        _MSupplementLabel.textColor     =  [UIColor redColor];
        _MSupplementLabel.textAlignment =   NSTextAlignmentRight;
        _MSupplementLabel.font          =  HomeCollectionTextFont;

    }
    
    return _MSupplementLabel;
}

-(void)setMBuyNumber:(NSInteger)MBuyNumber
{
    if (MBuyNumber>0)
    {
        self.MReduceGoodsButton.hidden = false;
        self.MBuyCountLabel.text       = [NSString stringWithFormat:@"%ld",MBuyNumber];
        _MBuyNumber = MBuyNumber;
    }
    else
    {
        self.MReduceGoodsButton.hidden = true;
        self.MBuyCountLabel.hidden     = false;
        self.MBuyCountLabel.text       = [NSString stringWithFormat:@"%ld",MBuyNumber];
        _MBuyNumber = MBuyNumber;
    }
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.MAddGoodsButton];
//        [self addSubview:self.MReduceGoodsButton];
//        [self addSubview:self.MBuyCountLabel];
//        [self addSubview:self.MSupplementLabel];
    }
    return self;
}

-(void)layoutSubviews
{
//    CGFloat buyCountWidth = 25;
    self.MAddGoodsButton.frame = CGRectMake(0, 0, self.v_height, self.v_height);
//    self.MBuyCountLabel.frame  = CGRectMake(CGRectGetMinX(_MAddGoodsButton.frame) - buyCountWidth, 0, buyCountWidth, self.v_height);
//    self.MReduceGoodsButton.frame = CGRectMake(CGRectGetMinX(_MBuyCountLabel.frame) - self.v_height, 0, self.v_height, self.v_height);
//    self.MSupplementLabel.frame = CGRectMake(CGRectGetMinX(_MReduceGoodsButton.frame), 0, self.v_height + buyCountWidth + self.v_height, self.v_height);
}
-(void)setKGGood:(KGGoodsModel *)KGGood
{
    if (KGGood)
    {
//        self.MBuyNumber = [KGGood.userBuyNumber integerValue];
        _KGGood = KGGood;
//        if (KGGood.number.integerValue <= 0)
//        {
//            [self showSupplementLabel];
//        }
//        else
//        {
//            [self hideSupplementLabel];
//        }
//        
//        if (self.MBuyNumber  == 0)
//        {
//           self.MBuyCountLabel.hidden = self.MReduceGoodsButton.hidden = (true && !_mZearIsShow);
//            
//        }
//        else
//        {
//            self.MReduceGoodsButton.hidden = self.MBuyCountLabel.hidden  = false;
//        }
    }
}

-(void)showSupplementLabel
{
    self.MSupplementLabel.hidden    =  false;
  
    self.MAddGoodsButton.hidden     =  true;
    self.MReduceGoodsButton.hidden  =  true;
    self.MBuyCountLabel.hidden      =  true;
}


-(void)hideSupplementLabel
{
    self.MSupplementLabel.hidden    = true;
    self.MAddGoodsButton.hidden     = false;
    self.MReduceGoodsButton.hidden  = false;
    self.MBuyCountLabel.hidden      = false;
}

/**
 *  Description  添加按钮 回调
 */
-(void)addGoodsButtonClick
{
//    if (self.MBuyNumber>= self.KGGood.number.integerValue)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:HomeGoodsInventoryProblem  object:self.KGGood.name userInfo:nil];
//        return;
//    }
    
//    self.MReduceGoodsButton.hidden = false;
//    self.MBuyNumber ++;
//    self.KGGood.userBuyNumber  = [NSNumber numberWithInteger:self.MBuyNumber];
//    self.MBuyCountLabel .text  = [NSString stringWithFormat:@"%ld",_MBuyNumber];
//    self.MBuyCountLabel.hidden = false;
//    NSInteger buyNum = [self.KGGood userBuyNumber].integerValue;
//    buyNum++;
//    [self.KGGood setUserBuyNumber:[NSNumber numberWithInteger:buyNum]];
    if (self.KGClickAddShopCar)
    {
        self.KGClickAddShopCar();
    }
    
    [[KGShopCarRedDotView sharedRedDotView] addProductToRedDotView:true];
    [[KGUserShopCarTool sharedUserShopCar] addSupermarkProductToShopCar:(id)self.KGGood];
    [[NSNotificationCenter defaultCenter]postNotificationName:LFBShopCarBuyPriceDidChangeNotification object:nil];
}

/**
 *  Description  删除按钮 回调
 */
-(void)reduceGoodsButtonClick
{
    if (_MBuyNumber<= 0)
    {
        return;
    }
    self.MBuyNumber --;
    
    self.KGGood.userBuyNumber = [NSNumber numberWithInteger:_MBuyNumber];
    if (_MBuyNumber == 0)
    {
        self.MReduceGoodsButton.hidden = self.MBuyCountLabel.hidden =(true && !_mZearIsShow);
        self.MBuyCountLabel.text = _mZearIsShow?@"0":@"";
        [[KGUserShopCarTool sharedUserShopCar] removeSupermarketProduct:self.KGGood]
        ;
    }
    else
    {
        self.MBuyCountLabel.text = [NSString stringWithFormat:@"%ld",_MBuyNumber];
     
    }
    
    [[KGShopCarRedDotView sharedRedDotView] reduceProductToRedDotView:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:LFBShopCarBuyPriceDidChangeNotification object:nil];
}
@end
