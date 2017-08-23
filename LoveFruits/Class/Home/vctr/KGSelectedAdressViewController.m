//
//  KGSelectedAdressViewController.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSelectedAdressViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KGUserInfo.h"
#import "KGAdressTitleView.h"
#import "KGAdressData.h"
#import "KGQRCodeVCTR.h"
#import "KGSearchProductVCTR.h"
//#import "KGEnum.h"
@interface KGSelectedAdressViewController()
@property (nonatomic,retain)KGAdressTitleView * MTitleView;
@end
@implementation KGSelectedAdressViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[KGUserInfo sharedUserInfo] hasDefaultAdress])
    {
        Address * adress = [[KGUserInfo sharedUserInfo] defaultAdress];
        NSString * value = adress.address;
        [self.MTitleView setTitle:value];

        self.MTitleView.frame = CGRectMake(0, 0, self.MTitleView.KGAdressWidth, 30);
       
    }
    
}

-(KGAdressTitleView *)MTitleView
{
    if (_MTitleView == nil)
    {
        KGAdressTitleView * titleview = [[KGAdressTitleView alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleViewClick)];
        [titleview addGestureRecognizer:tap];
        self.navigationItem.titleView = titleview;
        _MTitleView = titleview;

    }
    return _MTitleView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildNavigationItem];
    
}

-(void)buildNavigationItem
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButton:@"扫一扫" titleColor:[UIColor blackColor] withImage:[UIImage imageNamed:@"icon_black_scancode"] hightLightImage:nil target:self action:@selector(leftItemClick) type:KGNAVITEMBUTTONTYPELEFT];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButton:@"搜索" titleColor:[UIColor blackColor] withImage:[UIImage imageNamed:@"icon_search"] hightLightImage:nil target:self action:@selector(rightItemClick) type:KGNAVITEMBUTTONTYPERIGHT];
    
     self.MTitleView.frame = CGRectMake(0, 0, self.MTitleView.KGAdressWidth, 30);
    
}


-(void)leftItemClick
{
    KGQRCodeVCTR * vctr = [[KGQRCodeVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}

-(void)rightItemClick
{
    KGSearchProductVCTR * vctr = [[KGSearchProductVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}

-(void)titleViewClick
{
   // __weak KGSelectedAdressViewController * tmpSelf = self;
    
}
@end
