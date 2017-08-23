//
//  KGPayOverVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2017/1/1.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGPayOverVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGMainTabBarController.h"
#import "KGOrderDetalVCTR.h"
@interface KGPayOverVCTR ()

@end

@implementation KGPayOverVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"支付结果";
    [self createTopView];
    [self createButtonView];
    // Do any additional setup after loading the view.
}

-(void)createTopView
{
    UIImageView * imageView = [[UIImageView alloc]init];
    UIImage *  image = [UIImage imageNamed:@"支付成功"];
    imageView.image = image;
    imageView.frame = CGRectMake((self.view.v_width-65)/2, 45, 65, 65);
    [self.view addSubview:imageView];
    
    UILabel * orderTypeLabel = [[UILabel alloc]init];
    orderTypeLabel.text = @"支付成功";
    orderTypeLabel.font = [UIFont systemFontOfSize:14];
    orderTypeLabel.textAlignment = NSTextAlignmentCenter;
    orderTypeLabel.textColor = [UIColor colorWithHexString:@"#10cd6e"];
    orderTypeLabel.frame = CGRectMake(0, imageView.v_bottom +15, self.view.v_width, 20);
    [self.view addSubview:orderTypeLabel];
    
    
    UILabel * lineLabel = [[UILabel alloc]init];
 
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    lineLabel.frame = CGRectMake(0, orderTypeLabel.v_bottom +54, self.view.v_width, 0.5);
    [self.view addSubview:lineLabel];
    
}

-(void)createButtonView
{
    UIButton  * orderDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderDetailBtn.layer.masksToBounds = YES;
    orderDetailBtn.layer.cornerRadius  = 2.0f;
    orderDetailBtn.backgroundColor = [UIColor colorWithHexString:@"#ec4746"];
    orderDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [orderDetailBtn setTitle:@"订单详情" forState:UIControlStateNormal];
    [orderDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [orderDetailBtn addTarget:self action:@selector(gotoOrderDetail) forControlEvents:UIControlEventTouchUpInside];
    orderDetailBtn.frame = CGRectMake((ScreenWidth-290)/2, 220, 125, 40);
    [self.view addSubview:orderDetailBtn];
    
    UIButton  *backhomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backhomeBtn.layer.masksToBounds = YES;
    backhomeBtn.layer.cornerRadius  = 2.0f;
    backhomeBtn.backgroundColor = [UIColor colorWithHexString:@"#ec4746"];
    backhomeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [backhomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backhomeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backhomeBtn addTarget:self action:@selector(gotoHomeView) forControlEvents:UIControlEventTouchUpInside];
    
    backhomeBtn.frame = CGRectMake(orderDetailBtn.v_right+40, 220, 125, 40);
    [self.view addSubview:backhomeBtn];

}

-(void)gotoHomeView
{
    [self.navigationController popToRootViewControllerAnimated:false];
    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setSelectIndex:2 withTag:0];
}

-(void)gotoOrderDetail
{
    [self.navigationController popToRootViewControllerAnimated:false];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showOrderDetail" object: _KDOrderId];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
