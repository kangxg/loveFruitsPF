//
//  KGHaveNavViewVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
@implementation KGHaveNavViewVCTR
@synthesize KVTitleLabel = _KVTitleLabel;
-(void)viewDidLoad
{
    [super viewDidLoad];
    _KGIsAnimation = YES;
    
    self.view.backgroundColor = LFBNavigationHomeSearchColor;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#f9f9f9"]];
    self.navigationItem.titleView = self.KVTitleLabel;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.KGNavBackButton];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
   
}
-(void)setBackView:(BOOL)hiden
{
    _KGNavBackButton.hidden = hiden;
}
-(UILabel *)KVTitleLabel
{
    if (_KVTitleLabel == nil)
    {
        _KVTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-120, 44)];
        _KVTitleLabel.textColor = [UIColor colorWithHexString:@"#585858"];
        _KVTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        _KVTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _KVTitleLabel;
}

-(UIButton *)KGNavBackButton
{
    if (_KGNavBackButton == nil)
    {
        _KGNavBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _KGNavBackButton.titleLabel.hidden = true;
        [_KGNavBackButton setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        [_KGNavBackButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _KGNavBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _KGNavBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        CGFloat btnW = ScreenWidth>375.0?50:44;
        _KGNavBackButton.frame =  CGRectMake(0, 0, btnW, 40);
        
    }
    return _KGNavBackButton;
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:_KGIsAnimation];
}
@end
