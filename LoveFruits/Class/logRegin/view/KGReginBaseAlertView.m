//
//  KGReginBaseAlertView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGReginBaseAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
@implementation KGReginBaseAlertView
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
    m_BodyView.frame = CGRectMake(30, 190, ScreenWidth-60, 82);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}

-(void)createTitleView
{
    [super createTitleView];
//    UIView * la = [[UIView alloc]init];
//    la.frame =  CGRectMake(0, 0, m_BodyView.v_width, 41);
    
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 41);
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
     m_EnterBt.frame = CGRectMake(0, 41,m_BodyView.v_width, 41);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
}
-(void)createLable
{
    
}
-(void)createbodyImageView
{
    
}
-(void)createBodyMessageView
{
    
}
@end

@implementation KGReginedAlertView
-(void)createTitleView
{
    [super createTitleView];
    
    m_title.text = @"手机号已注册";
}
-(void)createButton
{
    [super createButton];
    [m_EnterBt setTitle:@"立即登录" forState:UIControlStateNormal];
}
@end

@implementation KGReginFailAlertView
-(void)createTitleView
{
    [super createTitleView];
    m_title.text = @"注册失败";

}
@end


@implementation KGReginSuccessAlertView
-(void)createBodyView
{
    [super createBodyView];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    m_BodyView.frame = CGRectMake(30, 190, ScreenWidth-60, 151);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}

-(void)createTitleView
{
    [super createTitleView];
    //    UIView * la = [[UIView alloc]init];
    //    la.frame =  CGRectMake(0, 0, m_BodyView.v_width, 41);
    
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width,100);
    m_title.numberOfLines = 0;
    m_title.lineBreakMode = NSLineBreakByWordWrapping;
//    m_title .backgroundColor = CommonlyUsedBtnColor;
//    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
    
     m_title.text = @"注册成功\n注意：需要填写商户信息后方可登入\n系统购物！";
    
}
-(void)createButton
{
    [super createButton];
    m_EnterBt.frame = CGRectMake(0, 100,m_BodyView.v_width, 51);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
}

@end
