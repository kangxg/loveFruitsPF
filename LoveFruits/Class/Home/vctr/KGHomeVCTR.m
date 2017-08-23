//
//  KGHomeVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/3.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeVCTR.h"
#import "GlobelDefine.h"
#import "KGAnimationTabBarController.h"
#import "KGCollectionView.h"
#import "KGHomeCell.h"
#import "KGHomeCollectionHeaderView.h"
#import "KGHomeCollectionFooterView.h"
#import "KGRefreshHeader.h"
#import "KGMainTabBarController.h"
#import "KGHomeTableHeadView.h"
#import "KGHomeHeadResources.h"
#import "KGHomeFreshHot.h"
#import "KGHomeFreshHot.h"
#import "KGProgressHUDManager.h"
#import "KGHomeWebVCTR.h"
#import "KGCoordinating.h"
#import "YZRequestItem.h"
#import "KGHomeHotCommodityListVCTR.h"
#import "KGHomeNewCommodityListVCTR.h"
#import "KGHomePromotionListVCTR.h"
#import "KGHomeModel.h"
#import "YZNetworkRequestHelper.h"
#import "iToast.h"
#import "KGHomeGoodsAdsModel.h"
#import "KGTodyProductDetailsVCTR.h"
#import "KGGoodsAdsModel.h"
#import "KGLoadFailView.h"
#import "KGCouponCenterVCTR.h"

#import "MJRefreshNormalHeader.h"
#import "KGLoginVCTR.h"
#import "KGUserModelManager.h"

#import "KGMyOrdersVCTR.h"

@interface KGHomeVCTR()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,KGHomeTableHeadViewDelegate,YZNetworkRequestHelpDelegate,KGHomeCellDelegate>
{
    KGHomeCollectionFooterView * _mfooterView;
}
@property(nonatomic,retain)KGCollectionView     *  MCollectionView;
@property(nonatomic,retain)KGHomeTableHeadView  *  MHeadView;
@property(nonatomic,retain)KGHomeHeadResources  *  MHeadResources;
@property(nonatomic,retain)KGHomeFreshHot       *  MFreshHot;
@property(nonatomic,assign)CGFloat                 MLastContentOffsetY;
@property(nonatomic,assign)BOOL                    MIsAnimation;
@property(nonatomic,assign)NSInteger               MFlag;
@property(nonatomic,retain)KGHomeModel          *  MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@property (nonatomic,retain)KGLoadFailView           * MVloadFailView;
@property (nonatomic, strong) NSMutableDictionary *cellDic;


@end

@implementation KGHomeVCTR
@synthesize MVModel = _MVModel;
-(void)viewDidLoad
{
    [super viewDidLoad];
    _cellDic=  [[NSMutableDictionary alloc] init];
    [self initData];
    [self addHomeNotification];
    [self buildCollectionView];
    [self buildTableHeadView];
    [self initloadRequestStart];

}
-(void)initData
{
     self.view.backgroundColor = [UIColor whiteColor];
    _MVModel = [[KGHomeModel alloc]init];
    _MFlag = -1;
    _MLastContentOffsetY = 0;
    _MIsAnimation        = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController)
    {
        [self.navigationController.navigationBar setBarTintColor:LFBNavigationHomeSearchColor];
    }
    if (_MCollectionView)
    {
        [_MCollectionView reloadData];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LFBSearchViewControllerDeinit" object:nil];
    
 
}


-(void)addHomeNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewHeightDidChange object:nil];
 
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shopCarBuyProductNumberDidChange) name:LFBShopCarBuyProductNumberDidChangeNotification object:nil];
}

-(void)homeTableHeadViewHeightDidChange:(NSNotification *)notify
{
    if (_MCollectionView)
    {
        
        _MCollectionView.contentInset = UIEdgeInsetsMake([[notify object] floatValue], 0, NavigationH, 0);
        [_MCollectionView setContentOffset:CGPointMake(0, -_MCollectionView.contentInset.top) animated:false];
        _MLastContentOffsetY =  _MCollectionView.contentOffset.y;
    }
}

-(void)shopCarBuyProductNumberDidChange
{
    [_MCollectionView reloadData];
}
-(void)buildCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing      = 1;
    layout.sectionInset            = UIEdgeInsetsMake(0, 0, 0,0 );//HomeCollectionViewCellMargin
    if (_MCollectionView==nil)
    {
        _MCollectionView = [[KGCollectionView alloc]initWithFrame:CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight -NavigationH ) collectionViewLayout:layout];
        _MCollectionView.delegate    = self;
        _MCollectionView.dataSource  = self;
        _MCollectionView.backgroundColor = LFBGlobalBackgroundColor;
//        [_MCollectionView registerClass:[KGHomeOherCell class] forCellWithReuseIdentifier:@"Cell"];
//        [_MCollectionView registerClass:[KGHomeSecondCell class] forCellWithReuseIdentifier:@"SecondCell"];
        [_MCollectionView registerClass:[KGHomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [_MCollectionView registerClass:[KGHomeCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];

        [self.view addSubview:_MCollectionView];
//        MJRefreshNormalHeader * refreshHeadView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
//        refreshHeadView.frame = CGRectMake(0, 30, 100, 100);

        KGRefreshHeader * refreshHeadView = [KGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        refreshHeadView.gifView.frame = CGRectMake(0, 30, 100, 100);
        _MCollectionView.mj_header    = refreshHeadView;
    }
    
}
-(void)headRefresh
{
    [self.MRequestHelper beginRequest:@[self.MVModel.KDAdvertRequestItem,self.MVModel.KDListRequestItem]];
//    [self.MRequestHelper beginRequestWithItem:_MVModel.KDListRequestItem];

}
-(void)buildTableHeadView
{
    
    if (_MHeadView == nil)
    {
        _MHeadView = [[KGHomeTableHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 223)];
        _MHeadView.KGDelegate = self;
        [_MHeadView resetHotViews:_MVModel.KDHeadData];

        
        [_MCollectionView addSubview:_MHeadView];
        
        _MCollectionView.contentInset = UIEdgeInsetsMake(223, 0, 60, 0);
        [_MCollectionView setContentOffset:CGPointMake(0, -_MCollectionView.contentInset.top) animated:false];
        _MLastContentOffsetY =  _MCollectionView.contentOffset.y;
//        [_MCollectionView reloadData];
    }

}

-(void)buildProessHud
{
//    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:240 withGreen:240 withBlue:240]];
//    [KGProgressHUDManager setFont:[UIFont systemFontOfSize:16.0f]];
}
#pragma mark --- tableHead Delegate ---
-(void)tableHeadView:(KGHomeTableHeadView *)headView focusImageViewClick:(NSInteger)index
{
    if (_MVModel.KDHeadData.focus.count>0)
    {

        Activities * act = _MVModel.KDHeadData.focus[index];
        if (act)
        {
            KGHomeWebVCTR * vctr = [[KGHomeWebVCTR alloc]init];
            //:_MHeadResources.data.focus[index].name withUrlStr:array[index]
            vctr.KVTitleString =act.name;
            vctr.KVWebUrlString = act.detailUrl;
            [[KGCoordinating shareInstance]requestViewChange:self whitTo:vctr];
           
        }
     }
}


-(void)tableHeadView:(KGHomeTableHeadView *)headView iconClick:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
            [tabBarController setSelectIndex:0 withTag:1];

        }
            break;
        case 1:
        {
            KGHomeWebVCTR * vctr = [[KGHomeWebVCTR alloc]init];
                                    //init:@"热门商品" withUrlStr:@"http://sdzwsj.com/hotgoods"];
            vctr.KVTitleString  = @"热门商品";
            vctr.KVWebUrlString = @"http://sdzwsj.com/hotgoods";
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 2:
        {
           KGCouponCenterVCTR * vctr = [[KGCouponCenterVCTR alloc]init];
           
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case 3:
        {
            if ([[KGUserModelManager shareInstanced] getUserModel] == nil ||![[KGUserModelManager shareInstanced] getUserModel].KUserId )
            {
                KGLoginVCTR * vctr = [[KGLoginVCTR alloc]init];
                [self.navigationController pushViewController:vctr animated:YES];
            }
            else
            {
                KGMyOrdersVCTR * vctr = [[KGMyOrdersVCTR alloc]init];
                [self.navigationController pushViewController:vctr animated:YES];
            }
         
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
    [_MCollectionView.mj_header beginRefreshing];
//    [self requestRegin];
}
-(void)requestRegin
{
//    ,self.MVModel.KDShopInfoRequestItem@[self.MVModel.KDAdvertRequestItem,self.MVModel.KDListRequestItem,self.MVModel.KDShopInfoRequestItem]]
    [self.MRequestHelper beginRequest:@[self.MVModel.KDAdvertRequestItem,self.MVModel.KDListRequestItem]];
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
    
    
//    [self  startLoadingView];
    
    
}

/**
 *  Description 网络请求 完成
 */
-(void)pRequestFinished
{
    
//    if (self.MRequestHelper.YNetworkRequestCount== 0)
//    {
//        [self stopLoadingView];
//    }
    
}

/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
//     [KGProgressHUDManager setSuccessImage:[UIImage imageNamed:@"loading"]];
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
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingHeadInfoNetworkBack:state];
            }];
           
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
            KGWEAKOBJECT(weakSelf);
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingListNetworkBack:state withType:type];
            }];
        }
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            KGWEAKOBJECT(weakSelf);
            [self.MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingShopInfoNetworkBack:state];
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
    }
    _MCollectionView.hidden = YES;

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
-(void)ProcessingListNetworkBack:(YZProcessingDataState )state withType:(NSInteger )type
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            [self.MCollectionView.mj_header endRefreshing];
            [self.MCollectionView reloadData];
            
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
             [self CreateloadFailView];
        }
            break;
            
            
            
        default:
            break;
    }
    
}
-(void)ProcessingHeadInfoNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self removeFailView];
            _MCollectionView.hidden = false;
            [_MHeadView resetPageViews:_MVModel.KDHeadData];
          
            [self.MCollectionView reloadData];
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
            [self CreateloadFailView];
        }
            break;
            
            
            
        default:
            break;
    }
}
-(void)ProcessingShopInfoNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            _MCollectionView.hidden = false;
            [self.MCollectionView reloadData];
            
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
            
        }
            break;
            
            
            
        default:
            break;
    }
}
#pragma mark
#pragma mark ---collection Delegate ---
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[section];
    switch (model.adsType)
    {
        case KGGOODSADSTYPEFIRST:
        {
            return 1;
        }
            break;
        case KGGOODSADSTYPESECOND:
        {
            return 1;
        }
            break;
        case KGGOODSADSTYPETHIRD:
        {
            return model.goodsArr.count;
        }
            break;
        case KGGOODSADSTYPEFOURCH:
        {
            return model.goodsArr.count;
        }
            break;
        default:
            break;
    }

    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    if (!_MHeadResources.data.activities.count ||!_MFreshHot.data.count)
//    {
//        return 0;
//    }
//    return 2;
  
    return _MVModel.KDAdsModelArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize  = CGSizeZero;
    KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[indexPath.section];
    switch (model.adsType)
    {
        case KGGOODSADSTYPEFIRST:
        {
           itemSize =  CGSizeMake(ScreenWidth , 87);
        }
            break;
        case KGGOODSADSTYPESECOND:
        {
            itemSize =  CGSizeMake((ScreenWidth ), 140);

        }
            break;
        case KGGOODSADSTYPETHIRD:
        {
            itemSize = CGSizeMake((ScreenWidth )/3-1, 139.5);
        }
            break;
        case KGGOODSADSTYPEFOURCH:
        {
            itemSize = CGSizeMake((ScreenWidth )/3-1, 158.5);
        }
            break;
        default:
            break;
    }

    return itemSize;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize itemSize  = CGSizeZero;
    KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[section];
    switch (model.adsType)
    {
        case KGGOODSADSTYPEFIRST:
        {
            itemSize = CGSizeMake(ScreenWidth,10);
        }
            break;
        case KGGOODSADSTYPESECOND:
        {
            itemSize = CGSizeMake(ScreenWidth,10);
            
        }
            break;
        case KGGOODSADSTYPETHIRD:
        {
            itemSize =  CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin+39);
        }
            break;
        case KGGOODSADSTYPEFOURCH:
        {
            itemSize = CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin * 2+29);
        }
            break;
        default:
            break;
    }

   
    return itemSize;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    KGHomeCell * cell ;
  
    KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[indexPath.section];
    if (model.adsType!=KGGOODSADSTYPESECOND)
    {
        NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        if (cell == nil)
        {
             identifier = [NSString stringWithFormat:@"Cell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
            
             [self.MCollectionView registerClass:[KGHomeOherCell class]  forCellWithReuseIdentifier:identifier];
             cell = (KGHomeOherCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        }
       
    
    }
    else
    {
        NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
        if (cell == nil)
        {
             identifier = [NSString stringWithFormat:@"SecondCell%@", [NSString stringWithFormat:@"%@", indexPath]];
             [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
              [self.MCollectionView registerClass:[KGHomeSecondCell class]  forCellWithReuseIdentifier:identifier];
            cell = (KGHomeSecondCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            cell.KVDelegate = self;
        }
        
        
    }
    if (_MVModel.KDAdsModelArr.count == 0)
    {
        return cell;
    }
//     cell = (KGHomeOherCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
    switch (model.adsType)
    {
        case KGGOODSADSTYPEFIRST:
        {
            cell.KGActivty = _MVModel.KDAdsModelArr[indexPath.section];
        }
            break;
        case KGGOODSADSTYPESECOND:
        {
            
            cell.KGActivty = _MVModel.KDAdsModelArr[indexPath.section];
            
        }
            break;
        case KGGOODSADSTYPETHIRD:
        {
            [cell setGoods: _MVModel.KDAdsModelArr[indexPath.section].goodsArr [indexPath.row] withType:model.adsType];
            
        }
            break;
        case KGGOODSADSTYPEFOURCH:
        {
            [cell setGoods: _MVModel.KDAdsModelArr[indexPath.section].goodsArr [indexPath.row] withType:model.adsType];
        }
            break;
        default:
            break;
    }


    return cell;
}

-(void)addProductsAnimation:(UIImageView *)imageView
{
    KGMainTabBarController * tab =  (KGMainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tab addProductsAnimation:imageView];
    
}
// footer
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size =CGSizeZero;
//    size = CGSizeMake(ScreenWidth, 10);
    if (section == (_MVModel.KDAdsModelArr.count-1))
    {
        size = CGSizeMake(ScreenWidth, 1);
//        if (_MVModel.KDShopInformation )
//        {
//            size = CGSizeMake(ScreenWidth, 10);
////            return CGSizeMake(ScreenWidth, HomeCollectionViewCellMargin * 5);
//        }
        
    }
    else
    {
        size = CGSizeMake(ScreenWidth,0001);
    }
    return size;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %ld",indexPath.section);
     KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
         KGHomeCollectionHeaderView * headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
       
        switch (model.adsType)
        {
            case KGGOODSADSTYPEFIRST:
            {
                
//                headview = nil;
            }
                break;
            case KGGOODSADSTYPESECOND:
            {
//                        headview = nil;


                
            }
                break;
            case KGGOODSADSTYPETHIRD:
            {
               
                KGWEAKOBJECT(weakSelf);
                [headview setHeadViewMessage:@"新品推荐" withTitleColor:@"#ffae02" withImage:@"news" withDetail:model.detailUrl withClick:^(id object) {
                     [weakSelf gotoNewRecommend:object];
                }];
              
                headview.hidden = false;
                return headview;

            }
                break;
            case KGGOODSADSTYPEFOURCH:
            {
              
                [headview setHeadViewMessage:@"今日促销" withTitleColor:@"#ec4646" withImage:@"sales" withDetail:nil withClick:nil];
                 headview.hidden = false;
//                [headview setHeadViewMessage:@"今日促销" withTitleColor:@"#ec4646" withImage:@"sales" withClick:^(UIButton *button) {
//                    [self gotoTodayPromotion];
//                }];
                return headview;
            }
                break;
            default:
                break;
        }

    
       
        
    }
    KGHomeCollectionFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    
    if (indexPath.section == 5 && [kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        _mfooterView = footerView;
         [footerView hideLabel];
//        [footerView showLabel];
//        footerView.tag = 100;
//        [footerView setFooterImage:_MVModel.KDShopInformation];
    }
    else
    {
        [footerView hideLabel];
        footerView.tag = 1;
    }
    
//    footerView.backgroundColor = [UIColor redColor];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreGoodsClick:)];
//    [footerView addGestureRecognizer:tap];
    return footerView;
}
-(void)gotoTodayPromotion
{
    KGHomePromotionListVCTR * vctr = [[KGHomePromotionListVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}

-(void)gotoNewRecommend:(NSString *)string
{
    
    KGHomeWebVCTR * vct =[[KGHomeWebVCTR alloc]init];
    vct.KVTitleString = @"新品推荐";
    vct.KVWebUrlString = string;
    [self.navigationController pushViewController:vct animated:YES];

//    KGHomeNewCommodityListVCTR * vctr = [[KGHomeNewCommodityListVCTR alloc]init];
//    [self.navigationController pushViewController:vctr animated:YES];

}

-(void)moreGoodsClick:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 100)
    {
        KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
        [tabBarController setSelectIndex:0 withTag:1];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //id<KGAdsModelInterface>
    KGHomeGoodsAdsModel * model = _MVModel.KDAdsModelArr[indexPath.section];

    switch (model.adsType)
    {
        case KGGOODSADSTYPEFIRST:
        {
            KGHomeWebVCTR * vct =[[KGHomeWebVCTR alloc]init];
            vct.KVTitleString = model.cpName;
            vct.KVWebUrlString = model.detailUrl;
            [self.navigationController pushViewController:vct animated:YES];

        }
            break;
        case KGGOODSADSTYPESECOND:
        {
            
            
        }
            break;
        case KGGOODSADSTYPETHIRD:
        {
            KGHomeWebVCTR * vct =[[KGHomeWebVCTR alloc]init];
            vct.KVTitleString = model.cpName;
            vct.KVWebUrlString = model.detailUrl;
            [self.navigationController pushViewController:vct animated:YES];
//            KGTodyProductDetailsVCTR * vctr = [[KGTodyProductDetailsVCTR alloc]init];
//            vctr.YMProductId = model.goodsArr[indexPath.row].pid;
//            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        case KGGOODSADSTYPEFOURCH:
        {
            
            
            model = (KGHomeFourthAdsModel *)model;
            KGTodyProductDetailsVCTR * vctr = [[KGTodyProductDetailsVCTR alloc]init];
            KGGoodsAdsModel * gmodel =model.goodsArr[indexPath.row];
            vctr.YMProductId = gmodel.pid;
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        default:
            break;
    }
    

}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row ==1))
    {
        return;
    }
    if (_MIsAnimation)
    {
        [self startAnimation:cell offsetY:80 duration:1.0];
    }
}

-(void)startAnimation:(UIView *)view offsetY:(CGFloat)offsetY duration:(NSTimeInterval) duration
{
    view.transform = CGAffineTransformMakeTranslation(0,offsetY);
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && _MHeadResources && _MFreshHot && _MIsAnimation)
    {
        [self startAnimation:view offsetY:60 duration:0.8];
    }
}

-(void)pGotoActivty:(NSString *)detailSting withTitle:(NSString *)title
{
    if (detailSting.length)
    {
        KGHomeWebVCTR * vct =[[KGHomeWebVCTR alloc]init];
        vct.KVTitleString = title;
        vct.KVWebUrlString = detailSting;
        [self.navigationController pushViewController:vct animated:YES];
    }
}
@end
