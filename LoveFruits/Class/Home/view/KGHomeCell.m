//
//  KGHomeCell.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCell.h"
#import "KGDiscountPriceView.h"
#import "KGBuyView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "KGHomeHeadResources.h"
#import "KGHomeFreshHot.h"
#import "UIView+Extension.h"
#import "KGHomeGoodsAdsModel.h"
#import "KGGoodsAdsModel.h"
#import "UIButton+WebCache.h"
#import "InlineFunc.h"
typedef NS_ENUM(NSInteger, HomeCellType)
{
    Horizontal = 0,
    Vertical
};

@implementation KGHomeCell
@dynamic KGActivty;
@dynamic KGGood;
@synthesize KVDelegate = _KVDelegate;
-(void)setGoods:(KGGoodsAdsModel *)goods withType:(KGGoodsAdsType)type
{
    
}
@end

@interface KGHomeOherCell ()
@property (nonatomic,assign)HomeCellType   Mtype;
@property (nonatomic,retain)UIImageView  * MBackImageView;
@property (nonatomic,retain)UIImageView  * MGoodsImageView;
@property (nonatomic,retain)UILabel      * MNameLabel;
@property (nonatomic,retain)UIImageView  * MFineImageView;
@property (nonatomic,retain)UIImageView  * MGiveImageView;
@property (nonatomic,retain)UILabel      * MSpecificsLabel;

@property (nonatomic,retain)KGDiscountPriceView * MDiscountPriceView;




@end

@implementation KGHomeOherCell
@synthesize KGActivty  = _KGActivty;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.MBackImageView];
        [self addSubview:self.MGoodsImageView];
        [self addSubview:self.MNameLabel];
        [self addSubview:self.MSpecificsLabel];

        
       
        
     

        
    }
    return self;
}


-(void)setKGActivty:(KGHomeGoodsAdsModel *)KGActivty
{
    if (KGActivty)
    {
        self.Mtype = Horizontal;
       // self.MBackImageView.image =[UIImage imageNamed:@"v2_placeholder_full_size"];
        [self.MBackImageView sd_setImageWithURL:[NSURL URLWithString:KGActivty.imgUrl] placeholderImage:[UIImage imageNamed:@"v2_placeholder_one"]];
        
    }
}
-(void)setGoods:(KGGoodsAdsModel *)goods withType:(KGGoodsAdsType)type
{
    if (goods)
    {
        //@"v2_placeholder_square"
        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
//        self.MBackImageView.hidden = YES;
//        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_test_%@",goods.pid]]];
        self.MNameLabel.text = goods.name;
        [self.MNameLabel sizeToFit];
        if (type ==KGGOODSADSTYPEFOURCH)
        {
            self.MSpecificsLabel.text =[NSString stringWithFormat:@"%@元",goods.price];
          
            
        }
        else
        {
            _MNameLabel.textAlignment = NSTextAlignmentCenter;
            _MSpecificsLabel.hidden = YES;
        }
//        [_MSpecificsLabel sizeToFit];
    }
}
-(void)setKGGood:(KGGoodsAdsModel *)KGGood
{
    if (KGGood)
    {
        self.Mtype = Vertical;
        [self.MGoodsImageView sd_setImageWithURL:[NSURL URLWithString:KGGood.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
        self.MNameLabel.text = KGGood.name;
   
//        if (_MDiscountPriceView)
//        {
//            [_MDiscountPriceView removeFromSuperview];
//        }
        
//        _MDiscountPriceView = [[KGDiscountPriceView alloc]initWithPriceView:KGGood.price markPrice:KGGood.market_price];
////        _MDiscountPriceView.backgroundColor = [UIColor redColor];
////        self.MBuyView.backgroundColor = [UIColor greenColor];
//        [self addSubview:_MDiscountPriceView];
//        self.MSpecificsLabel.text = KGGood.specifics;
//        self.MBuyView.KGGood = KGGood;
    }
}

-(UIImageView *)MBackImageView
{
    if (_MBackImageView == nil)
    {
        _MBackImageView = [[UIImageView alloc]init];
        
    }
    return _MBackImageView;
}

-(UIImageView *)MGoodsImageView
{
    if (_MGoodsImageView == nil)
    {
        _MGoodsImageView = [[UIImageView alloc]init];
        _MGoodsImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _MGoodsImageView;
}


-(UILabel *)MNameLabel
{
    if (_MNameLabel == nil)
    {
        _MNameLabel = [[UILabel alloc]init];
        _MNameLabel.textAlignment = NSTextAlignmentLeft;
        _MNameLabel.font          = HomeCollectionTextFont;
        _MNameLabel.textColor     = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    
    return _MNameLabel;
}



-(UILabel *)MSpecificsLabel
{
    if (_MSpecificsLabel == nil)
    {
        _MSpecificsLabel = [[UILabel alloc]init];
        _MSpecificsLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
        _MSpecificsLabel.font = [UIFont systemFontOfSize:11];
        _MSpecificsLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _MSpecificsLabel;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    _MBackImageView.frame   = self.bounds;
   
    _MGoodsImageView.frame  = CGRectMake(10, 10, self.v_width-20,self.v_width-32);
    _MNameLabel.frame       = CGRectMake(10, self.v_width-10, self.v_width -20, 20);

    _MSpecificsLabel.frame  =  CGRectMake(self.MNameLabel.v_x, CGRectGetMaxY(self.MNameLabel.frame), _MNameLabel.v_width, 20);

   

    
}
@end

@interface KGHomeSecondCell()
@property (nonatomic,retain)UIImageView     * MVLeftButton;
@property (nonatomic,retain)UIImageView     * MVRightTopButton;
@property (nonatomic,retain)UIImageView     * MVRigthDownButton;
@property (nonatomic,copy)  NSString     * MDLeftUrl;
@property (nonatomic,copy)  NSString     * MDRightTopUrl;
@property (nonatomic,copy)  NSString     * MDRightDownUrl;
@end
@implementation KGHomeSecondCell
@synthesize KGActivty = _KGActivty;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = LFBNavigationHomeSearchColor;
        [self addSubview:self.MVLeftButton];
        [self addSubview:self.MVRightTopButton];
        [self addSubview:self.MVRigthDownButton];
        //        [self addSubview:self.MFineImageView];
        //        [self addSubview:self.MGiveImageView];
        //  [self addSubview:self.MSpecificsLabel];
        //        self.MSpecificsLabel.backgroundColor= [UIColor redColor];
        //        [self addSubview:self.MBuyView];
        
        
        
        
        
        
    }
    return self;
}
-(void)leftBtnCallback
{
    [self eventClick:_KGActivty.detailUrlLeft withTitle:_KGActivty.cpNameLeft];
}
-(void)rightTopBtnCallback
{
    [self eventClick:_KGActivty.detailUrlUp withTitle:_KGActivty.cpNameUp];
}

-(void)rightDownBtnCallback
{
    [self eventClick:_KGActivty.detailUrlDown withTitle:_KGActivty.cpNameDown];
}

-(void)eventClick:(NSString *)string withTitle:(NSString *)title
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pGotoActivty:withTitle:)])
    {
        [self.KVDelegate pGotoActivty:string withTitle:title];
    }
}

-(UIImageView *)MVLeftButton
{
    if (_MVLeftButton == nil)
    {
        _MVLeftButton = [[UIImageView alloc]init];
        _MVLeftButton.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftBtnCallback)];
        [_MVLeftButton addGestureRecognizer:tap];

      
    }
    return _MVLeftButton;
}
-(UIImageView *)MVRigthDownButton
{
    if (_MVRigthDownButton == nil)
    {
        _MVRigthDownButton = [[UIImageView alloc]init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightDownBtnCallback)];
        [_MVRigthDownButton addGestureRecognizer:tap];
        _MVRigthDownButton.userInteractionEnabled = YES;

    }
    return _MVRigthDownButton;
}

-(UIImageView *)MVRightTopButton
{
    if (_MVRightTopButton == nil)
    {
        _MVRightTopButton = [[UIImageView alloc]init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTopBtnCallback)];
        [_MVRightTopButton addGestureRecognizer:tap];
        _MVRightTopButton.userInteractionEnabled = YES;

    }
    return _MVRightTopButton;
}
-(void)setKGActivty:(KGHomeGoodsAdsModel *)KGActivty
{
    if (KGActivty)
    {
        _KGActivty  = KGActivty;
//        UIImage * image = [UIImage imageNamed:@"home_test_0"];
        [_MVLeftButton sd_setImageWithURL:[NSURL URLWithString:_KGActivty.imgUrlLeft] placeholderImage:[UIImage imageNamed:@"v2_placeholder_left"]];
        [_MVRightTopButton sd_setImageWithURL:[NSURL URLWithString:_KGActivty.imgUrlUp] placeholderImage:[UIImage imageNamed:@"v2_placeholder_half_size"]];
        [_MVRigthDownButton sd_setImageWithURL:[NSURL URLWithString:_KGActivty.imgUrlDown] placeholderImage:[UIImage imageNamed:@"v2_placeholder_half_size"]];
        
        

    
        
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVLeftButton.frame = CGRectMake(0, 0, self.v_width*0.4, self.v_height);
    _MVRightTopButton.frame = CGRectMake(self.v_width*0.4+1, 0, self.v_width*0.6-1, self.v_height/2-0.5);
     _MVRigthDownButton.frame = CGRectMake(self.v_width *0.4+1, self.v_height/2+1, self.v_width*0.6-1, self.v_height/2-0.5);

}
@end
