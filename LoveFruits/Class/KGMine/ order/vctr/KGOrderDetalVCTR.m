//
//  KGOrderDetalVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderDetalVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGOrderDetailViewModel.h"
#import "KGLoadFailView.h"
#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestHelpDelegate.h"
#import "YZRequestItem.h"
#import "KGProgressHUDManager.h"
#import "KGOrderDetailTitleCell.h"
#import "KGOrderProductCell.h"
#import "KGOrderInfoCell.h"
#import "KGOrderUserInfoCell.h"
#import "iToast.h"
#import "KGOrderAlertView.h"
#import "KGPaymentMethodVCTR.h"
#import "FeSpinnerTenDot.h"
@interface KGOrderDetalVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate,NTAlertViewDelegate>

@property (nonatomic,retain)KGOrderDetailViewModel    *  MVModel;
@property (nonatomic,retain)UITableView               *  MVTableView;
@property (nonatomic,retain)YZNetworkRequestHelper    *  MRequestHelper;

@property (nonatomic,retain)KGLoadFailView            *  MVloadFailView;

@property (nonatomic,retain)FeSpinnerTenDot           * MVLoadingView;
@end

@implementation KGOrderDetalVCTR

-(id)init
{
    if (self = [super init])
    {
        [self initData];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"订单详情";
    [self.view addSubview:self.MVTableView];
    [self createDownView];
    [self beginOrderDetailRequest];
    // Do any additional setup after loading the view.
}

-(void)createLoadingView
{
    if (!_MVLoadingView.superview)
    {
        [self.view addSubview:self.MVLoadingView];
    }
    
    [self.MVLoadingView show];
}

-(void)removeLoadingView
{
    if (_MVLoadingView.superview)
    {
        [_MVLoadingView dismiss];
        [_MVLoadingView removeFromSuperview];
        _MVLoadingView = nil;
    }
}
-(FeSpinnerTenDot  *)MVLoadingView
{
    if (_MVLoadingView == nil)
    {
        _MVLoadingView = [[FeSpinnerTenDot  alloc] initWithView:self.view withBlur:NO];
        
    }
    return _MVLoadingView;
}

-(void)initData
{
    _MVModel = [[KGOrderDetailViewModel alloc]init];
   
}

-(void)setKVOrderId:(NSString *)KVOrderId
{
    _MVModel.KDOrderId = KVOrderId;
}
-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-NavigationH-50) style:UITableViewStylePlain];
        _MVTableView.backgroundColor=LFBNavigationHomeSearchColor;
        _MVTableView.delegate=self;
        _MVTableView.dataSource=self;
        _MVTableView.showsVerticalScrollIndicator = false;
        _MVTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _MVTableView.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
        
        
        
    }
    return _MVTableView;
}

-(void)createDownView
{
    [self.view addSubview:self.KVDownView];
}

-(UIView *)KVDownView
{
    if (_KVDownView == nil)
    {
        _KVDownView = [[UIView alloc]init];
        _KVDownView.frame = CGRectMake(0, self.view.v_height-NavigationH-50, ScreenWidth, 50);
        _KVDownView.backgroundColor = [UIColor whiteColor];
    }
    return _KVDownView;
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
-(void)beginOrderDetailRequest
{
    [self.MRequestHelper beginRequestWithItem:_MVModel.KDOrdersItem];
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
//        [self stopLoadingView];
        [self removeLoadingView];
    }
    
}

/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
    
    if (![KGProgressHUDManager isVisible])
    {
        [self createLoadingView];
//        [KGProgressHUDManager showWithStatus:@"正在加载中"];
    }
    
    //    [YZLoadingVew showLoadingViewWithSuperView:self frame:CGRectMake(0,kDHeight , kScreenWith, kScreenHeight-kDHeight)];
    
}
/**
 *  Description 停止 加载 网络请求指示视图
 */
-(void)stopLoadingView
{
    
    if (self.MRequestHelper.YNetworkRequestCount == 0)
    {
        [KGProgressHUDManager dismiss];
        
    }
    
}

/**
 *  Description   请求成功
 *
 *  @param requestTag 请求 tag
 *  @param jsonDic
 */
-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    KGWEAKOBJECT(weakSelf);
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingOrderDetailNetworkBack:state];
            }];
            
            
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
            
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                
            }];
        }
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                
            }];
        }
            break;
        case YZNETWORKVERIFICATIONFOU:
        {
            
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
               
            }];
        }
            break;
        case YZNETWORKVERIFICATIONFIF:
        {
            
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                
            }];
        }
            break;
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
            
            [self CreateloadFailView];
            
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
            //            [[iToast makeText:[jsonDic valueForKey:@"message"]]show];
            [self CreateloadFailView];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)CreateloadFailView
{
    if (_MVloadFailView == nil)
    {
        KGWEAKOBJECT(weakSelf);
        _MVloadFailView=   [[KGLoadFailView  alloc] initWithSuperView:self.view frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageName:nil WithBlock:^(id object) {
            [weakSelf.MRequestHelper transmitsAllFailRequest];
        }];
        _MVloadFailView.backgroundColor = self.view.backgroundColor;
    }
    
    
}
-(void)ProcessingOrderDetailNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
          
            [self.MVTableView reloadData];
            
            
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
            [self CreateloadFailView];
        }
            break;
        case YZPROCESSINGDATANULL:
        {
           
            
        }
            break;
            
            
            
        default:
            break;
    }

}
-(void)removeFailView
{
    if (_MVloadFailView)
    {
        [_MVloadFailView dissmissMyself];
        _MVloadFailView = nil;
    }
   
}
#pragma mark
#pragma mark   tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 4;
    return count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section) {
        case 0:
        {
            count = 1;
        }
            break;
        case 1:
        {
            count = _MVModel.KDDetailModel.KDOrderWaresArr.count;
        }
            break;
        case 2:
        {
            count = 1;

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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGBaseTableViewCell  * cell = nil;
    switch (indexPath.section)
    {
        case 0:
        {
             static NSString * titleCell =@"OrderTitleCell";
             cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
            if (cell == nil)
            {
                cell =[[KGOrderDetailTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell];
                
            }
            [cell updateCell:_MVModel.KDDetailModel];
            
        }
            break;
        case 1:
        {
            static NSString * productCell=@"orderProductCell";
            cell = [tableView dequeueReusableCellWithIdentifier:productCell];
            if (cell == nil)
            {
                cell =[[KGOrderProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCell];
                
            }
             [cell updateCell:_MVModel.KDDetailModel.KDOrderWaresArr[indexPath.row]];
            
        }
            break;
        case 2:
        {
            static NSString * infoCell=@"orderInfoCell";
             cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
            if (cell == nil)
            {
                cell =[[KGOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCell];
                
            }
            [cell updateCell:_MVModel.KDDetailModel];
         
        }
            break;
        case 3:
        {
            static NSString * userInfoCell=@"userInfoCell";
            cell = [tableView dequeueReusableCellWithIdentifier:userInfoCell];
            if (cell == nil)
            {
                cell =[[KGOrderUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userInfoCell];
                
            }
            [cell updateCell:_MVModel.KDDetailModel];
        
        }
            break;
        default:
            break;
    }
    
         return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor=LFBNavigationHomeSearchColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = 0;
    switch (indexPath.section) {
        case 0:
        {
            count = 128;
        }
            break;
        case 1:
        {
            count = 115;
        }
            break;
        case 2:
        {
            count = 80;
            
        }
            break;
        case 3:
        {
            count = 110;
            
        }
            break;
        default:
            
            break;
    }
    return count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 10;
}
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    
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

#pragma mark 等待支付
@interface KGWillPayOrderDetalVCTR()
@property (nonatomic,retain)UIButton   *   MVPayButton;
@property (nonatomic,retain)UIButton   *   MVDelButton;
@end
@implementation KGWillPayOrderDetalVCTR
-(void)initData
{
    [super initData];
    self.MVModel.KDTypeMessage =@"等待买家付款";

}

-(void)createDownView
{
    [super createDownView];
    [self.KVDownView addSubview:self.MVPayButton];
    [self.KVDownView addSubview:self.MVDelButton];
}

-(UIButton *)MVPayButton
{
    if (_MVPayButton == nil)
    {
        _MVPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVPayButton setTitle:@"立即付款" forState:UIControlStateNormal];
        _MVPayButton.frame = CGRectMake(self.KVDownView.v_width -10-74, 11, 74, 28);
        _MVPayButton.backgroundColor = CommonlyUsedBtnColor;
        [_MVPayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _MVPayButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVPayButton.layer.masksToBounds = YES;
        _MVPayButton.layer.cornerRadius  = 2.5f;
        [_MVPayButton addTarget:self action:@selector(payCallBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVPayButton;
}

-(UIButton *)MVDelButton
{
    if (_MVDelButton == nil)
    {
        _MVDelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVDelButton setTitle:@"删除订单" forState:UIControlStateNormal];
        _MVDelButton.frame = CGRectMake(self.KVDownView.v_width -10-74*2-15, 11, 74, 28);
        
        [_MVDelButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        _MVDelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVDelButton.layer.masksToBounds = YES;
        _MVDelButton.layer.cornerRadius  = 2.5f;
        _MVDelButton.layer.borderWidth   = 0.5f;
        _MVDelButton.layer.borderColor   = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;
        [_MVDelButton addTarget:self action:@selector(delCallback) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVDelButton;
}

-(void)payCallBack
{
    NSString  *  orederId    = self.MVModel.KDDetailModel.KDOrderId;
    NSString  *  orderAmount = self.MVModel.KDDetailModel.KDOrderAmount;
    KGPaymentMethodVCTR * vctr = [[KGPaymentMethodVCTR alloc]init];
    vctr.KDOrderId   = orederId;
    vctr.KDOrderAmount= orderAmount;
    [self.navigationController pushViewController:vctr animated:YES];
}

-(void)delCallback
{
  
    KGDeleteOrderAlertView * alertView = [KGDeleteOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
    alertView.NTAlertDelegate = self;
    alertView.tag = 1;
    [alertView ShowView];
}

-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        [self.MRequestHelper beginRequestWithItem:self.MVModel.KDDeleteOrdersItem];
    }
    
}

-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestSuccess:requestItem withDic:jsonDic];
  
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        default:
            break;
    }
    
    
    
    
}

-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    [super pRequestFailure:requestItem withCode:failureCode];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            [[iToast makeText:@"操作失败！"]show];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestError:requestItem withDic:jsonDic];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            [[iToast makeText:@"操作失败！"]show];
        }
            break;
            
        default:
            break;
    }
    
}

@end
#pragma mark 等待发货
@interface KGWillSendOrderDetalVCTR()
@property (nonatomic,retain)UIButton   *   MVButton;
@end
@implementation KGWillSendOrderDetalVCTR
-(void)initData
{
    [super initData];
     self.MVModel.KDTypeMessage =@"买家已付款，待发货";
}

-(void)createDownView
{
    [super createDownView];
    [self.KVDownView addSubview:self.MVButton];
}

-(UIButton *)MVButton
{
    if (_MVButton == nil)
    {
        _MVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVButton setTitle:@"待收货" forState:UIControlStateNormal];
        _MVButton.frame = CGRectMake(self.KVDownView.v_width -10-74, 11, 74, 28);
        _MVButton.backgroundColor = [UIColor colorWithHexString:@"#ffaf01"];
        [_MVButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _MVButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVButton.layer.masksToBounds = YES;
        _MVButton.layer.cornerRadius  = 2.5f;
        [_MVButton addTarget:self action:@selector(btnCallBack) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _MVButton;
}

-(void)btnCallBack
{
    [[iToast makeText:@"  请耐心等待发货！"]showInWindowOfCustom:CGPointMake(self.view.v_width/2, self.view.v_height- 50)];
}
@end
#pragma mark 等待收货
@interface KGWillReciveOrderDetalVCTR()
@property (nonatomic,retain)UIButton   *   MVButton;
@end
@implementation KGWillReciveOrderDetalVCTR
-(void)initData
{
    [super initData];
     self.MVModel.KDTypeMessage =@"已发货";
}
-(void)createDownView
{
    [super createDownView];
    [self.KVDownView addSubview:self.MVButton];
}
-(UIButton *)MVButton
{
    if (_MVButton == nil)
    {
        _MVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVButton setTitle:@"确认收货" forState:UIControlStateNormal];
        _MVButton.frame = CGRectMake(self.KVDownView.v_width -10-74, 11, 74, 28);
        _MVButton.backgroundColor = CommonlyUsedBtnColor;
        [_MVButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _MVButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVButton.layer.masksToBounds = YES;
        _MVButton.layer.cornerRadius  = 2.5f;
        [_MVButton addTarget:self action:@selector(btnCallBack:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVButton;
}

-(void)resetMvBtnView
{
    if (_MVButton)
    {
      
        [_MVButton setTitle:@"删除订单" forState:UIControlStateNormal];
        _MVButton.backgroundColor = [UIColor clearColor];
        _MVButton.frame = CGRectMake(self.KVDownView.v_width -10-74, 11, 74, 28);
        [_MVButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _MVButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVButton.layer.masksToBounds = YES;
        _MVButton.layer.cornerRadius  = 2.5f;
        _MVButton.layer.borderWidth   = 0.5f;
        _MVButton.layer.borderColor   = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;
       
    }
}

-(void)btnCallBack:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"确认收货"])
    {
        
        KGReciveOrderAlertView * alertView = [KGReciveOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
        alertView.NTAlertDelegate = self;
        alertView.tag = 1;
        [alertView ShowView];
        
    }
    else
    {
        KGDeleteOrderAlertView * alertView = [KGDeleteOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
        alertView.NTAlertDelegate = self;
        alertView.tag = 2;
        
        [alertView ShowView];
    }
  
}
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    NTCustomAlertView * aletView = sender;
    switch (aletView.tag)
    {
        case 1:
        {
            if (tag == 0)
            {
                 [self.MRequestHelper beginRequestWithItem:self.MVModel.KDEnterOrdersItem];
            }
           
        }
            break;
        case 2:
        {
            if (tag == 0)
            {
                 [self.MRequestHelper beginRequestWithItem:self.MVModel.KDDeleteOrdersItem];
            }
            
        }
            break;
            
        default:
            break;
    }
}

-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestSuccess:requestItem withDic:jsonDic];
    
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
             [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case YZNETWORKVERIFICATIONSEV :
        {
            [self resetMvBtnView];
        }
        default:
            break;
    }
    
    
    
    
}

-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    [super pRequestFailure:requestItem withCode:failureCode];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            
        }
       
        case YZNETWORKVERIFICATIONSEV :
        {
            [[iToast makeText:@"操作失败！"]show];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestError:requestItem withDic:jsonDic];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            
        }
        case YZNETWORKVERIFICATIONSEV :
        {
            [[iToast makeText:@"操作失败！"]show];
        }
            break;
            
        default:
            break;
    }
    
}

@end
#pragma mark 已经完成

@interface KGOverOrderDetalVCTR()
@property (nonatomic,retain)UIButton   *   MVButton;
@end
@implementation KGOverOrderDetalVCTR
-(void)initData
{
    [super initData];
    self.MVModel.KDTypeMessage =@"已完成";
}
-(void)createDownView
{
    [super createDownView];
    [self.KVDownView addSubview:self.MVButton];
}
-(UIButton *)MVButton
{
    if (_MVButton == nil)
    {
        _MVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVButton setTitle:@"删除订单" forState:UIControlStateNormal];
        _MVButton.frame = CGRectMake(self.KVDownView.v_width -10-74, 11, 74, 28);
       
        [_MVButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        _MVButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVButton.layer.masksToBounds = YES;
        _MVButton.layer.cornerRadius  = 2.5f;
        _MVButton.layer.borderWidth   = 0.5f;
        _MVButton.layer.borderColor   = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;
        [_MVButton addTarget:self action:@selector(btnCallBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _MVButton;
}

-(void)btnCallBack
{
    
    KGDeleteOrderAlertView * alertView = [KGDeleteOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
    alertView.NTAlertDelegate = self;
  
    [alertView ShowView];
    
}

-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        [self.MRequestHelper beginRequestWithItem:self.MVModel.KDDeleteOrdersItem];
    }
}

-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestSuccess:requestItem withDic:jsonDic];
    
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
    
        default:
            break;
    }
    
    
    
    
}
-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    [super pRequestFailure:requestItem withCode:failureCode];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
             [[iToast makeText:@"操作失败！"]show];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super pRequestError:requestItem withDic:jsonDic];
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONSIX :
        {
            [[iToast makeText:@"操作失败！"]show];

        }
        break;
            
        default:
            break;
    }
    
}


@end
@implementation KGCancelOrderDetalVCTR
-(void)initData
{
    [super initData];
    self.MVModel.KDTypeMessage =@"订单已取消";
}
@end

@implementation KGInvalidOrderDetalVCTR
-(void)initData
{
    [super initData];
    self.MVModel.KDTypeMessage =@"无效订单";
}
@end
