//
//  KGOrderAlertView.m
//  LoveFruits
//
//  Created by kangxg on 2017/1/1.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGOrderAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
@implementation KGOrderAlertView
-(void)initView
{
    [super initView];
     self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4f];
    [self createbodyImageView];
    [self createBodyView];
    [self createTitleView];
    [self createBodyMessageView];
    [self createButton];
}
-(void)createBodyView
{
    [super createBodyView];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    m_BodyView.frame = CGRectMake(60, 210, ScreenWidth-120, 120);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}

-(void)createTitleView
{
    [super createTitleView];
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 60);
    m_title .backgroundColor = CommonlyUsedBtnColor;
    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
   
}
-(void)createButton
{
    [super createButton];
    UILabel * line = [[UILabel alloc]init];
    line.frame = CGRectMake(m_BodyView.v_width/2, 60, 0.5, 60);
    line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [m_BodyView addSubview:line];
    m_EnterBt.frame = CGRectMake(0, 60,m_BodyView.v_width/2, 60);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    m_CancelBt.frame = CGRectMake(m_BodyView.v_width/2, 60,m_BodyView.v_width/2-0.5, 60);
    
    [m_CancelBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_CancelBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    
}-(void)createLable
{
    
}
-(void)createbodyImageView
{
    
}
-(void)createBodyMessageView
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation KGDeleteOrderAlertView
-(void)createBodyView
{
    [super createBodyView];
  
}

-(void)createTitleView
{
    [super createTitleView];
   
    m_title.text = @"是否删除订单？";
}
-(void)createButton
{
    [super createButton];
  
    
}

@end

@implementation KGReciveOrderAlertView
-(void)createBodyView
{
    [super createBodyView];
  }

-(void)createTitleView
{
    [super createTitleView];
    m_title.text = @"确认订单已送达？";
}
-(void)createButton
{
    [super createButton];
    
    
    
}
@end


@implementation KGCannelOrderAlertView
-(void)createBodyView
{
    [super createBodyView];
}

-(void)createTitleView
{
    [super createTitleView];
    m_title.text = @"是否取消订单？";
}
-(void)createButton
{
    [super createButton];
    
    
    
}
@end

