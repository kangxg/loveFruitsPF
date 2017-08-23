//
//  KGHeadIconView.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHeadIconView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGHeadIconView()
{
    UIImageView * _mImageView;
 
    
    UIButton    * _mSelectButton;
  
}
@property (nonatomic,retain)UIImageView  * MVImageView;
@property (nonatomic,retain)UIImageView  * MVSelectedView;
@property (nonatomic,retain)UIButton     * MVSelectButton;
@property (nonatomic,copy)NSString       * MVIconName;
@end
@implementation KGHeadIconView

@synthesize MVImageView     = _mImageView;
@synthesize MVSelectButton      = _mSelectButton;

-(id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _MVIconName = imageName;
        [self addSubview:self.MVImageView];
       
        [self addSubview:self.MVSelectButton];
        [self addSubview:self.MVSelectedView];
    }
    return self;
}
-(UIImage *)selectedImage
{
    return _mImageView.image;
}
-(void)setSelectButtonNomal
{
    _MVSelectedView.hidden = YES;
     _mSelectButton.selected=NO;
}
-(UIImageView *)MVImageView
{
    if (_mImageView == nil)
    {
        _mImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.v_width, self.v_height)];
        _mImageView.image = [UIImage imageNamed:_MVIconName];
        //_mGiftImageView.userInteractionEnabled=YES;
        
    }
    return _mImageView;
}
-(UIImageView *)MVSelectedView
{
    if (_MVSelectedView == nil)
    {
        UIImage * image = [UIImage imageNamed:@"icon_selected"];
        _MVSelectedView=[[UIImageView alloc]initWithFrame:CGRectMake(self.v_width-image.size.width-10, 0, image.size.width, image.size.height)];
        _MVSelectedView.image = [UIImage imageNamed:@"icon_selected"];
        _MVSelectedView.hidden = YES;
        //_mGiftImageView.userInteractionEnabled=YES;
        
    }
    return _MVSelectedView;
}

-(UIButton *)MVSelectButton
{
    if (_mSelectButton == nil)
    {
        //CGRectMake(self.v_width/2-44/2, 10.5, 44, 44)
        _mSelectButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.v_width, self.v_height)];
        [_mSelectButton addTarget:self action:@selector(clickSelectBtton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _mSelectButton;
}

-(void)clickSelectBtton
{
    _mSelectButton.selected=!_mSelectButton.selected;
    
    if (_mSelectButton.selected)
    {
        _MVSelectedView.hidden = false;
        //加入
        if ([self.KVDelegate respondsToSelector:@selector(pSelectedView:)])
        {
            [self.KVDelegate pSelectedView:self];
        }
        CAKeyframeAnimation * bounceAnimation =  [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        bounceAnimation.values = @[@(1.0),@(1.2), @(0.9), @(1.15), @(0.95), @(1.02), @(1.0)];
        bounceAnimation.duration = 1.0;
        bounceAnimation.calculationMode = kCAAnimationCubic;
        [self.MVImageView.layer addAnimation:bounceAnimation forKey:@"GiftImageViewAnimation"];
    }
    else
    {
        _MVSelectedView.hidden = YES;

        if ([self.KVDelegate respondsToSelector:@selector(pUnSelectedView:)])
        {
            [self.KVDelegate pUnSelectedView:self];
        }
        
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
