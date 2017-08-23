//
//  KGShopCartVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/3.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShopCartVCTR.h"
#import "KGShopCartViewModel.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGShopCartCell.h"
#import "KGShopSettlementView.h"
#import "KGBaseViewDelegate.h"
#import "KGShopCartCellDelegate.h"
#import "KGShopCarRedDotView.h"
#import "KGNullDataView.h"
#import "KGNoLogView.h"
#import "KGLoginVCTR.h"
#import "KGUserModelManager.h"
#import "KGSubmitOrdersVCTR.h"
#import "KGProgressHUDManager.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"

#import "iToast.h"
#import "KGProductAlertView.h"
#import "KGProductAlertView.h"
#import "KGAddMerchantsInfoVCTR.h"
#import "KGOrderDetalVCTR.h"
#import "KGLoginVCTR.h"
#import "KGLogauditAlertView.h"
#import "KGAnimationView.h"
@interface KGShopCartVCTR()<YZNetworkRequestHelpDelegate,UITableViewDataSource,UITableViewDelegate,KGBaseViewDelegate,KGShopCartCellDelegate,NTAlertViewDelegate,NTAlertViewDelegate>
{
    KGShopCartViewModel   * _mModel;
    UITableView           * _mTableview;
}
@property (nonatomic,retain)KGShopCartViewModel  * MVModel;
@property(strong,nonatomic)UITableView * MVTableview;
@property (nonatomic,retain) KGShopSettlementView  *  MVSettlementView;
@property (nonatomic,retain)UIButton               *  MVEditButton;
@property (nonatomic,retain)KGNullDataView         *  MVNullDataView;
@property (nonatomic,retain)KGNoLogView            *  MVUnlogView;
@property (nonatomic,retain)YZNetworkRequestHelper *  MRequestHelper;
@property (nonatomic,retain)KGAnimationView          * MVLoadingView;
@end

@implementation KGShopCartVCTR
@synthesize   MVModel          = _mModel;
@synthesize   MVTableview      = _mTableview;
@synthesize   MVSettlementView = _MVSettlementView;
@synthesize   MVNullDataView   = _MVNullDataView;
@synthesize   MVUnlogView      = _MVUnlogView;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    NSInteger goodsCount =[_mModel getGoosData];
    if (goodsCount )
    {
        [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
        [self removeNodataView];
        KGUserModel * user = [[KGUserModelManager shareInstanced]getUserModel];
        if (user.KUserToken.length)
        {
            
            [self removeUnlogView];
            
           
        }
        else
        {
            
            [self createUnlogView];
            _MVEditButton.hidden = YES;
            return;
            
        
        }
        
    }
    else
    {
       KGUserModel * user = [[KGUserModelManager shareInstanced]getUserModel];
        if (user.KUserToken.length)
        {
          
             [self removeUnlogView];
             [self createNoDataView];
            
        }
        else
        {
            
            [self createUnlogView];
            [self removeNodataView];
            _MVEditButton.hidden = YES;
            return;


        }
        
    }
//    self.MVEditButton.hidden =!goodsCount;
    self.MVSettlementView.hidden = !goodsCount;
    [self.MVSettlementView setAllSeleted:[_mModel getAllSelected]];
    _MVEditButton.hidden = !goodsCount;
    [self.MVTableview reloadData];
    

}
-(void)pushLogView
{
    KGLoginVCTR * vctr = [[KGLoginVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}
-(void)loadView
{
    [super loadView];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackView:YES];
    [self initData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOrderDetailView:) name:@"showOrderDetail" object:nil];
    self.KVTitleLabel.text = @"购物车";
    [self.MVModel addObserver:self forKeyPath:@"KDEditType" options:NSKeyValueObservingOptionNew context:nil];
    [self createTopView];
    [self.view addSubview:self.MVTableview];
    [self.view addSubview:self.MVSettlementView];
  

    
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
-(void)showOrderDetailView:(NSNotification *)notify
{
    KGOverOrderDetalVCTR  * vctr = [[KGOverOrderDetalVCTR alloc]init];
    vctr.KVOrderId = notify.object;
    [self.navigationController pushViewController:vctr animated:YES];

}
-(void)createNoDataView
{
 
    if (_MVNullDataView == nil)
    {
        _MVNullDataView =[KGNullDataView initWithSuperView:self.view frame:CGRectMake(0, 0, ScreenWidth, self.MVTableview.v_height) imageName:@"no_shop" Click:NO];
        _MVNullDataView.nvllDataImage.frame = CGRectMake(_MVNullDataView.nvllDataImage.frame.origin.x, 155,_MVNullDataView.nvllDataImage.frame.size.width , _MVNullDataView.nvllDataImage.frame.size.height);
         [_MVNullDataView setShowContent:@"购物车什么都没有，\n去挑几件好货物吧！"];
        
        _MVNullDataView.contentLabel.frame  = CGRectMake(_MVNullDataView.contentLabel.frame.origin.x,_MVNullDataView.nvllDataImage.v_bottom+17,_MVNullDataView.contentLabel.frame.size.width , 80);
        
//        _MVNullDataView.contentLabel.backgroundColor = [UIColor redColor];
//        _MVNullDataView.backgroundColor = [UIColor greenColor];
        
    }

}
-(void)createUnlogView
{
    KGWEAKOBJECT(weakSelf);
    _MVUnlogView = [KGNoLogView initWithSuperView:self.view frame:CGRectMake(0, 0, ScreenWidth, self.MVTableview.v_height) imageName:@"no_log" WithBlock:^(id object) {
        [weakSelf gotoLog];
        
    }];
    _MVUnlogView.backgroundColor = self.view.backgroundColor;
    [self.view bringSubviewToFront:_MVUnlogView];
}

-(void)gotoLog
{
    KGLoginVCTR * Vctr = [[ KGLoginVCTR alloc]init];
    [self.navigationController pushViewController:Vctr animated:YES];

}
-(void)removeUnlogView
{
    if (_MVUnlogView)
    {
        [_MVUnlogView dissmissMyself];
        _MVUnlogView = nil;
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


-(void)dealloc
{
    [self.MVModel removeObserver:self forKeyPath:@"KDEditType"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"KDEditType"] )
    {
        
        [_MVSettlementView setState:_mModel.KDEditType];
    }
}
-(void)pSelectedAll:(BOOL)seleted
{
    [_mModel seletedAllGoods:seleted];
    [self.MVTableview reloadData];
    [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
    
}

-(void)pSelectedView:(id)sender
{
    [self.MVSettlementView setAllSeleted:[_mModel getAllSelected]];
    [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
}

-(void)pSubGoods:(id)sender
{
    if (sender)
    {
        KGShopCartCell  * cell = sender;
        id<KGGoodsModelInterface> model = cell.KVModel;
        if (model.isSelected)
        {
             [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
        }
        [[KGShopCarRedDotView sharedRedDotView] reduceProductToRedDotView:YES];
    }
   
}

-(void)pAddGoods:(id)sender
{
    if (sender)
    {
        KGShopCartCell  * cell = sender;
        id<KGGoodsModelInterface> model = cell.KVModel;
        if (model.isSelected)
        {
            [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
        }
        [[KGShopCarRedDotView sharedRedDotView] addProductToRedDotView:true];
    }
}
#pragma mark
#pragma mark   ------------------  结算按钮回调 ------------------
-(void)pClickSettlement:(id)sender
{
    switch (_mModel.KDEditType)
    {
        case KGSHOPCARTYPENORMAL:
        {
            if ([[_mModel getBuyTotalAmount] floatValue]>0)
            {
               [self begainUserStateNetworkRequest];
                
//                KGSubmitOrdersVCTR  * vctr = [[KGSubmitOrdersVCTR alloc]init];
//                [self.navigationController pushViewController:vctr animated:YES];
            }
            else
            {
                [[iToast makeText:@"请选择结算商品"]show];
            }
          
        }
            break;
        case KGSHOPCARTYPEDELETE:
        {
             if ([[_mModel getBuyTotalAmount] floatValue]>0)
             {
                  [self  deleteProduct];
             }
             else
             {
                 [[iToast makeText:@"请选择结算商品"]show];
             }
           

        }
            break;
            
        default:
            break;
    }
}
-(void)deleteProduct
{
//    KGDeleteProductAlertView  * deletAlert = [KGDeleteProductAlertView createAlertView:EN_NTAlertViewStyleCorner];
//    deletAlert.NTAlertDelegate = self;
//    deletAlert.tag = 100;
//    [deletAlert ShowView];
    
    KGDeleteProductAlertView  * deletAlert = [KGDeleteProductAlertView createAlertView:EN_NTAlertViewStyleCorner];
    deletAlert.NTAlertDelegate = self;
    deletAlert.tag = 100;
    [deletAlert ShowView];

}

-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    NTCustomAlertView * alertView = sender;
    if (alertView.tag == 100)
    {
        if (!tag)
        {
            [_mModel removeAllSelectedGoods];
            [self.MVTableview reloadData];
            NSInteger goodsCount =[_mModel getGoosData];
            [[KGShopCarRedDotView sharedRedDotView]  operationProductToRedDotView:goodsCount];
            [self.MVSettlementView setTotalAmount:[_mModel getBuyTotalAmount]];
            
            
            if (goodsCount==0)
            {
                [self.MVSettlementView resetViews];
                _MVEditButton.selected = false;
                _MVEditButton.hidden  = true;
                
                _mModel.KDEditType =_MVEditButton.selected;
                [self createNoDataView];
            }

        }
      
        
    }
    else if(alertView.tag == 101)
    {
       if(!tag)
       {
           KGAddMerchantsInfoVCTR * vctr = [[KGAddMerchantsInfoVCTR alloc]init];
           [self.navigationController pushViewController:vctr animated:YES];
       }
    }

}
-(void)createTopView
{
    if (_MVEditButton== nil)
    {
        _MVEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVEditButton.frame = CGRectMake(0, 0, 40, 44);
        [_MVEditButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_MVEditButton setTitle:@"完成" forState:UIControlStateSelected];
        _MVEditButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_MVEditButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _MVEditButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_MVEditButton addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -12;
        UIBarButtonItem * rightItem=[[UIBarButtonItem alloc]initWithCustomView:_MVEditButton];
        rightItem.width= -15;
         self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
//        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
}
-(void)clickEdit:(UIButton *)button
{
    button.selected =! button.selected;
    self.MVModel.KDEditType = button.selected;
}
-(void)initData
{
   
    _mModel = [[KGShopCartViewModel alloc]init];
    
}

-(UITableView *)MVTableview
{
    if (_mTableview == nil)
    {
        _mTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.v_width, ScreenHeight-NavigationH-kTabarH ) style:UITableViewStylePlain];
        _mTableview.delegate=self;
        _mTableview.dataSource=self;
        _mTableview.showsVerticalScrollIndicator=NO;
        _mTableview.backgroundColor= LFBNavigationHomeSearchColor;
        _mTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _mTableview.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];

    }
    return _mTableview;
}

-(KGShopSettlementView *)MVSettlementView
{
    if (_MVSettlementView == nil)
    {
        _MVSettlementView  = [[KGShopSettlementView alloc]initWithFrame:CGRectMake(0, ScreenHeight-NavigationH-kTabarH-50  , self.view.v_width, 50)];
        _MVSettlementView.backgroundColor = [UIColor whiteColor];
        _MVSettlementView.KVDelegate = self;
//        _MVSettlementView.backgroundColor = [UIColor redColor];
    }
    return _MVSettlementView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
    return [_mModel getGoosData];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray * array=[self.dataArr objectAtIndex:indexPath.section];
//    KGMineViewModel * model=[array objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"shopCartcell";
    KGShopCartCell * cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[KGShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellSize:CGSizeMake(ScreenWidth, 116)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.KVDelegate = self;
        
    }
     [cell updateViews:[self.MVModel shopGoods:indexPath.row]];
//    [KGShopCartCell cellWithTableview:tableView cellSize:CGSizeMake(ScreenWidth, 116)];
    
    
   
    
//    if (indexPath.row>=1) {
//        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(14, 0, ScreenWidth-14, 0.5)];
//        line.backgroundColor= [UIColor colorWithHexString:@"#d8d8d8"];
//        
//        [cell addSubview:line];
//    }
    return cell;
    
    
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116.0;
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return 86;
//    }
//    
//    return 15.0;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.000001;
//}
-(YZNetworkRequestHelper *)MRequestHelper
{
    if (_MRequestHelper == nil)
    {
        _MRequestHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEPOSTREQUEST];
        _MRequestHelper.YNetworkRequestDelegate = self;
    }
    
    return _MRequestHelper;
}
-(void)begainUserStateNetworkRequest
{
    [self.MRequestHelper beginRequestWithItem:_mModel.KDUserStateRequestItem];
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
////        [KGProgressHUDManager showWithStatus:@"正在加载中"];
//        [KGProgressHUDManager show];
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
            [_mModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
                [weakSelf ProcessingListNetworkBack:state];
            }];
         
            
        }
            
            break;
            
            
            break;
        default:
            break;
    }
    
    
    
    
}
//用于列表
-(void)ProcessingListNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            
//            KGSubmitOrdersVCTR  * vctr = [[KGSubmitOrdersVCTR alloc]init];
//            [self.navigationController pushViewController:vctr animated:YES];
//            return;
            if(_mModel.KDUserAuditState == 1)
            {
                KGSubmitOrdersVCTR  * vctr = [[KGSubmitOrdersVCTR alloc]init];
                [self.navigationController pushViewController:vctr animated:YES];

            }
            else if (_mModel.KDUserAuditState == 2)
            {
                KGUserAuditingAlertView  * alertView = [KGUserAuditingAlertView createAlertView:EN_NTAlertViewStyleCorner];


                [alertView ShowView];
            }
            else if (_mModel.KDUserAuditState == 3 || _mModel.KDUserAuditState == -1)
            {
                KGMissingUserInfoAlertView  * alertView = [KGMissingUserInfoAlertView createAlertView:EN_NTAlertViewStyleCorner];
                alertView.NTAlertDelegate =self;
             alertView.tag = 101;
                [alertView ShowView];
            }
//             else if (_mModel.KDUserAuditState == -1)
//            {
//                KGLogauditAlertView  * alerView = [KGLogauditAlertView createAlertView:EN_NTAlertViewStyleCorner];
//                [alerView setFailMeg:@"完善您的资料信息，才可以购物哦！"];
//                alerView.NTAlertDelegate = self;
//                alerView.tag = 105;
//                [alerView ShowView];
//            }
          
            else
            {
                 [[iToast makeText:@"获取用户信息失败"]show];
            }
            
            
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
            
            [[iToast makeText:@"获取用户信息失败"]show];
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
            if ([failureCode isEqualToString:@"Request failed: unauthorized (401)"])
            {
                [self gotoLog];
            }
            else
            {
                  [[iToast makeText:@"获取用户信息失败"]show];
            }
          

            
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
            [[iToast makeText:@"获取用户信息失败"]show];
            
        }
            break;
            
        default:
            break;
    }
    
}





@end
