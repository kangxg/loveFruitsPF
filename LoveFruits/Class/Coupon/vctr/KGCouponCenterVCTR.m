//
//  KGCouponCenterVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/27.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponCenterVCTR.h"
#import "KGCouponCenterModel.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGLoadFailView.h"
#import "KGProgressHUDManager.h"
#import "KGCouponTalbleCell.h"
#import "KGNullDataView.h"
#import "YZRequestItem.h"
#import "GlobelDefine.h"
#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestHelpDelegate.h"
#import "KGCouponModel.h"
#import "iToast.h"
#import "KGAnimationView.h"
@interface KGCouponCenterVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)KGCouponCenterModel        * MVModel;
@property (nonatomic,retain)KGLoadFailView             * MVloadFailView;
@property (nonatomic,retain)UITableView                * MVTableView;
@property (nonatomic,retain)YZNetworkRequestHelper     * MRequestHelper;
@property (nonatomic,retain)YZNetworkRequestHelper     * MGetCouponRequestHelper;
@property (nonatomic,retain)KGNullDataView             * MVNullDataView;
@property (nonatomic,retain)KGAnimationView            * MVLoadingView;
@end

@implementation KGCouponCenterVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.KVTitleLabel.text = @"优惠券中心";
    [self initData];
     [self.view addSubview:self.MVTableView];
     [self initloadRequest];
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
        _MVLoadingView = [[KGAnimationView  alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 64)];
        
    }
    return _MVLoadingView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeLoadingView];
}
-(void)initData
{
    _MVModel = [[KGCouponCenterModel alloc]init];
}
-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-40-NavigationH) style:UITableViewStylePlain];
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
        _MVNullDataView =[KGNullDataView initWithSuperView:self.view frame:CGRectMake(0, NavigationH, ScreenWidth, self.MVTableView.v_height) imageName:@"noCoupon" Click:NO];
        _MVNullDataView.nvllDataImage.frame = CGRectMake(_MVNullDataView.nvllDataImage.frame.origin.x, 155,_MVNullDataView.nvllDataImage.frame.size.width , _MVNullDataView.nvllDataImage.frame.size.height);
        [_MVNullDataView setShowContent:@"您暂时没有可用的优惠券"];
        
        _MVNullDataView.contentLabel.frame  = CGRectMake(_MVNullDataView.contentLabel.frame.origin.x,_MVNullDataView.nvllDataImage.v_bottom+17,_MVNullDataView.contentLabel.frame.size.width , 80);
        
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _MVModel.YDCouponModelArr.count;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * resuse=@"CouponCenterCell";
    KGCouponCenterTalbleCell * cell  = [tableView dequeueReusableCellWithIdentifier:resuse];
    if (cell == nil)
    {
        cell =[[KGCouponCenterTalbleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse];
        
    }
    [cell updateCell:self.MVModel.YDCouponModelArr[indexPath.section]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * dic = _MVModel.KDGetCouponRequestItem.YRequestDic;
    KGHomeCouponCenterModel * model = _MVModel.YDCouponModelArr[indexPath.section];
    
    [dic setValue:model.couponId forKey:@"coupon_id"];
    [self.MGetCouponRequestHelper beginRequestWithItem:_MVModel.KDGetCouponRequestItem];
    
}


-(YZNetworkRequestHelper *)MRequestHelper
{
    if (_MRequestHelper == nil)
    {
        _MRequestHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEGETREQUEST];
        _MRequestHelper.YNetworkRequestDelegate = self;
    }
    
    return _MRequestHelper;
}
-(YZNetworkRequestHelper *)MGetCouponRequestHelper
{
    if (_MGetCouponRequestHelper == nil)
    {
        _MGetCouponRequestHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEPOSTREQUEST];
        _MGetCouponRequestHelper.YNetworkRequestDelegate = self;
    }
    
    return _MGetCouponRequestHelper;
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
        case  YZNETWORKVERIFICATIONFIR :
        {
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingNetworkBack:state witiType:type];
            }];
        }
            break;
        case  YZNETWORKVERIFICATIONSEC :
        {
            [self.MVModel putJsonDataBackMessage:jsonDic withBlock:^(YZProcessingDataState state, NSString *message) {
                 [weakSelf ProcessingGetCouponNetworkBack:state message:message];
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
        case  YZNETWORKVERIFICATIONSEC :
        {
            [[iToast makeText:@"兑换失败！"]show];
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
        case  YZNETWORKVERIFICATIONSEC :
        {
            [[iToast makeText:@"兑换失败！"]show];
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
//用于列表t
-(void)ProcessingNetworkBack:(YZProcessingDataState )state witiType:(NSInteger)type
{
    if (type== YZNETWORKVERIFICATIONFIR)
    {
        [self ProcessingListNetworkBack:state];
    }
  
}

-(void)ProcessingListNetworkBack:(YZProcessingDataState )state
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

-(void)ProcessingGetCouponNetworkBack:(YZProcessingDataState )state  message:(NSString *)msg
{
    
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [[iToast makeText:msg]show];
            
            
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
            break;
        case YZPROCESSINGDATANULL:
        {
            [[iToast makeText:msg]show];

            
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

-(void)initloadRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDCouponRequestItem];
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
