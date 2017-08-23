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
@interface KGMyOrdersVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)KGMoreMenuView           * MVTopMenuView;
@property (nonatomic,retain)KGMyOrdersViewModel      * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@property (nonatomic,retain)KGNullDataView           * MVNullDataView;
@property (nonatomic,retain)KGLoadFailView           * MVloadFailView;
@end

@implementation KGMyOrdersVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
      self.KVTitleLabel.text = @"我的订单";
    [self initData];
    [self createTopMenuView];
    [self initloadRequestStart];
    // Do any additional setup after loading the view.
}
-(void)initData
{
    _MVModel = [[KGMyOrdersViewModel alloc]init];
}
-(void)createNoDataView
{
    
    if (_MVNullDataView == nil)
    {
        _MVNullDataView =[KGNullDataView initWithSuperView:self.view frame:CGRectMake(0, 40, ScreenWidth, self.view.v_height-40) imageName:@"noOreders" Click:NO];
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
        //        _MVNullDataView.contentLabel.backgroundColor = [UIColor redColor];
        //        _MVNullDataView.backgroundColor = [UIColor greenColor];
        
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
        _MVTopMenuView = [[KGMoreMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.v_width, 40) withMenuTitle:@[@"全部",@"支付成功",@"待支付",@"支付失败"]];
        _MVTopMenuView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _MVTopMenuView;
}

-(void)pSelectedView:(id)sender
{
    if (_MVTopMenuView == sender)
    {
        NSInteger index = _MVTopMenuView.YVSelectIndex;
    }
}


#pragma mark
#pragma mark ----  请求 ---
-(void)initloadRequestStart
{
    [self requestRegin];
}
-(void)requestRegin
{
    [self.MRequestHelper beginRequest:@[self.MVModel.KDOrdersRequestItem]];
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
    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
    
    if (![KGProgressHUDManager isVisible])
    {
        [KGProgressHUDManager showWithStatus:@"正在加载中"];
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
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            KGWEAKOBJECT(weakSelf);
            
            [self.MVModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
                [weakSelf ProcessingListNetworkBack:state ];
            }];
            
            
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
            
        }
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            
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
        _MVloadFailView=   [[KGLoadFailView  alloc] initWithSuperView:self.view frame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40) imageName:nil WithBlock:^(id object) {
            [weakSelf.MRequestHelper transmitsAllFailRequest];
        }];
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
//用于列表
-(void)ProcessingListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self removeNodataView];
//            [self.MVTableView reloadData];
            
            
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
