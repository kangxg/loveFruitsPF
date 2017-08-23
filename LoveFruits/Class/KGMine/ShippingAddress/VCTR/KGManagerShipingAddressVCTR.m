//
//  KGManagerShipingAddressVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGManagerShipingAddressVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGShipingAddressViewModel.h"
#import "KGShipingAddressCell.h"
#import "KDAddAddressVCTR.h"
@interface KGManagerShipingAddressVCTR()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView * MVTableView;
@property (nonatomic,retain)UIButton    * MVAddressBtn;
@property (nonatomic,retain)KGShipingAddressViewModel  * MVModel;
@end

@implementation KGManagerShipingAddressVCTR
@synthesize MVTableView   = _MVTableView;
@synthesize MVAddressBtn  = _MVAddressBtn;
@synthesize MVModel       = _MVModel;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"管理收货地址";
    [self initdata];
    [self.view addSubview:self.MVTableView];
    [self.view addSubview:self.MVAddressBtn];
}
-(void)initdata
{
    _MVModel =[[KGShipingAddressViewModel alloc]init];
}
-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-69-NavigationH) style:UITableViewStylePlain];
        _MVTableView.backgroundColor=LFBNavigationHomeSearchColor;
        _MVTableView.delegate=self;
        _MVTableView.dataSource=self;
        _MVTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       
        _MVTableView.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
      
       

    }
    return _MVTableView;
}

-(UIButton *)MVAddressBtn
{
    if (_MVAddressBtn == nil)
    {
        _MVAddressBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,self.MVTableView.v_bottom+15, ScreenWidth-22, 40)];
        
        _MVAddressBtn.backgroundColor= CommonlyUsedBtnColor;
        _MVAddressBtn.layer.masksToBounds=YES;
        _MVAddressBtn.layer.cornerRadius=5;
        [_MVAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_MVAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVAddressBtn addTarget:self action:@selector(clickAddress) forControlEvents:UIControlEventTouchUpInside];
       _MVAddressBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        
    }
    return _MVAddressBtn;
}

-(void)clickAddress
{
    KDAddAddressVCTR * vctr = [[KDAddAddressVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _MVModel.KDAddressModelArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * resuse=@"shipingCell";
    KGShipingAddressCell * cell =[[KGShipingAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse];
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    return 10.0;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
