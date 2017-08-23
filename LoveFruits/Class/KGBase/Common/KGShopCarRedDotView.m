//
//  KGShopCarRedDotView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShopCarRedDotView.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
static KGShopCarRedDotView * instance = nil;
@interface KGShopCarRedDotView()
@property (nonatomic,retain)UILabel        *   MNumberLabel;
@property (nonatomic,retain)UIImageView    *   MRedImageView;
@end
@implementation KGShopCarRedDotView
+(KGShopCarRedDotView *)sharedRedDotView
{
    
    
    if (instance == nil)
    {
        instance = [[self alloc]init];
    }
    return instance;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 20)])
    {
        [self addSubview:self.MRedImageView];
        [self addSubview:self.MNumberLabel];
        self.hidden = true;
    }
    return self;
}
-(UILabel *)MNumberLabel
{
    if (_MNumberLabel == nil)
    {
        _MNumberLabel               =   [[UILabel alloc]init];
        _MNumberLabel.font          =   [UIFont systemFontOfSize:10];
        _MNumberLabel.textColor     =   [UIColor whiteColor];
        _MNumberLabel.textAlignment =   NSTextAlignmentCenter;
    
    }
    return _MNumberLabel;
}

-(UIImageView *)MRedImageView
{
    if (_MRedImageView == nil)
    {
        _MRedImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reddot"]];
    }
    return _MRedImageView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.MRedImageView.frame = self.bounds;
    self.MNumberLabel.frame  = CGRectMake(0, 0, self.v_width, self.v_height);
  
}
-(void)setKGBuyNumber:(NSInteger)KGBuyNumber
{
    if (KGBuyNumber<0) {
        return;
    }
    _KGBuyNumber = KGBuyNumber;
    if (_KGBuyNumber== 0)
    {
        self.MNumberLabel.text = @"";
        self.hidden = true;
    }
    else
    {
        if (_KGBuyNumber>99)
        {
            _MNumberLabel.font = [UIFont systemFontOfSize:8];
        }
        else
        {
            _MNumberLabel.font = [UIFont systemFontOfSize:10];
        }
        self.hidden = false;
        self.MNumberLabel.text = [NSString stringWithFormat:@"%ld",_KGBuyNumber];
    }
}
-(void)reddotAnimation
{
    [UIView animateWithDuration:ShopCarRedDotAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ShopCarRedDotAnimationDuration animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}
-(void)addProductToRedDotView:(BOOL)animation
{
    self.KGBuyNumber ++;
   
    if (animation)
    {
        [self reddotAnimation];
    }
}
-(void)operationProductToRedDotView:(NSInteger )count
{
    self.KGBuyNumber = count;
    [self reddotAnimation];
}
-(void)reduceProductToRedDotView:(BOOL)animation
{
    if (_KGBuyNumber>0)
    {
        self.KGBuyNumber --;
    }
    
    if (animation)
    {
        [self reddotAnimation];
    }
}
@end
