//
//  KGCouponVCTRViewController.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponVCTR.h"
#import "KGCouponViewModel.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestHelpDelegate.h"
#import "KGMoreMenuView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGLoadFailView.h"
#import "KGProgressHUDManager.h"
#import "KGCouponTalbleCell.h"
#import "KGNullDataView.h"
#import "KGAnimationView.h"
@interface KGCouponVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)KGCouponViewModel        * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@property (nonatomic,retain)KGMoreMenuView           * MVTopMenuView;
@property (nonatomic,retain)KGLoadFailView           * MVloadFailView;
@property (nonatomic,retain)UITableView              * MVTableView;
@property (nonatomic,retain)KGNullDataView           * MVNullDataView;
@property (nonatomic,retain)KGAnimationView          * MVLoadingView;
@end

@implementation KGCouponVCTR
@synthesize MVModel = _MVModel;
@synthesize   MVNullDataView   = _MVNullDataView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"我的优惠券";
    [self initData];
    [self createTopMenuView];
    [self.view addSubview:self.MVTableView];
    [self initloadUnuseRequestStart];
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

-(void)initData
{
    _MVModel = [[KGCouponViewModel alloc]init];
}

-(void)createNoDataView
{
    
    if (_MVNullDataView == nil)
    {
        _MVNullDataView =[KGNullDataView initWithSuperView:self.view frame:CGRectMake(0, NavigationH, ScreenWidth, self.MVTableView.v_height) imageName:@"noCoupon" Click:NO];
        _MVNullDataView.nvllDataImage.frame = CGRectMake(_MVNullDataView.nvllDataImage.frame.origin.x, 155,_MVNullDataView.nvllDataImage.frame.size.width , _MVNullDataView.nvllDataImage.frame.size.height);
       
        
        _MVNullDataView.contentLabel.frame  = CGRectMake(_MVNullDataView.contentLabel.frame.origin.x,_MVNullDataView.nvllDataImage.v_bottom+17,_MVNullDataView.contentLabel.frame.size.width , 80);
        
        //        _MVNullDataView.contentLabel.backgroundColor = [UIColor redColor];
        //        _MVNullDataView.backgroundColor = [UIColor greenColor];
        
    }
    NSInteger index =_MVTopMenuView.YVSelectIndex;
    switch (index)
    {
        case 0:
        {
            [_MVNullDataView setShowContent:@"您暂时没有可用的优惠券"];
        }
            break;
      
        default:
        {
            [_MVNullDataView setShowContent:@"这里没有优惠券哦"];
        }
            break;
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
        _MVTopMenuView = [[KGMoreMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.v_width, 40) withMenuTitle:@[@"未使用",@"已过期",@"已使用"]];
        _MVTopMenuView.KVDelegate = self;
        _MVTopMenuView.backgroundColor = [UIColor whiteColor];
        
    }
    return _MVTopMenuView;
}

-(void)pSelectedView:(id)sender
{
    if (_MVTopMenuView == sender)
    {
        NSInteger index = _MVTopMenuView.YVSelectIndex;
        switch (index) {
            case 0:
            {
                if (!_MVModel.YDUnUseArr.count)
                {
                    [self initloadUnuseRequestStart];
                }
                else
                {
                    [self removeFailView];
                    [self removeNodataView];
                    [self.MVTableView reloadData];
                }
                
            }
                break;
            case 1:
            {
                if (!_MVModel.YDUsedArr.count) {
                    [self initLoadUsedRequest];
                }
                else
                {
                    [self removeFailView];
                    [self removeNodataView];
                    [self.MVTableView reloadData];
                }
            }
                break;
            case 2:
            {
                if (!_MVModel.YDExpiredArr.count) {
                    [self initLoadExpiredRequest];
                }
                else
                {
                    [self removeFailView];
                    [self removeNodataView];
                    [self.MVTableView reloadData];
                }
            }
                break;
            default:
                break;
        }
      
        
    }
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    switch (_MVTopMenuView.YVSelectIndex)
    {
        case 0:
        {
            count = _MVModel.YDUnUseArr.count;
        }
            break;
        case 1:
        {
            count = _MVModel.YDExpiredArr.count;
        }
            break;
        case 2:
        {
            count = _MVModel.YDUsedArr.count;
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
    KGCouponTalbleCell * cell =nil;
    NSInteger index =_MVTopMenuView.YVSelectIndex;
    switch (index)
    {
        case 0:
        {
            static NSString * resuse=@"unUseCouponCell";
            cell = [tableView dequeueReusableCellWithIdentifier:resuse];
            if (cell == nil)
            {
                cell =[[KGUnUseCouponTalbleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse];

            }
            [cell updateCell:self.MVModel.YDUnUseArr[indexPath.section]];
        }
            break;
        case 1:
        {
            static NSString * OverCouponCell=@"OverCouponCell";
            cell = [tableView dequeueReusableCellWithIdentifier:OverCouponCell];
            if (cell == nil)
            {
                cell =[[KGExpiredCouponTalbleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OverCouponCell];
                
            }
            [cell updateCell:self.MVModel.YDExpiredArr[indexPath.section]];
        }
            break;
        case 2:
        {
            static NSString * UseCouponCell=@"UseCouponCell";
            cell = [tableView dequeueReusableCellWithIdentifier:UseCouponCell];
            if (cell == nil)
            {
                cell =[[KGUseCouponTalbleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UseCouponCell];
                
            }
            [cell updateCell:self.MVModel.YDUsedArr[indexPath.section]];
        }
            break;
        default:
            break;
    }
   
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (_MVTopMenuView.YVSelectIndex)
    {
        case 0:
        {
            if (_MVModel.YDUnUseArr.count)
            {
                count = 10;
            }
        }
            break;
        case 1:
        {
            if (_MVModel.YDExpiredArr.count) {
                count = 10;
            }
        }
            break;
        case 2:
        {
            if (_MVModel.YDUsedArr.count) {
                count = 10;
            }
        }
            break;
        default:
            break;
    }
    return count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark
#pragma mark ----  请求 ---
-(void)initloadUnuseRequestStart
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDCouponUnuseRequestItem];
}

-(void)initLoadUsedRequest
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDCouponUsedRequestItem];
    
}

-(void)initLoadExpiredRequest
{
     [self.MRequestHelper beginRequestWithItem:self.MVModel.KDCouponExpiredRequestItem];
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
    [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
        [weakSelf ProcessingListNetworkBack:state ];
    }];
   

//    switch (requestItem.YRequestTag)
//    {
//        case YZNETWORKVERIFICATIONFIR:
//        {
//            KGWEAKOBJECT(weakSelf);
//            [self.MVModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
//                 [weakSelf ProcessingListNetworkBack:state ];
//            }];
//
//            
//        }
//            
//            break;
//        case YZNETWORKVERIFICATIONSEC:
//        {
//           
//        }
//            break;
//        case YZNETWORKVERIFICATIONTHI:
//        {
//           
//        }
//            break;
//        default:
//            break;
//    }
//    
    
    
    
}

-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            [self.MVTableView reloadData];
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
            [self.MVTableView reloadData];
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
