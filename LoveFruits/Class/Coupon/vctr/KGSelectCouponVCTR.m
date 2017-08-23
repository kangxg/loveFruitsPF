//
//  KGSelectCouponVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSelectCouponVCTR.h"
#import "KGNullDataView.h"
#import "YZRequestItem.h"
#import "GlobelDefine.h"
#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestHelpDelegate.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGLoadFailView.h"
#import "KGProgressHUDManager.h"
#import "KGCouponTalbleCell.h"
#import "KGSelectCouponViewModel.h"
#import "iToast.h"
#import "KGCouponModel.h"
#import "KGAnimationView.h"
@interface KGSelectCouponVCTR ()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)KGSelectCouponViewModel    * MVModel;
@property (nonatomic,retain)KGLoadFailView             * MVloadFailView;
@property (nonatomic,retain)UITableView                * MVTableView;
@property (nonatomic,retain)YZNetworkRequestHelper     * MRequestHelper;
@property (nonatomic,retain)KGNullDataView             * MVNullDataView;
@property (nonatomic,retain)UIButton                   * MVEnterBtn;
@property (nonatomic,retain)KGAnimationView          * MVLoadingView;
@end

@implementation KGSelectCouponVCTR
-(id)init:(KGSelectCouponBlock)block
{
    if (self = [super init])
    {
        _KVSelectBlock = block;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"选择优惠券";
    [self initData];
    [self creatNavView];
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
        _MVLoadingView = [[KGAnimationView  alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
        
    }
    return _MVLoadingView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeLoadingView];
}

-(void)creatNavView
{
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font      = [UIFont systemFontOfSize:12.0f];
    [rightBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];

    [rightBtn addTarget:self action:@selector(navBtnCallback) forControlEvents:UIControlEventTouchUpInside];
    _MVEnterBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    _MVEnterBtn.hidden = YES;
//    _MVEnterBtn.backgroundColor= [UIColor redColor];
    
}

-(void)navBtnCallback
{
    if (_KVSelectBlock)
    {
        _KVSelectBlock(_MVModel.KDSelectedCouponDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initData
{
    _MVModel = [[KGSelectCouponViewModel alloc]init];
}

-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-NavigationH) style:UITableViewStylePlain];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor=LFBNavigationHomeSearchColor;
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * resuse=@"CouponSelectCell";
    KGCouponSelectTalbleCell * cell  = [tableView dequeueReusableCellWithIdentifier:resuse];
    if (cell == nil)
    {
        cell =[[KGCouponSelectTalbleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse];
              
    }
    [cell updateCell:self.MVModel.YDCouponModelArr[indexPath.section]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGCouponModel  * model = self.MVModel.YDCouponModelArr[indexPath.section];
    [_MVModel resetSelectedCoupon:model];
    _MVEnterBtn.hidden = false;
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    [self.MVModel putJsonData:jsonDic  withBlock:^(YZProcessingDataState state) {
        [weakSelf ProcessingListNetworkBack:state ];
    }];
    
    
    
    
    
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
            [[iToast makeText:[jsonDic valueForKey:@"message"]]show];
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
            [self createNoDataView];
            
        }
            break;
            
            
            
        default:
            break;
    }
    
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
