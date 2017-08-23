//
//  KGDeleteProductAlertView.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductAlertView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
@implementation KGProductAlertView
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
//    m_BodyView.backgroundColor = [UIColor whiteColor];
//    m_BodyView.frame = CGRectMake(30, 190, ScreenWidth-60, 82);
//    m_BodyView.backgroundColor = [UIColor whiteColor];
}

-(void)createTitleView
{
    [super createTitleView];
    //    UIView * la = [[UIView alloc]init];
    //    la.frame =  CGRectMake(0, 0, m_BodyView.v_width, 41);
    
//    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 41);
//    m_title .backgroundColor = [UIColor colorWithHexString:@"#ec4746"];
//    m_title.textColor = [UIColor whiteColor];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = m_title.bounds;
//    maskLayer.path = maskPath.CGPath;
//    m_title.layer.mask = maskLayer;
    
}
-(void)createButton
{
    [super createButton];
//    m_EnterBt.frame = CGRectMake(0, 41,m_BodyView.v_width, 41);
//    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
//    
//    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation KGDeleteProductAlertView
-(void)createBodyView
{
    [super createBodyView];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    m_BodyView.frame = CGRectMake(30, 210, ScreenWidth-60, 82);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}
-(void)createTitleView
{
    [super createTitleView];
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 41);
    m_title .backgroundColor = CommonlyUsedBtnColor;
    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
    m_title.text = @"确认要删除选择中的商品吗？";
}
-(void)createButton
{
    [super createButton];
    UILabel * line = [[UILabel alloc]init];
    line.frame = CGRectMake(m_BodyView.v_width/2, 41, 0.5, 41);
    line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [m_BodyView addSubview:line];
    m_EnterBt.frame = CGRectMake(0, 41,m_BodyView.v_width/2, 41);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    m_CancelBt.frame = CGRectMake(m_BodyView.v_width/2, 41,m_BodyView.v_width/2-0.5, 41);
    
    [m_CancelBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_CancelBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
   
}
@end

@implementation KGMissingUserInfoAlertView
-(void)createBodyView
{
    [super createBodyView];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    m_BodyView.frame = CGRectMake(30, 210, ScreenWidth-60, 143);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}
-(void)createTitleView
{
    [super createTitleView];
    m_title.lineBreakMode  = NSLineBreakByWordWrapping;
    m_title.numberOfLines  = 0;
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 82);
    m_title .backgroundColor = CommonlyUsedBtnColor;
    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
    m_title.text = @"未填写商户信息将无法下单哦！\n 是否现在去提交资料？";
}
-(void)createButton
{
    [super createButton];
    UILabel * line = [[UILabel alloc]init];
    line.frame = CGRectMake(m_BodyView.v_width/2, 82, 0.5, 61);
    line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [m_BodyView addSubview:line];
    m_EnterBt.frame = CGRectMake(0, 82,m_BodyView.v_width/2, 61);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    m_CancelBt.frame = CGRectMake(m_BodyView.v_width/2, 82,m_BodyView.v_width/2-0.5, 61);
    
    [m_CancelBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_CancelBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    
}

@end

@implementation KGUserAuditingAlertView
-(void)createBodyView
{
    [super createBodyView];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    m_BodyView.frame = CGRectMake(30, 210, ScreenWidth-60, 143);
    m_BodyView.backgroundColor = [UIColor whiteColor];
}

-(void)createTitleView
{
    [super createTitleView];
    m_title.lineBreakMode  = NSLineBreakByWordWrapping;
    m_title.numberOfLines  = 0;
    m_title.frame = CGRectMake(0, 0, m_BodyView.v_width, 82);
    m_title .backgroundColor = CommonlyUsedBtnColor;
    m_title.textColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_title.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = m_title.bounds;
    maskLayer.path = maskPath.CGPath;
    m_title.layer.mask = maskLayer;
    
    NSString * title = @"账户信息正在审核中\n暂时还不能购物哦";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:6];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    m_title.attributedText = attributedString;
    m_title.textAlignment = NSTextAlignmentCenter;
//    m_title.text = @"账户信息正在审核中\n暂时还不能购物哦";
}

-(void)createButton
{
    [super createButton];
  
    m_EnterBt.frame = CGRectMake(0, 82,m_BodyView.v_width, 61);
    [m_EnterBt setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    m_EnterBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    
}
@end
