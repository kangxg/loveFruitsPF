//
//  KGLogFailAlertView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/22.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLogFailAlertView.h"

@implementation KGLogFailAlertView
-(void)setFailMeg:(NSString *)mes
{
    if (mes.length)
    {
         m_title.text = mes;
    }
    else
    {
         m_title.text = @"登录失败";
    }
   
}
-(void)createButton
{
    [super createButton];
    
    [m_EnterBt setTitle:@"重新登录" forState:UIControlStateNormal];
}
@end
