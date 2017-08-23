//
//  KGProductsViewController.m
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductsViewController.h"
#import "LFBTableView.h"
#import "KGSupermarket.h"
#import "GlobelDefine.h"
#import "KGSupermarketHeadView.h"
#import "KGRefreshHeader.h"
#import "KGHomeTableHeadViewDelegate.h"
#import "UIView+Extension.h"
#import "KGProductCell.h"
#import "KGMainTabBarController.h"
#import "KGProductsModel.h"
#import "YZRequestItem.h"
#import "iToast.h"
#import "KGProgressHUDManager.h"
#import "YZNetworkRequestHelper.h"
#import "KGGoodsModel.h"
#import "KGRefreshFooter.h"
#import "MJRefreshNormalHeader.h"
@interface KGProductsViewController()<UITableViewDataSource,UITableViewDelegate,KGHomeTableHeadViewDelegate,YZNetworkRequestHelpDelegate>
@property (nonatomic,assign)CGFloat                    MLastOffsetY;
@property (nonatomic,copy)NSString                   * MHeadViewIdentfier;
@property (nonatomic,assign)BOOL                       MIsScollDown;
@property (nonatomic,retain)KGProductsModel          * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@end

@implementation KGProductsViewController
@synthesize MVModel        = _MVModel;
@synthesize MRequestHelper = _MRequestHelper;

-(void)setKGGoodsArr:(NSArray<NSArray<KGGoods *> *> *)KGGoodsArr
{
    if (KGGoodsArr)
    {
        _KGGoodsArr = KGGoodsArr;
        [self.KGTableView reloadData];
    }
}


-(void)setKGSupermarketData:(KGSupermarket *)KGSupermarketData
{
    if (KGSupermarketData)
    {
        _KGSupermarketData = KGSupermarketData;
        self.KGGoodsArr = [KGSupermarket searchCategoryMatchProducts:KGSupermarketData.data];
        
    }
    
}

-(void)setKGCategortsSelectedIndexPath:(NSIndexPath *)KGCategortsSelectedIndexPath
{
    if (self.KGTableView)
    {
        _KGCategortsSelectedIndexPath = KGCategortsSelectedIndexPath;
        NSIndexPath * index =   [NSIndexPath indexPathForRow:0 inSection:KGCategortsSelectedIndexPath.row];
        [self.KGTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}


-(void)reloadViews:(NSString *)pid
{
    if (pid)
    {
        self.view.hidden = false;
        NSDictionary * dic = self.MVModel.KDRequestItem.YRequestDic;
        [dic setValue:pid forKey:@"cid"];
         [_KGTableView.mj_header beginRefreshing];
        
    }
}


#pragma mark
#pragma mark ----  请求 ---
-(void)initloadRequestStart
{
//    [_KGTableView.mj_header beginRefreshing];
    [self requestRegin];
}
-(void)requestRegin
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDRequestItem];
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
    
//    if (![KGProgressHUDManager isVisible])
//    {
//        [KGProgressHUDManager show];
//    }

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

//    if (self.MRequestHelper.YNetworkRequestCount == 0)
//    {
//        [KGProgressHUDManager dismiss];
//
//    }
//    
    
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
                [weakSelf ProcessingNetworkBack:state];
                
            }];
            
        }
            
            break;
            
            
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
            //            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //            //            alertView.NTAlertDelegate = self;
            //            [alertView ShowView];
            
        }
            break;
            
        default:
            break;
    }
     [self stopRefrsh];
    
}

-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            [[iToast makeText:[jsonDic valueForKey:@"message"]] show];
            
        }
            break;
            
        default:
            break;
    }
    [self stopRefrsh];
}
//用于列表
-(void)ProcessingNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            
            [self.KGTableView reloadData];
            
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
            [[iToast makeText:@"商品数据错误"] show];
        }
            break;
        case YZPROCESSINGDATANULL:
        {
            
            //            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //
            //            [alertView ShowView];
        }
            break;
            
            
            
        default:
            break;
    }
     [self stopRefrsh];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    _MHeadViewIdentfier = @"supermarketHeadView";
//    _MLastOffsetY       = 0;
//    _MIsScollDown       = false;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyProductNumberDidChangeNotification object:nil];
    self.view.frame = CGRectMake(100, NavigationH, ScreenWidth -100, ScreenHeight - NavigationH);
    [self buildProductsTableView];
}
-(void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    _MVModel = [[KGProductsModel alloc]init];
   
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)shopCarBuyProductNumberDidChange
{
    [self.KGTableView reloadData];
}

-(void)buildProductsTableView
{
    if (_KGTableView == nil)
    {
        _KGTableView = [[LFBTableView alloc]initWithFrame:CGRectMake(0, 50, self.view.v_width, self.view.v_height-50) style:UITableViewStylePlain];
        _KGTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _KGTableView.backgroundColor = [UIColor whiteColor];
        //LFBGlobalBackgroundColor;
        _KGTableView.delegate = self;
        _KGTableView.dataSource = self;
        [_KGTableView registerClass:[KGSupermarketHeadView class] forHeaderFooterViewReuseIdentifier:_MHeadViewIdentfier];
//        _KGTableView.tableFooterView =[self buildProductsTableViewTableFooterView];
        MJRefreshNormalHeader * refreshHeadView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshUpPull)];
//        KGRefreshHeader * refreshHeadView = [KGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshUpPull)];
        KGRefreshFooter  * refresFootView = [KGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshFooter)];
//        refreshHeadView.gifView.frame = CGRectMake(0, 30, 100, 100);
        _KGTableView.mj_header    = refreshHeadView;
        _KGTableView.mj_footer    = refresFootView;
        _KGTableView.showsVerticalScrollIndicator = false;
        [self.view addSubview:_KGTableView];
        


    }
}
-(void)beginRefreshUpPull
{
//    if (self.KGBlock)
//    {
//        _KGBlock();
//    }
    [self.MVModel resetModel];
    [self.KGTableView.mj_footer resetNoMoreData];
//    [self.KGTableView reloadData];
    [self initloadRequestStart];
    
}

-(void)endRefreshUpPull
{
    [self.KGTableView.mj_header endRefreshing];
}

-(void)beginRefreshFooter
{
    [self initloadRequestStart];
}

-(void)endRefreshFooter
{
    if (!self.MVModel.KDHasNext)
    {
        [self.KGTableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
    [self.KGTableView.mj_footer endRefreshing];
    }
}
-(void)stopRefrsh
{
    if ([self.KGTableView.mj_header isRefreshing]) {
        [self endRefreshUpPull];
    }
    
    if ([self.KGTableView.mj_footer isRefreshing])
    {
        [self endRefreshFooter];
    }
}

-(UIView *)buildProductsTableViewTableFooterView
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.KGTableView.v_width, 70)];
    
  
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"v2_common_footer"];
    return imageView;

}

#pragma mark --------tableview delegate ---------

//-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
//{
//    NSInteger  count =  self.KGSupermarketData.data.categories.count?:0;
//
//    return count;
//}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.KGGoodsArr.count>0)
//    {
//        return [self.KGGoodsArr[section] count]?:0;
//    }
//    return 0;
    return self.MVModel.KDGoodsModelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath

{
    return 94.0f;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 25.0f;
//}

-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KGSupermarketHeadView * headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:_MHeadViewIdentfier];
    if (self.KGSupermarketData.data.categories.count>0 && self.KGSupermarketData.data.categories[section].name  != nil )
    {
        headview.KGTitleLabel.text =  self.KGSupermarketData.data.categories[section].name;

    }
    
    return headview;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.KGDelegate && [self.KGDelegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _MIsScollDown)
    {
        [self.KGDelegate didEndDisplayingHeaderView:section];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.KGDelegate && [self.KGDelegate respondsToSelector:@selector(willDisplayHeaderView:)] && !_MIsScollDown)
    {
        [self.KGDelegate willDisplayHeaderView:section];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.KGGoodsArr)
    {
        //KGGoods * goods = self.KGGoodsArr[indexPath.section][indexPath.row];
    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGProductCell * cell = [KGProductCell cellWithTableView:tableView];
    KGGoodsModel * goods  = self.MVModel.KDGoodsModelArr[indexPath.row];
    //[cell updateWithNote:goods];
    cell.KMGoodsModel = goods;
    __weak KGProductsViewController * tmpSelf = self;
    
    cell.KGAddProductClick =  ^(UIImageView * imageView)
    {
        [tmpSelf addProductsAnimation:imageView];
    };
    return cell;
}

-(void)addProductsAnimation:(UIImageView *)imageView
{
    KGMainTabBarController * tab =  (KGMainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tab addProductsAnimation:imageView];

}
#pragma mark --------scrollview delegate ---------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.KGAnimationLayers.count>0)
    {
        CALayer * transsionLayer  = self.KGAnimationLayers[0];
        transsionLayer.hidden = true;
    }
    
    _MIsScollDown = _MLastOffsetY <scrollView.contentOffset.y;
    _MLastOffsetY =  scrollView.contentOffset.y;
}
@end
