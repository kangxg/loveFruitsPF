//
//  KGMineVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/3.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMineVCTR.h"
#import "KGLoginVCTR.h"
#import "KGReginVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "CCommonClass.h"
#import "AFNetworkReachabilityManager.h"
#import "iToast.h"
#import "YZNetworkRequestHelper.h"
#import "KGReginModel.h"
#import "YZRequestItem.h"
#import "KGProgressHUDManager.h"
#import "KGMineViewModel.h"
#import "KGMineViewGroup.h"
#import "KGSettingVCTR.h"
#import "KGManagerShipingAddressVCTR.h"
#import "KGPersonalCenterVCTR.h"
#import "KGMyOrdersVCTR.h"
#import "KGMineLogVCTR.h"
#import "KGUserModelManager.h"
#import "KGSystemMessageVCTR.h"
#import "KGMineViewModel.h"
#import "iToast.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"
#import "KGCouponVCTR.h"
#import "KGOrderDetalVCTR.h"
#import "FeThreeDotGlow.h"
@interface KGMineVCTR()<KGMineViewDeletate,YZNetworkRequestHelpDelegate>
{
    UIImageView * _mHeadView;
    UIImageView * _mHeadImage;
    NSArray     * _mBtnNameArr;
    UILabel     * _mNameLabel;
   
}
@property(strong,nonatomic)KGMineViewGroup * MVView;
@property (nonatomic,retain)KGMineLogVCTR  * MVLogView;
@property (nonatomic,retain)UIButton       * MVSettingBtn;
@property (nonatomic,retain)KGMineViewModel * MVModel;

@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@property (nonatomic,retain)FeThreeDotGlow           * MVLoadingView;
@end
@implementation KGMineVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
     [self setBackView:YES];
    //ddd
    self.KVTitleLabel.text = @"个人中心";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOrderDetailView:) name:@"showOrderDetail" object:nil];
    _MVModel = [[KGMineViewModel alloc]init];
    [self createView];
//    self.view.backgroundColor = [UIColor orangeColor];
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor blueColor];
//    [btn setTitle:@"登录" forState:UIControlStateNormal];
//    btn.frame = CGRectMake(40, 70, 60, 30);
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.backgroundColor = [UIColor blueColor];
//    btn1.frame = CGRectMake(140, 70, 60, 30);
//    [self.view addSubview:btn1];
//    [btn1 setTitle:@"注册" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(regin) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showOrderDetailView:(NSNotification *)notify
{
    KGOverOrderDetalVCTR  * vctr = [[KGOverOrderDetalVCTR alloc]init];
    vctr.KVOrderId = notify.object;
    [self.navigationController pushViewController:vctr animated:YES];
    
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
-(FeThreeDotGlow  *)MVLoadingView
{
    if (_MVLoadingView == nil)
    {
        _MVLoadingView = [[FeThreeDotGlow  alloc] initWithView:self.view blur:NO];
        
    }
    return _MVLoadingView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[KGUserModelManager shareInstanced] getUserModel] == nil ||![[KGUserModelManager shareInstanced] getUserModel].KUserId ) {
        if (_MVLogView == nil)
        {
            _MVLogView = [[KGMineLogVCTR alloc]init];
            [self addChildViewController:_MVLogView];
            [self.view addSubview:_MVLogView.view];
            
        }
        _mNameLabel.text= @"";
        _MVSettingBtn.hidden = YES;
    }
    else
    {
        [_MVLogView.view removeFromSuperview];
        [_MVLogView removeFromParentViewController];
        _MVLogView = nil;
        _MVSettingBtn.hidden = false;
        if (_MVModel.UserName)
        {
            _mNameLabel.text      = _MVModel.UserName;
        }
        [self initGetCoupontNetWork];
    }
}
-(void)regin
{
    KGReginVCTR *  vctr  = [[KGReginVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}
-(void)login
{
    KGLoginVCTR * Vctr = [[ KGLoginVCTR alloc]init];
    [self.navigationController pushViewController:Vctr animated:YES];
}

-(void)createView
{
    [self creatNavView];
    NSMutableArray * dataArr=[NSMutableArray array];
    
    //@"小椅宝典",@[@"我的职场币"],@[@"icon_money"]@[@"金币充值",@"我的收益"],@[@"m_money",@"m_shouyi"],
    NSArray * nameArr=@[@[@"我的订单",@"消息"]];
    NSArray*imageArr=@[@[@"order",@"xiaoxi"]];
    
    for (int i=0; i<nameArr.count; i++) {
        NSArray * arr=[nameArr objectAtIndex:i];
        NSArray * imags=[imageArr objectAtIndex:i];
        NSMutableArray * littleDataArr=[NSMutableArray array];
        
        for (int j=0; j<arr.count; j++) {
            KGMineViewModel * model=[[KGMineViewModel alloc]init];
            model.name=[arr objectAtIndex:j];
            model.imageName=[imags objectAtIndex:j];
            [littleDataArr addObject:model];
        }
        [dataArr addObject:littleDataArr];
    }
   
    _MVView=[KGMineViewGroup initWithSuperView:self.view frame:CGRectMake(0, 0, ScreenHeight, ScreenHeight- kTabarH) dataArr:dataArr delegate:self];
    
    [self createHeaView];
}
-(void)clickBtnIndex:(NSInteger)index
{
    if (index == 1)
    {
        KGCouponVCTR  * vctr = [[KGCouponVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
}
-(void)creatNavView
{
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
    [rightBtn addTarget:self action:@selector(navBtnCallback) forControlEvents:UIControlEventTouchUpInside];
    _MVSettingBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

}

-(void)navBtnCallback
{
    KGSettingVCTR * vctr = [[KGSettingVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}
-(void)createHeaView
{
    _mBtnNameArr=@[@"余额",@"优惠券",@"积分"];
     [_MVView setTopNameArr:_mBtnNameArr countArr:nil];
    _mHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    _mHeadView.image = [UIImage imageNamed:@"mine_head_bg"];
    
    _mHeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(11,16, 56, 56)];
    _mHeadImage.layer.masksToBounds=YES;
    _mHeadImage.layer.cornerRadius=_mHeadImage.frame.size.height/2;
    _mHeadImage.image=[UIImage imageNamed:@"defail_myIcon"];
    _mHeadImage.layer.borderColor = [UIColor orangeColor].CGColor;
    _mHeadImage.layer.borderWidth = 2.0f;
    [_mHeadView addSubview:_mHeadImage];
    
    _mNameLabel = [[UILabel alloc]init];
    _mNameLabel.frame = CGRectMake(_mHeadImage.v_right+13, 35, _mHeadView.v_width-_mHeadImage.v_right-13-40, 20);
    _mNameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _mNameLabel.font      = [UIFont systemFontOfSize:16.0f];
    if (_MVModel.UserName)
    {
        _mNameLabel.text      = _MVModel.UserName;
    }
    
    
    [_mHeadView addSubview:_mNameLabel];
    
    UIImageView * direcImageView = [[UIImageView alloc]init];
    UIImage     * dimage = [UIImage imageNamed:@"mine_head_enter"];
    direcImageView.image = dimage;
    direcImageView.frame = CGRectMake(_mHeadView.v_width-11-dimage.size.width, (90-dimage.size.height)/2, dimage.size.width, dimage.size.height);
    [_mHeadView addSubview:direcImageView];
    [_MVView setHeadView:_mHeadView];
    
    UITapGestureRecognizer  * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToMySelfView)];
    _mHeadView.userInteractionEnabled = YES;
    [_mHeadView addGestureRecognizer:tap];
}
-(void)goToMySelfView
{
    KGPersonalCenterVCTR  * vctr = [[KGPersonalCenterVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}
-(void)selectedMyViewControllerIndex:(NSString *)titleName
{
    if ([titleName isEqualToString:@"我的订单"])
    {
        KGMyOrdersVCTR * vctr = [[KGMyOrdersVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
    else if ([titleName isEqualToString:@"收货地址"])
    {
        KGManagerShipingAddressVCTR * vctr = [[KGManagerShipingAddressVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
    else if ([titleName isEqualToString:@"设置"])
    {
        KGSettingVCTR * vctr = [[KGSettingVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
    else if([titleName isEqualToString:@"消息"])
    {
        KGSystemMessageVCTR * vctr  = [[KGSystemMessageVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
    else if([titleName isEqualToString:@"退出当前账号"])
    {
        KGUserModelManager * manager = [KGUserModelManager shareInstanced];
        [manager exitLogin];
        
        if (_MVLogView == nil)
        {
            _MVLogView = [[KGMineLogVCTR alloc]init];
            [self addChildViewController:_MVLogView];
            [self.view addSubview:_MVLogView.view];
             _MVSettingBtn.hidden = YES;
            
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:LOGOut  object:nil];
    }

}


-(void)initGetCoupontNetWork
{
    [self.MRequestHelper beginRequest:@[_MVModel.KDCouponUnuseRequestItem]];
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
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingNetworkBack:state withType:type];
            }];
            
            
        }
            
            break;
        case YZNETWORKVERIFICATIONSEC:
        {
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingUserAdressNetworkBack:state];
            }];
        }
            
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf.MVView resetCouponView:weakSelf.MVModel.KDHaveCouponCount];
            }];
        }
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
            //            if ([[jsonDic valueForKey:@"message"] isEqualToString:@"手机号已注册"])
            //            {
            //                KGReginedAlertView * alertView = [KGReginedAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //                alertView.NTAlertDelegate = self;
            //                alertView.tag = 100;
            //                [alertView ShowView];
            //            }
            //            else
            //            {
            //                KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //
            //                [alertView ShowView];
            //            }
            
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)ProcessingNetworkBack:(YZProcessingDataState )state withType:(NSInteger)type
{
    switch (type) {
        case YZNETWORKVERIFICATIONFIR:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)ProcessingUserAdressNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self createView];
            
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
            [[iToast makeText:@"获取用户信息失败"]show];
            [self.navigationController popViewControllerAnimated:YES];
            //            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //            
            //            [alertView ShowView];
        }
            break;
            
            
            
        default:
            break;
    }
    
}

@end
