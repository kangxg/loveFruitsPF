//
//  KGSubmitOrdersVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSubmitOrdersVCTR.h"
#import "KGSubmitOrdersModel.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"
#import "KGPayTableCell.h"
#import "KGSelectedBuyProductCell.h"
#import "KGOrderCouponsCell.h"
#import "KGOrdersAdressCell.h"
#import "KGProgressHUDManager.h"
#import "KGPaymentMethodVCTR.h"
#import "iToast.h"
#import "KGSelectCouponVCTR.h"
#import "KGMyOrdersVCTR.h"
#import "KGAnimationView.h"
@interface KGSubmitOrdersVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate,KGTableCellDelegate>

@property (nonatomic,retain)UITableView              * MVTableView;
@property (nonatomic,retain)KGSubmitOrdersModel        * MVModel;
@property (nonatomic,retain)UIView                   * MVBottomView;
@property (nonatomic,retain)UIButton                 * MVSubmitBtn;
@property (nonatomic,retain)UILabel                  * MVSumtileLabel;
@property (nonatomic,retain)UILabel                  * MVSumLabel;
@property (nonatomic,retain)KGAnimationView          * MVLoadingView;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@end

@implementation KGSubmitOrdersVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"确认订单";
    [self initData];
   [self beginOrderInfoNetwork];
    // Do any additional setup after loading the view.
}

-(void)createLoadingView
{
    if (!_MVLoadingView.superview)
    {
        [self.view addSubview:self.MVLoadingView];
    }
}

-(void)removeLoadingView
{
    if (_MVLoadingView.superview)
    {
        
        [_MVLoadingView removeFromSuperview];
        _MVLoadingView = nil;
    }
}
-(KGAnimationView  *)MVLoadingView
{
    if (_MVLoadingView == nil)
    {
        _MVLoadingView = [[KGAnimationView  alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
        
    }
    return _MVLoadingView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeLoadingView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)createView
{
    [self.view addSubview:self.MVTableView];
    [self createBottomView];
    [self setBuyCountMoney:[_MVModel getProductsMoneySum]];
}
-(void)initData
{
    _MVModel = [[KGSubmitOrdersModel alloc]init];
}
-(void)beginOrderInfoNetwork
{
     [self.MRequestHelper beginRequest:@[_MVModel.KDAdressRequestItem,_MVModel.KDCouponUnuseRequestItem]];
}
-(void)initCouponNetwork
{
    [self.MRequestHelper beginRequestWithItem:_MVModel.KDCouponUnuseRequestItem];
}
-(YZNetworkRequestHelper *)MRequestHelper
{
    if (_MRequestHelper == nil)
    {
        _MRequestHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEPOSTREQUEST];
        _MRequestHelper.YNetworkRequestDelegate = self;
    }
    
    return _MRequestHelper;
}

-(void)initSubmitOrderNetworkRequest
{
    YZRequestItem * item =_MVModel.KDOrdersRequestItem;
    NSMutableDictionary * dic  = item.YRequestDic;
    [dic   setValue:[_MVModel getProductsMoneySum] forKey:@"amount"];
    [dic   setValue:@"online" forKey:@"pay_choice"];
    NSArray * arr = [_MVModel getWaresArr];
   
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [dic   setValue:str forKey:@"order_wares"];
    [dic   setValue:@"0" forKey:@"order_freight"];
    if (_MVModel.KDUseCouponId.length)
    {
        [dic   setValue:_MVModel.KDUseCouponId forKey:@"coupon_id"];
    }
    else
    {
        [dic removeObjectForKey:@"coupon_id"];
    }
    [dic   setValue:_MVModel.KDAdressId forKey:@"addr_id"];

    [self.MRequestHelper beginRequestWithItem:_MVModel.KDOrdersRequestItem];
}

#pragma mark   --------------------- 网络请求delegate---------------------------

/**
 *  Description  网络请求开始
 *
 *  @param requestTag 请求model 的tag
 */
-(void)pRequestWillBegin:(YZRequestItem *)requestItem
{
    if (!requestItem || requestItem.YRequestOption.hasLoad == false)
    {
        return;
    }
    
    
    [self  startLoadingView];
    
    
}
/**
 *  Description 网络请求 完成
 */
-(void)pRequestFinished
{
    
    if (self.MRequestHelper.YNetworkRequestCount== 0)
    {
        [self stopLoadingView];
    }
    
}

/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
    [self createLoadingView];

//    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
//    
//    if (![KGProgressHUDManager isVisible])
//    {
//        [KGProgressHUDManager showWithStatus:@"正在加载中"];
//    }
    
    //    [YZLoadingVew showLoadingViewWithSuperView:self frame:CGRectMake(0,kDHeight , kScreenWith, kScreenHeight-kDHeight)];
    
}

/**
 *  Description 停止 加载 网络请求指示视图
 */
-(void)stopLoadingView
{
    //    if ([YZLoadingVew isLoadingViewShow])
    //    {
    if (self.MRequestHelper.YNetworkRequestCount == 0)
    {
        [self removeLoadingView];
//        [KGProgressHUDManager dismiss];
        //        [YZLoadingVew dissmissLaodingViewFromSuperView:self];
    }
    
    //}
}

/**
 *  Description   请求成功
 *
 *  @param requestTag 请求 tag
 *  @param jsonDic
 */
-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingOrderNetworkBack:state withType:type];
            }];
          
            
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingUserAdressNetworkBack:state];
            }];
        }
        
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf.MVTableView reloadData];
            }];
        }
        default:
            break;
    }
    
    
    
    
}
-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
//            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
//            //            alertView.NTAlertDelegate = self;
//            [alertView ShowView];
            
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
//            if ([[jsonDic valueForKey:@"message"] isEqualToString:@"手机号已注册"])
//            {
//                KGReginedAlertView * alertView = [KGReginedAlertView createAlertView:EN_NTAlertViewStyleCorner];
//                alertView.NTAlertDelegate = self;
//                alertView.tag = 100;
//                [alertView ShowView];
//            }
//            else
//            {
//                KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
//                
//                [alertView ShowView];
//            }
            
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)ProcessingOrderNetworkBack:(YZProcessingDataState )state withType:(NSInteger)type
{
    switch (type) {
        case -2:
        {
             [[iToast makeText:@"无此订单！"]show];
        }
            break;
        case -1:
        {
            [[iToast makeText:@"订单失败！"]show];
        }
            break;
        case 0:
        {
            
        }
           
        case 1:
        {
            
        }
            
        case 2:
        {
            [_MVModel resetUseCoupon];
            if(_MVModel.KDHaveCouponCount)
            {
                 _MVModel.KDHaveCouponCount --;
            }
           
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            
            KGOrderCouponsCell  * buyCell = [_MVTableView cellForRowAtIndexPath:indexPath];
            [buyCell setUseCouponcount:_MVModel.KDHaveCouponCount ];
            [self setBuyCountMoney:[_MVModel getProductsMoneySum]];
            KGMyOrdersVCTR * vctr = [[KGMyOrdersVCTR alloc]init];
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)ProcessingUserAdressNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self createView];
            
        }
            break;
        case YZPROCESSINGDATAFAILT:
        {
            
            
        }
        case YZPROCESSINGDATANONE:
        {
            
        }
        case YZPROCESSINGDATAERROR:
        {
            
        }
            
        case YZPROCESSINGDATANULL:
        {
            [[iToast makeText:@"获取用户信息失败"]show];
            [self.navigationController popViewControllerAnimated:YES];
//            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
//            
//            [alertView ShowView];
        }
            break;
            
            
            
        default:
            break;
    }

}


-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-NavigationH-48) style:UITableViewStylePlain];
        _MVTableView.backgroundColor=LFBNavigationHomeSearchColor;
        _MVTableView.delegate=self;
        _MVTableView.dataSource=self;
        _MVTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
//        _MVTableView.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
        
        
        
    }
    return _MVTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section)
    {
        case 0:
        {
            count = 1;
        }
            break;
        case 1:
        {
            count = 1;
        }
            break;
        case 2:
        {
            count = [_MVModel getOrdersProduct].count;
        }
            break;
        case 3:
        {
            count = 1;
        }
            break;
        default:
            break;
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = 0;
    switch (indexPath.section)
    {
        case 0:
        {
            count = 84;
        }
            break;
        case 1:
        {
            count = 48;
        }
            break;
        case 2:
        {
            count = 116;
        }
            break;
        case 3:
        {
            count = 48;
        }
            break;
        default:
            break;
    }
    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    if (section== 3)
    {
        return 44;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3)
    {
        
        UIView * view = [[UIView alloc]init];
        view.frame =  CGRectMake(0, 0, ScreenWidth, 44);
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 44)];
        lab.font = [UIFont systemFontOfSize:12.0f];
        lab.textColor = [UIColor colorWithHexString:@"#999999"];
        lab.backgroundColor = self.view.backgroundColor;
        lab.text = @"注：运费在您收获时根据订购的商品多少如实收取，请知晓";
        [view addSubview:lab];
        return view;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        UIView * view = [[UIView alloc]init];
        view.frame =  CGRectMake(0, 0, ScreenWidth, 40);
        view.backgroundColor = [UIColor whiteColor];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 29.5)];
        lab.font = [UIFont systemFontOfSize:14.0f];
        lab.textColor = [UIColor colorWithHexString:@"#333333"];
        lab.backgroundColor = [UIColor whiteColor];
        lab.text = @"商品清单";
        [view addSubview:lab];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, ScreenWidth-20, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        [view addSubview:line];
        return view;

    }
    return nil;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
            
        case 0:
        {
             KGOrdersAdressCell  * adcell = [tableView dequeueReusableCellWithIdentifier:@"adCell"];
            if (adcell == nil)
            {
                adcell = [[ KGOrdersAdressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"adCell"];
                
            }
            [adcell updateCell:_MVModel];
            return adcell;
        }
            break;
        case 1:
        {
            KGPayTableCell  * paycell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
            if (paycell == nil)
            {
                paycell = [[KGPayTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"payCell"];
//                paycell.KVDelegate = self;
            }
            
            return paycell;
        }
            break;
        case 2:
        {
            KGSelectedBuyProductCell  * buyCell =[tableView dequeueReusableCellWithIdentifier:@"buyCell"];
            if (buyCell == nil)
            {
               buyCell = [[KGSelectedBuyProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"buyCell"];
                
            }
             [buyCell updateViews:[self.MVModel shopGoods:indexPath.row]];
            return buyCell;

        }
            break;
        case 3:
        {
            KGOrderCouponsCell  * buyCell =[tableView dequeueReusableCellWithIdentifier:@"couponsCell"];
            if (buyCell == nil)
            {
                buyCell = [[KGOrderCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"couponsCell"];
              
            }
            [buyCell setUseCouponcount:_MVModel.KDHaveCouponCount];
          
            return buyCell;
        
        }
            break;
        default:
            break;
    }

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 3:
        {
            if (_MVModel.KDHaveCouponCount)
            {
                KGWEAKOBJECT(weakSelf);
                KGSelectCouponVCTR  * vctr = [[KGSelectCouponVCTR alloc]init:^(NSDictionary *dic) {
                    [weakSelf setUseCoupon:dic];
                }];

                [self.navigationController pushViewController:vctr animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)setUseCoupon:(NSDictionary *)dic
{
    [_MVModel setUseCoupon:dic];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    
    KGOrderCouponsCell  * buyCell = [_MVTableView cellForRowAtIndexPath:indexPath];
    [buyCell setUserCoupon:_MVModel.KDUseCoupondenom];
    [self setBuyCountMoney:[_MVModel getProductsMoneySum]];
}
-(void)pSelectedView:(id)sender withInfo:(NSDictionary * )info
{
    if (info)
    {
        BOOL selected = [[info valueForKey:@"seleted"]boolValue];
        _MVModel.KDPaySelected = selected;
    }
}

-(void)createBottomView
{
    [self.view addSubview:self.MVBottomView];
    [_MVBottomView addSubview:self.MVSubmitBtn];
    [_MVBottomView addSubview:self.MVSumLabel];
    [_MVBottomView addSubview:self.MVSumtileLabel];
}

-(UIView *)MVBottomView
{
    if (_MVBottomView == nil)
    {
        _MVBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _MVTableView.v_height, self.view.v_width, 48)];
        _MVBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _MVBottomView;
}

-(void)setBuyCountMoney:(NSString *)moneySum
{
    _MVSumLabel.text = [NSString stringWithFormat:@"￥%@",moneySum];
    [_MVSumLabel sizeToFit];
    _MVSumLabel.frame = CGRectMake(_MVBottomView.v_width-_MVSubmitBtn.v_width-9-_MVSumLabel.v_width, 0, _MVSumLabel.v_width, 48);
    
    _MVSumtileLabel.frame =CGRectMake(_MVBottomView.v_width-_MVSubmitBtn.v_width-9-_MVSumLabel.v_width-_MVSumLabel.v_width-5, 0, _MVSumtileLabel.v_width, 48);
}
-(UIButton *)MVSubmitBtn
{
    if (_MVSubmitBtn == nil)
    {
        _MVSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVSubmitBtn.frame = CGRectMake(ScreenWidth- 113, 0, 113, 48);
        [_MVSubmitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        _MVSubmitBtn.backgroundColor = CommonlyUsedBtnColor;
        _MVSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_MVSubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVSubmitBtn addTarget:self action:@selector(enterBuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVSubmitBtn;
}

-(void)enterBuy
{
    [self initSubmitOrderNetworkRequest];
//    KGPaymentMethodVCTR  * vctr = [[KGPaymentMethodVCTR  alloc]init];
//    [self.navigationController pushViewController:vctr animated:YES];
}
-(UILabel *)MVSumtileLabel
{
    if (_MVSumtileLabel == nil)
    {
        _MVSumtileLabel = [[UILabel alloc]init];
        _MVSumtileLabel.font = [UIFont systemFontOfSize:12];
        _MVSumtileLabel.text = @"合计：";
        [_MVSumtileLabel sizeToFit];
        _MVSumtileLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVSumtileLabel;
}

-(UILabel *)MVSumLabel
{
    if (_MVSumLabel == nil)
    {
        _MVSumLabel = [[UILabel alloc]init];
        _MVSumLabel.font = [UIFont systemFontOfSize:12];
//        _MVSumLabel.text = @"在线支付：";
        _MVSumLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
    }
    return _MVSumLabel;
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
