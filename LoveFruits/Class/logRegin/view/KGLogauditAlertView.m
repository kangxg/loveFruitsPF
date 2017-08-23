//
//  KGReginFailAlertView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLogauditAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
@implementation KGLogauditAlertView
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
    m_BodyView.frame = CGRectMake(50, 180, ScreenWidth-100, 151);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}
-(void)setFailMeg:(NSString *)mes
{
    if (mes.length)
    {
        m_title.text = mes;
    }
//    else
//    {
//        m_title.text = @"还没有完善店铺信息!\n注意：不提交店铺信息将无法登入！";
//    }
    
}
-(void)createTitleView
{
    [super createTitleView];
    //    UIView * la = [[UIView alloc]init];
    //    la.frame =  CGRectMake(0, 0, m_BodyView.v_width, 41);
   
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 100);
    m_title.numberOfLines = 0;
    m_title.lineBreakMode = NSLineBreakByWordWrapping;
    m_title .backgroundColor = CommonlyUsedBtnColor;
    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
    
    NSString * title = @"还没有完善店铺信息!\n注意：不提交店铺信息将无法登入！";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:6];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    m_title.attributedText = attributedString;
    m_title.textAlignment = NSTextAlignmentCenter;
//    [m_title sizeToFit];
//    m_title.text = @"还没有完善店铺信息!\n注意：不提交店铺信息将无法登入！";
}
-(void)createButton
{
    [super createButton];
//    UILabel * line = [[UILabel alloc]init];
//    line.frame = CGRectMake(m_BodyView.v_width/2, 41, 0.5, 41);
//    line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
//    [m_BodyView addSubview:line];
    
    m_EnterBt.frame = CGRectMake(0, 100,m_BodyView.v_width, 51);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];

    [m_EnterBt setTitle:@"去填写信息" forState:UIControlStateNormal];
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
