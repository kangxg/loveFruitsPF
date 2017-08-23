//
//  KGHomeCommodityListVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCommodityListVCTR.h"
#import "GlobelDefine.h"
#import "KGHomeCommodityCell.h"
#import "UIView+Extension.h"
#import "KGMainTabBarController.h"
@implementation KGHomeCommodityListVCTR
@synthesize KModel          = _KModel;;
@synthesize KVHeadImageView = _KVHeadImageView;
@synthesize KVTableView     = _KVTableView;
@synthesize KVShopCarBtn    = _KVShopCarBtn;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _KModel = [[KGHomeCommodityViewModel alloc]init];
    [self.view addSubview:self.KVTableView];
//    self.KVTableView.backgroundColor = [UIColor redColor];
    self.KVTableView.tableHeaderView = self.KVHeadImageView;
    [self.view addSubview:self.KVShopCarBtn];
}
-(UIButton *)KVShopCarBtn
{
    if (_KVShopCarBtn == nil)
    {
        _KVShopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _KVShopCarBtn.frame = CGRectMake(11, ScreenHeight - NavigationH-51, ScreenWidth-22, 40);
        _KVShopCarBtn.layer.masksToBounds  = YES;
        _KVShopCarBtn.layer.cornerRadius   = 10.0f;
        _KVShopCarBtn.backgroundColor      =CommonlyUsedBtnColor;
       
        [_KVShopCarBtn setTitle:@"到商城看看" forState: UIControlStateNormal];
        [_KVShopCarBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [_KVShopCarBtn addTarget:self action:@selector(gotoMoreShop) forControlEvents:UIControlEventTouchUpInside];
        _KVShopCarBtn.titleLabel.font      = [UIFont systemFontOfSize:16.0f];
    }
    return _KVShopCarBtn;
}

-(void)gotoMoreShop
{
    [self.navigationController popViewControllerAnimated:false];
    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setSelectIndex:0 withTag:1];
}
-(UIImageView *)KVHeadImageView
{
    if (_KVHeadImageView == nil)
    {
        _KVHeadImageView = [[UIImageView alloc]init];
       
        
        _KVHeadImageView.frame = CGRectMake(0, 0, ScreenWidth, 140);
        
        
    }
    return _KVHeadImageView;
}

-(UITableView *)KVTableView
{
    if (_KVTableView == nil)
    {
        _KVTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -NavigationH -52)style:UITableViewStyleGrouped ];
//        _KVTableView.backgroundColor=KColorCustom(@"#f3f2f0");
        _KVTableView.delegate = self;
        _KVTableView.dataSource = self;
        _KVTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _KVTableView.showsVerticalScrollIndicator = NO;
    }
    return _KVTableView;
}

#pragma mark --- table view delegate  -------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //_KModel.KDCellModelArry.count+
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 33.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view           = [[UIView alloc]init];
    view.frame              = CGRectMake(0, 0, ScreenWidth, 33);
  
    UILabel * line          = [[UILabel alloc]init];
    line.frame              = CGRectMake(33, 33/2, ScreenWidth-66,0.5 );
    line.backgroundColor    = [UIColor colorWithHexString:@"#d8d8d8"];
    UILabel * downLabel     = [[UILabel alloc]init];
       downLabel.textAlignment = NSTextAlignmentCenter;
    downLabel.text          = @"已经到底了";
    downLabel.backgroundColor = self.view.backgroundColor;
    downLabel.textColor     = [UIColor colorWithHexString:@"#999999"];
    downLabel.font          = [UIFont systemFontOfSize:13.0f];
    [downLabel sizeToFit];
    downLabel.frame         = CGRectMake((ScreenWidth-downLabel.v_width)/2-16, (33-downLabel.v_height)/2, downLabel.v_width +32, downLabel.v_height);

    [view addSubview:line];
    [view addSubview:downLabel];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 116;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGHomeCommodityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCommodityCell"];
    if (cell == nil)
    {
        cell = [[KGHomeCommodityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCommodityCell"];
        cell.KVDelegate = self;
        [cell updateCell:nil];
//        [cell updateCell:[_KModel.KDCellModelArry objectAtIndex:indexPath.row]];
    }
//   KGHomeCommodityCell * cell = [[KGHomeCommodityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCommodityCell"];
    return cell;
    
}

-(void)pClickBuy:(id)object
{
    
}
@end
