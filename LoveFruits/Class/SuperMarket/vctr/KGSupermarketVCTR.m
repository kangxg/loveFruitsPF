//
//  KGSupermarketVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/3.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSupermarketVCTR.h"
#import "KGSupermarket.h"
#import "KGProductsViewController.h"
#import "LFBTableView.h"
#import "GlobelDefine.h"
#import "KGProgressHUDManager.h"
#import "UIColor+Extension.h"
#import "KGCategoryCell.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "YZNetworkRequestHelper.h"
#import "KGSupermarkModel.h"
#import "YZRequestItem.h"
#import "iToast.h"
#import "KGSuperOneLevelView.h"
#import "KGTableCellDelegate.h"
#import "KGAnimationView.h"
@interface  KGSupermarketVCTR()<UITableViewDataSource,UITableViewDelegate,ProductsViewControllerDelegate,YZNetworkRequestHelpDelegate,KGOneLeveViewDelegate,KGOneLeveSourceDelegate,KGTableCellDelegate>
@property (nonatomic,retain)KGSupermarket            * MSupermarketData;
@property (nonatomic,retain)LFBTableView             * MCategoryTableView;
@property (nonatomic,retain)KGProductsViewController * MProductsVCTR;
@property (nonatomic,assign)BOOL                       MCategoryTableViewIsLoadFinish;
@property (nonatomic,assign)BOOL                       MProductTableViewIsLoadFinish;
@property (nonatomic,retain)KGSupermarkModel         * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;

@property (nonatomic,retain)KGSuperOneLevelView      * MVOneLevelView;


@property (nonatomic,retain)KGAnimationView          * MVLoadingView;

@end


@implementation KGSupermarketVCTR
@synthesize MVModel = _MVModel;

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self initData];
    
    [self addNotification];
    [self bulidProductsViewController];
    [self createOneLevelView];
    [self bulidCategoryTableView];
    
  
//    [self loadSupermarketData];

    //self.view.backgroundColor = [UIColor greenColor];
}
-(void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
 
    _MCategoryTableViewIsLoadFinish = false;
    _MProductTableViewIsLoadFinish  = false;
   
 
}
-(KGSupermarkModel *)MVModel
{
    if (_MVModel == nil)
    {
        _MVModel = [[KGSupermarkModel alloc]init];
    }
    return _MVModel;
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
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"LFBSearchViewControllerDeinit" object:nil];
//    self.navigationController.navigationBar.barTintColor = LFBNavigationYellowColor;
    if (self.MIsLoad)
    {
        [self initloadRequestStart];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeLoadingView];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark
#pragma mark ----  请求 ---
-(void)initloadRequestStart
{
    [self requestRegin];
}
-(void)requestRegin
{
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDSuperRequestItem];
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
//    [self showProgressHUD];
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
//          [KGProgressHUDManager dismiss];
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
    
}
//用于列表
-(void)ProcessingNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            
            [self.MVOneLevelView reloadData];
            _MCategoryTableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            
            
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
            //            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //            
            //            [alertView ShowView];
        }
            break;
            
            
            
        default:
            break;
    }
    
}


#pragma  mark
#pragma  mark ---  old ----
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyProductNumberDidChangeNotification object:nil];

}

-(void)shopCarBuyProductNumberDidChange
{
    
}

-(void)showProgressHUD
{
    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
    self.view.backgroundColor = [UIColor whiteColor];
    if (![KGProgressHUDManager isVisible])
    {
        [KGProgressHUDManager showWithStatus:@"正在加载中"];
    }
}
-(void)createOneLevelView
{
    if (_MVOneLevelView == nil)
    {
        _MVOneLevelView = [[KGSuperOneLevelView alloc]initWithFrame:CGRectMake(0,NavigationH , ScreenWidth, 50)];
        _MVOneLevelView.KGSourceDelegate = self;
        _MVOneLevelView.KGViewDelegate  = self;
        [self.view addSubview:_MVOneLevelView];
    }
 
}

-(NSArray<KGClassificationModel *> *)getClassModel
{
    return self.MVModel.KDOneClassArr;
}
-(void)bulidCategoryTableView
{
    if (_MCategoryTableView == nil)
    {
        _MCategoryTableView = [[LFBTableView alloc]initWithFrame:CGRectMake(0, NavigationH+50, 100, ScreenHeight-NavigationH-50)  style:UITableViewStylePlain];
        _MCategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _MCategoryTableView.backgroundColor = LFBGlobalBackgroundColor;
        _MCategoryTableView.delegate = self;
        _MCategoryTableView.dataSource = self;
        _MCategoryTableView.showsHorizontalScrollIndicator = false;
        _MCategoryTableView.showsVerticalScrollIndicator = false;
        _MCategoryTableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0);
//        _MCategoryTableView.hidden = true;
        [self.view addSubview:_MCategoryTableView];
        [self.view bringSubviewToFront:_MCategoryTableView];
        

        
    }
}


//-(void) loadSupermarketData
//{
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(),^{
//        __weak  KGSupermarketVCTR * tmpSelf = self;
//        [KGSupermarket loadData:^(id<KGModelInterface> data, NSError *error) {
//            if (error == nil)
//            {
//                tmpSelf.MSupermarketData = data;
//                [tmpSelf.MCategoryTableView reloadData];
//                [tmpSelf.MCategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:true scrollPosition:UITableViewScrollPositionBottom];
//                tmpSelf.MProductTableViewIsLoadFinish = true;
//                tmpSelf.MCategoryTableViewIsLoadFinish = true;
//                tmpSelf.MProductsVCTR.KGSupermarketData = data;
//       
//            
//                if (tmpSelf.MCategoryTableViewIsLoadFinish && tmpSelf.MProductTableViewIsLoadFinish)
//                {
//                    tmpSelf.MCategoryTableView.hidden = false;
//                 
//                    tmpSelf.MProductsVCTR.KGTableView.hidden = false;
//                    tmpSelf.MProductsVCTR.view.hidden =false;
//
//
//                  
//            
//                    tmpSelf.view.backgroundColor = LFBGlobalBackgroundColor;
//                }
//
//            }
//        }];
//    });
//}
-(void)pSelectedOperation:(NSString *)markId
{
    self.MVModel.KDSelectId  = markId;
  
    [_MCategoryTableView reloadData];
    
    if (self.MVModel.KDSelectArr.count)
    {
         [self willDisplayHeaderView:0];
    }
   
}
#pragma mark ----   table delegate   ----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.MVModel.KDSelectArr)
    {
        return self.MVModel.KDSelectArr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGCategoryCell * cell = [KGCategoryCell  cellWithTableView:tableView];
    cell.KVDelegate  = self;
//    cell.KCateorie = self.MSupermarketData.data.categories[indexPath.row];
    cell.KVModel = self.MVModel.KDSelectArr[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

-(void)pClickGoodClass:(NSString *)pid
{
    if (pid)
    {
        [self.MProductsVCTR reloadViews:pid];
    }
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_MProductsVCTR)
//    {
//        _MProductsVCTR.KGCategortsSelectedIndexPath = indexPath;
//    }
//}

-(void)bulidProductsViewController
{
    if (_MProductsVCTR == nil)
    {
        _MProductsVCTR = [[KGProductsViewController alloc]init];
//        _MProductsVCTR.KGDelegate = self;
        _MProductsVCTR.view.hidden = YES;
        
        [self addChildViewController:_MProductsVCTR];
        [self.view addSubview:_MProductsVCTR.view];
//        __weak KGSupermarketVCTR * tmpSelf = self;
//        _MProductsVCTR.KGBlock = ^{
//            
//            dispatch_time_t  time = dispatch_time(DISPATCH_TIME_NOW, 2 *NSEC_PER_SEC);
//            dispatch_after(time, dispatch_get_main_queue(), ^{
//                [KGSupermarket loadData:^(id<KGModelInterface> data, NSError *error)
//                {
//                    tmpSelf.MSupermarketData = data;
//                    tmpSelf.MProductsVCTR.KGSupermarketData = data;
//                
//                    [tmpSelf.MProductsVCTR.KGTableView.mj_header endRefreshing];
//                    
//                    [tmpSelf.MProductsVCTR.KGTableView reloadData];
//                    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
//                    [tmpSelf.MCategoryTableView selectRowAtIndexPath:indexpath animated:true scrollPosition:UITableViewScrollPositionNone];
//  
//                }];
//            });
//        };
    }
}
#pragma mark ----   product  delegate   ----
-(void)willDisplayHeaderView:(NSInteger)section
{
      NSIndexPath * indexpath = [NSIndexPath indexPathForRow:section inSection:0];
    [self.MCategoryTableView selectRowAtIndexPath:indexpath animated:true scrollPosition:UITableViewScrollPositionMiddle];

}
//
//-(void)didEndDisplayingHeaderView:(NSInteger)section
//{
//    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:section+1 inSection:0];
//    [self.MCategoryTableView selectRowAtIndexPath:indexpath animated:true scrollPosition:UITableViewScrollPositionMiddle];
//    
//}
@end
