//
//  KGMyOrdersVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMyOrdersVCTR.h"
#import "KGMoreMenuView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGMyOrdersViewModel.h"
#import "KGNullDataView.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestHelpDelegate.h"
#import "KGProgressHUDManager.h"
#import "KGLoadFailView.h"
#import "KGMyOrderTableCell.h"
#import "KGOrderDetalVCTR.h"
#import "KGOrderAlertView.h"
#import "iToast.h"
#import "KGPaymentMethodVCTR.h"
#import "KGLoginVCTR.h"
#import "KGAnimationView.h"

@interface KGMyOrdersVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate,KGTableCellDelegate ,NTAlertViewDelegate>
@property (nonatomic,retain)KGMoreMenuView           * MVTopMenuView;
@property (nonatomic,retain)KGMyOrdersViewModel      * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@property (nonatomic,retain)KGNullDataView           * MVNullDataView;
@property (nonatomic,retain)KGLoadFailView           * MVloadFailView;
@property (nonatomic,retain)UITableView              * MVTableView;
@property (nonatomic,retain)KGAnimationView          * MVLoadingView;
@end

@implementation KGMyOrdersVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
      self.KVTitleLabel.text = @"我的订单";
    
    [self initData];
    [self createTopMenuView];
    [self.view addSubview:self.MVTableView];
    
    // Do any additional setup after loading the view.
}
-(void)backBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initRequestNetwork];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeLoadingView];
}
-(void)initData
{
    _MVModel = [[KGMyOrdersViewModel alloc]init];
    self.view.backgroundColor=LFBNavigationHomeSearchColor;
}

-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 40 ,ScreenWidth,  ScreenHeight-40-NavigationH) style:UITableViewStylePlain];
        _MVTableView.backgroundColor=LFBNavigationHomeSearchColor;
        _MVTableView.delegate=self;
        _MVTableView.dataSource=self;
        _MVTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _MVTableView.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
        
        
        
    }
    return _MVTableView;
}

-(void)createNoDataView
{
    
    if (_MVNullDataView == nil)
    {
        _MVNullDataView =[KGNullDataView initWithSuperView:self.view frame:CGRectMake(0, 40, ScreenWidth, self.view.v_height-40) imageName:@"无订单" Click:NO];
        _MVNullDataView.nvllDataImage.frame = CGRectMake(_MVNullDataView.nvllDataImage.frame.origin.x, 105,_MVNullDataView.nvllDataImage.frame.size.width , _MVNullDataView.nvllDataImage.frame.size.height);
        [_MVNullDataView setShowContent:@"您还没有相关的订单"];
        
      
        _MVNullDataView.contentLabel.frame  = CGRectMake(_MVNullDataView.contentLabel.frame.origin.x,_MVNullDataView.nvllDataImage.v_bottom+17,_MVNullDataView.contentLabel.frame.size.width , 20);
        UILabel * lab = [[UILabel alloc]init];
        lab.text = @"可以去看看有哪些想买的";
        lab.textColor = [UIColor colorWithHexString:@"#999999"];
        lab.font = [UIFont systemFontOfSize:12.0f];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.frame = CGRectMake(_MVNullDataView.contentLabel.v_x, _MVNullDataView.contentLabel.v_bottom +15, _MVNullDataView.contentLabel.v_width, _MVNullDataView.contentLabel.v_height);
        [_MVNullDataView addSubview:lab];
        _MVNullDataView.backgroundColor = self.view.backgroundColor;
    }
    
}
-(void)removeNodataView
{
    
    if (_MVNullDataView)
    {
        [_MVNullDataView removeFromSuperview];
        _MVNullDataView = nil;
    }
}

-(void)createTopMenuView
{
    [self.view addSubview:self.MVTopMenuView];
}

-(KGMoreMenuView *)MVTopMenuView
{
    if (_MVTopMenuView == nil)
    {
        _MVTopMenuView = [[KGMoreMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.v_width, 40) withMenuTitle:@[@"全部",@"待支付",@"待发货",@"待收货",@"完成"]];
        _MVTopMenuView.KVDelegate = self;
        _MVTopMenuView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _MVTopMenuView;
}

-(void)pSelectedView:(id)sender
{
    if (_MVTopMenuView == sender)
    {
        [self initRequestNetwork];
    }
}

-(void)initRequestNetwork
{
    NSInteger index = _MVTopMenuView.YVSelectIndex;
    switch (index) {
        case 0:
        {
            [self requestGetallRequest];
        }
            break;
        case 1:
        {
            [self requestWillPayRequest];
        }
            break;
        case 2:
        {
            [self requestWillSendRequest];
        }
            break;
        case 3:
        {
            [self requestWillReciveRequest];
        }
            break;
        case 4:
        {
            [self requestOverRequest];
        }
            break;
        default:
            break;
    }

}

#pragma mark
#pragma mark ----  请求 ---
-(void)initloadRequestStart
{
    [self requestGetallRequest];
}
-(void)requestGetallRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDGetAllOrdersItem];
}

-(void)requestWillPayRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDWillPayOrdersItem];
}

-(void)requestWillSendRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDWillSendOrdersItem];
}

-(void)requestWillReciveRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDWillReciveOrdersItem];
}

-(void)requestOverRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDOverOrdersItem];
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
    
    if (self.MRequestHelper.YNetworkRequestCount == 0)
    {
//        [KGProgressHUDManager dismiss];
        [self removeLoadingView];
        
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
                [weakSelf ProcessingAllListNetworkBack:state];
            }];
          
            
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
           
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingWillPayListNetworkBack:state];
            }];
        }
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
        
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingWillSendListNetworkBack:state];
            }];
        }
            break;
        case YZNETWORKVERIFICATIONFOU:
        {
        
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingWillReciveListNetworkBack:state];
            }];
        }
            break;
        case YZNETWORKVERIFICATIONFIF:
        {
           
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingOverListNetworkBack:state];
            }];
        }
            break;
        case YZNETWORKVERIFICATIONSIX :
        {
            
        }
        case YZNETWORKVERIFICATIONSEV :
        {
            
        }
        case YZNETWORKVERIFICATIONEIG :
        {
            [self initRequestNetwork];
        }
            break;
        default:
            break;
    }
    
    
    
    
}
-(void)pushLogView
{
    KGLoginVCTR * Vctr = [[ KGLoginVCTR alloc]init];
    [self.navigationController pushViewController:Vctr animated:YES];
}
-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    if ([failureCode isEqualToString:@"Request failed: unauthorized (401)"] )
    {
        [self pushLogView];
        return;
    }
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            [self CreateloadFailView];
            
        }
            break;
        case YZNETWORKVERIFICATIONSIX :
        {
            
        }
        case YZNETWORKVERIFICATIONSEV :
        {
            
        }
        case YZNETWORKVERIFICATIONEIG :
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
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            //            [[iToast makeText:[jsonDic valueForKey:@"message"]]show];
            [self CreateloadFailView];
        }
            break;
        case YZNETWORKVERIFICATIONSIX :
        {
            
        }
        case YZNETWORKVERIFICATIONSEV :
        {
            
        }
        case YZNETWORKVERIFICATIONEIG :
        {
            [[iToast makeText:@"操作失败！"]show];
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
        _MVloadFailView=   [[KGLoadFailView  alloc] initWithSuperView:self.view frame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40) imageName:nil WithBlock:^(id object) {
            [weakSelf.MRequestHelper transmitsAllFailRequest];
        }];
        self.MVTableView.hidden = YES;
    }
    
    
}

-(void)removeFailView
{
    if (_MVloadFailView)
    {
        [_MVloadFailView dissmissMyself];
        _MVloadFailView = nil;
    }
    self.MVTableView.hidden = false;
}
//用于列表
-(void)ProcessingAllListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}

//用于列表
-(void)ProcessingWillPayListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}

//用于列表
-(void)ProcessingWillSendListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}

//用于列表
-(void)ProcessingWillReciveListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}

//用于列表
-(void)ProcessingOverListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}
#pragma mark
#pragma mark   tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    switch (_MVTopMenuView.YVSelectIndex)
    {
        case 0:
        {
            count = _MVModel.KDAllOrdersArr.count;
        }
            break;
        case 1:
        {
            count = _MVModel.KDWillPayArr.count;
        }
            break;
        case 2:
        {
            count = _MVModel.KDWillSendArr.count;
        }
            break;
        case 3:
        {
            count = _MVModel.KDWillReciveArr.count;
        }
            break;
        case 4:
        {
            count = _MVModel.KDOverArr.count;
        }
            break;
        default:
            break;
    }
    return count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGMyOrderTableCell * cell =nil;
  
  
    
    NSInteger index =_MVTopMenuView.YVSelectIndex;
    switch (index)
    {
        case 0:
        {
            KGOrderModel * model =  _MVModel.KDAllOrdersArr[indexPath.section];
            cell = [self getTableCell:tableView withType:model.orderStatus.integerValue ];
            [cell updateCell:_MVModel.KDAllOrdersArr[indexPath.section]];
            
        }
            break;
        case 1:
        {
             cell = [self getTableCell:tableView withType:0];
            [cell updateCell:_MVModel.KDWillPayArr[indexPath.section]];
        }
            break;
        case 2:
        {
             cell = [self getTableCell:tableView withType:1];
            [cell updateCell:_MVModel.KDWillSendArr[indexPath.section]];
        }
            break;
        case 3:
        {
             cell = [self getTableCell:tableView withType:2];
            [cell updateCell:_MVModel.KDWillReciveArr[indexPath.section]];
        }
            break;
        case 4:
        {
           cell = [self getTableCell:tableView withType:3];
          [cell updateCell:_MVModel.KDOverArr[indexPath.section]];
        }
            break;
       
        default:
            break;
    }
//
    cell.KVDelegate = self;
    return cell;
    
}
-(KGMyOrderTableCell *)getTableCell:(UITableView *)tableView withType:(NSInteger )type

{
    KGMyOrderTableCell * cell =nil;
    switch (type)
    {
        case -1:
        {
            static NSString * cancelCell=@"cancelOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cancelCell];
            if (cell == nil)
            {
                cell =[[KGCancelOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cancelCell];
                
            }

        }
            break;
        case -2:
        {
            static NSString * invalidCell=@"invalidOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:invalidCell];
            if (cell == nil)
            {
                cell =[[KGInvalidOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invalidCell];
                
            }

        }
            break;
        case 0:
        {
            static NSString * OverCouponCell=@"willpayOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:OverCouponCell];
            if (cell == nil)
            {
                cell =[[KGWillPayOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OverCouponCell];
                
            }
        }
            break;
        case 1:
        {
            static NSString * UseCouponCell=@"willSendOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:UseCouponCell];
            if (cell == nil)
            {
                cell =[[KGWillSendOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UseCouponCell];
                
            }
           
        }
            break;
        case 2:
        {
            static NSString * UseCouponCell=@"willReciveOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:UseCouponCell];
            if (cell == nil)
            {
                cell =[[KGWillReciveOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UseCouponCell];
                
            }
           
        }
            break;
        case 3:
        {
            static NSString * UseCouponCell=@"overOrdersCell";
            cell = [tableView dequeueReusableCellWithIdentifier:UseCouponCell];
            if (cell == nil)
            {
                cell =[[KGOverOrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UseCouponCell];
                
            }
        }
            break;
            
        default:
            break;
    }
    //
    
    return cell;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor=LFBNavigationHomeSearchColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 192;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGOrderModel  * model = nil;
    switch (_MVTopMenuView.YVSelectIndex) {
        case 0:
        {
            model = _MVModel.KDAllOrdersArr[indexPath.section];
            KGOrderDetalVCTR * vctr = [self getOrderDetailVCTR:model.orderStatus.integerValue];
            vctr.KVOrderId = model.orderId;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 1:
        {
            model = _MVModel.KDWillPayArr[indexPath.section];

            KGOrderDetalVCTR * vctr = [self getOrderDetailVCTR:0];
             vctr.KVOrderId = model.orderId;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 2:
        {
             model = _MVModel.KDWillSendArr[indexPath.section];
            KGOrderDetalVCTR * vctr = [self getOrderDetailVCTR:1];
             vctr.KVOrderId = model.orderId;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 3:
        {
             model = _MVModel.KDWillReciveArr[indexPath.section];
            KGOrderDetalVCTR * vctr = [self getOrderDetailVCTR:2];
             vctr.KVOrderId = model.orderId;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 4:
        {
             model = _MVModel.KDOverArr[indexPath.section];
            KGOrderDetalVCTR * vctr = [self getOrderDetailVCTR:3];
             vctr.KVOrderId = model.orderId;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        default:
            break;
    }
}

-(KGOrderDetalVCTR *)getOrderDetailVCTR:(NSInteger )type
{
    KGOrderDetalVCTR *  vctr = nil;
    switch (type)
    {
        case 0:
        {
            vctr = [[KGWillPayOrderDetalVCTR alloc]init];
        }
            break;
        case 1:
        {
             vctr = [[KGWillSendOrderDetalVCTR alloc]init];
        }
            break;
        case 2:
        {
             vctr = [[KGWillReciveOrderDetalVCTR alloc]init];
        }
            break;
        case 3:
        {
             vctr = [[KGOverOrderDetalVCTR alloc]init];
        }
            break;
        case -1:
        {
             vctr = [[KGCancelOrderDetalVCTR alloc]init];
        }
            break;
        case -2:
        {
             vctr = [[KGInvalidOrderDetalVCTR alloc]init];
        }
            break;
        default:
            break;
    }
    return vctr;
}

-(void)pClickViewOperation:(id)sender operation:(KGFunctionOperation)operation withInfo:(NSDictionary *)info
{
    switch (operation)
    {
        case KGOPRERATIODELETE:
        {
            //删除订单
            NSString  *  orederId = [info valueForKey:@"orderId"];
            KGDeleteOrderAlertView * alertView = [KGDeleteOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
            alertView.NTAlertDelegate = self;
            alertView.tag = operation;
             alertView.KVOrderId = orederId;
            [alertView ShowView];
        }
            break;
        case KGOPERATIONENTER:
        {
            //确认收货
            NSString  *  orederId = [info valueForKey:@"orderId"];
            KGReciveOrderAlertView * alertView = [KGReciveOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
            alertView.NTAlertDelegate = self;
            alertView.tag = operation;
             alertView.KVOrderId = orederId;
            [alertView ShowView];
        }
            break;
        case  KGOPERATIONCANNEL:
        {
            //取消订单
          
            NSString  *  orederId = [info valueForKey:@"orderId"];
            KGCannelOrderAlertView * alertView = [KGCannelOrderAlertView createAlertView:EN_NTAlertViewStyleCorner ];
            alertView.NTAlertDelegate = self;
            alertView.KVOrderId = orederId;
            alertView.tag = operation;
            [alertView ShowView];
        }
            break;
        case KGOPERATIONPAY:
        {
            //支付
            NSString  *  orederId    = [info valueForKey:@"orderId"];
            NSString  *  orderAmount = [info valueForKey:@"orderAmount"];
            KGPaymentMethodVCTR * vctr = [[KGPaymentMethodVCTR alloc]init];
            vctr.KDOrderId   = orederId;
            vctr.KDOrderAmount= orderAmount;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        default:
            break;
    }
}


-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
     KGOrderAlertView * alertView = sender;
    switch (alertView.tag)
    {
        case KGOPERATIONCANNEL:
        {
            //取消订单
            if (tag == 0)
            {
                
                NSMutableDictionary  * dic = _MVModel.KDCannelOrdersItem.YRequestDic;
                [dic setValue:alertView.KVOrderId forKey:@"order_id"];
                [self.MRequestHelper beginRequestWithItem:_MVModel.KDCannelOrdersItem];
            }
        }
            break;
        case KGOPERATIONENTER:
        {
            //确认收货
            
            if (tag == 0)
            {
                NSMutableDictionary  * dic = _MVModel.KDEnterOrdersItem.YRequestDic;
                [dic setValue:alertView.KVOrderId forKey:@"order_id"];
                [self.MRequestHelper beginRequestWithItem:_MVModel.KDEnterOrdersItem];
            }
        }
            break;
        case KGOPRERATIODELETE:
        {
            //删除订单
        
            if (tag == 0)
            {
                NSMutableDictionary  * dic = _MVModel.KDDeleteOrdersItem.YRequestDic;
                [dic setValue:alertView.KVOrderId forKey:@"order_id"];
                [self.MRequestHelper beginRequestWithItem:_MVModel.KDDeleteOrdersItem];
            }
        }
            break;
        default:
            break;
    }
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
