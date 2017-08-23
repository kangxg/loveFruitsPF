//
//  KGPaymentVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/22.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPaymentVCTR.h"

//#import "BCNetworking.h"
//#import "BCOffinePay.h"



//
//#import "BDWalletSDKMainManager.h"
@interface KGPaymentVCTR ()
@property (nonatomic,retain)NSMutableArray *  MVChannelList;
@end

@implementation KGPaymentVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"支付";
//    NSArray *live = @[@{@"channel":@"线上支付",
//                        @"subChannel":@[@{@"sub":@(PayChannelWxApp), @"img":@"wx", @"title":@"微信支付"},
//                                        @{@"sub":@(PayChannelBCWXApp), @"img":@"wx", @"title":@"BC微信支付"},
//                                        @{@"sub":@(PayChannelAliApp), @"img":@"ali", @"title":@"支付宝"},
//                                        @{@"sub":@(PayChannelUnApp), @"img":@"un", @"title":@"银联在线"},
//                                        @{@"sub":@(PayChannelBaiduApp), @"img":@"baidu", @"title":@"百度钱包"},
//                                        @{@"sub":@(PayChannelPayPal), @"img":@"paypal", @"title":@"PayPal"},
//                                        @{@"sub":@(PayChannelApplePayTest), @"img":@"apple", @"title":@"ApplePay"} //相关文档 http://help.beecloud.cn/hc/kb/article/177410/?from=draft
//                                        ]}];
    
    // Do any additional setup after loading the view.
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
