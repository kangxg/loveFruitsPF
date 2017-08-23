//
//  KGShoppingCarView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShoppingCarView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "GlobelDefine.h"
@interface KGShoppingCarView()
{
    NSInteger  _mCount;
}
@property (nonatomic,retain)UIImageView   *  MVImageView;
@property (nonatomic,retain)UILabel       *  MVCountLabel;
@property (nonatomic,retain)UIButton      *  MVButton;
@end

@implementation KGShoppingCarView
@synthesize  MVImageView   = _MVImageView;
@synthesize  MVCountLabel  = _MVCountLabel;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _mCount = 0;
        [self addSubview:self.MVImageView];
        [self addSubview:self.MVCountLabel];
        [self addSubview:self.MVButton];
    }
    return self;
}
-(void)startAnimtion
{
   
    
    _mCount++;
    if (_MVCountLabel) {
        _MVCountLabel.hidden = NO;
    }
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25f;
    _MVCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_mCount];
    [_MVCountLabel.layer addAnimation:animation forKey:nil];
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    shakeAnimation.delegate = self;
    [_MVImageView.layer addAnimation:shakeAnimation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    [super animationDidStop:anim finished:flag];
    CAKeyframeAnimation * bounceAnimation =  [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@(1.0),@(1.2), @(0.9), @(1.15), @(0.95), @(1.02), @(1.0)];
    bounceAnimation.duration = 1.0;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    [self.MVCountLabel.layer addAnimation:bounceAnimation forKey:@"GiftImageViewAnimation"];
}
-(UILabel *)MVCountLabel
{
    if (_MVCountLabel == nil)
    {
        _MVCountLabel           = [[UILabel alloc]init];
        _MVCountLabel.textColor = CommonlyUsedBtnColor;
        _MVCountLabel.textAlignment = NSTextAlignmentCenter;
        _MVCountLabel.font = [UIFont boldSystemFontOfSize:11];
        _MVCountLabel.backgroundColor = [UIColor whiteColor];
        _MVCountLabel.layer.masksToBounds = YES;
        _MVCountLabel.layer.cornerRadius = 10;
      
        _MVCountLabel.layer.borderWidth = 0.5f;
        _MVCountLabel.layer.borderColor = [UIColor colorWithHexString:@"#ffae02"].CGColor;
        _MVCountLabel.hidden = YES;
    }
    return _MVCountLabel;
}

-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
        _MVImageView.image = [UIImage imageNamed:@"shopping_car"];
        
    }
    return _MVImageView;
}
-(UIButton *)MVButton
{
    if (_MVButton == nil)
    {
        _MVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVButton addTarget:self action:@selector(btnCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVButton;
}

-(void)btnCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pGotoShoppingCar:)])
    {
        [self.KVDelegate pGotoShoppingCar:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVImageView.frame   = CGRectMake(10, 10, self.v_width-20, self.v_height-20);
    _MVButton.frame      = self.bounds;
    _MVCountLabel.frame  = CGRectMake(_MVImageView.v_right-15, 0, 20 ,20 );
    
}

@end
