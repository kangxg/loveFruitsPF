//
//  KGCheckLogStateVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2017/1/8.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGCheckLogStateVCTR.h"
#import "KGCheckLogStateViewModel.h"
#import "KGLoginVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGProgressHUDManager.h"
#import "YZRequestItem.h"
#import "YZNetworkRequestHelper.h"
#import "UIDevice+Extension.h"
@interface KGCheckLogStateVCTR ()<YZNetworkRequestHelpDelegate>
{
    KGCheckLogStateViewModel   * _mModel;
}
@property (nonatomic,retain)KGCheckLogStateViewModel   *  MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper     *  MRequestHelper;
@property (nonatomic,retain)UIImageView                *  MVBgImageView;
@end

@implementation KGCheckLogStateVCTR
@synthesize  MVModel = _mModel;
-(id)init
{
    if (self = [super init])
    {
        _mModel =[[KGCheckLogStateViewModel alloc]init];
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView:YES];
    if ([_mModel hasLog])
    {
        [self createBgImage];
        [self begainUserStateNetworkRequest];
    }
    else
    {
        
        [self createLogView];
    }
    // Do any additional setup after loading the view.
}

-(void)createBgImage
{
    if (!_MVBgImageView.superview)
    {
        [self.view addSubview:self.MVBgImageView];
    }
      [self.navigationController setNavigationBarHidden:YES animated:false];
}

-(void)removeBgImage
{
    if (_MVBgImageView.superview)
    {
        [_MVBgImageView removeFromSuperview];
        _MVBgImageView = nil;
    }
    [self.navigationController setNavigationBarHidden:false animated:false];
}

-(UIImageView *)MVBgImageView
{
    if (_MVBgImageView == nil)
    {
        _MVBgImageView = [[UIImageView alloc]init];
        _MVBgImageView.frame = ScreenBounds;
        NSString * placeholderImageName = nil;
        int  t  =   [UIDevice currentDeviceScreenMeasurement];
        switch (t)
        {
            case 3:
                placeholderImageName = @"iphone4";
                break;
                
            case 4:
                placeholderImageName = @"iphone5";
                break;
                
            case 5:
                placeholderImageName = @"iphone6";
                break;
                
            default:
                placeholderImageName = @"iphone6s";
                
                break;
        }
        _MVBgImageView.image = [UIImage imageNamed:placeholderImageName];
    }
    return _MVBgImageView;
}
-(void)createLogView
{
    self.KVTitleLabel.text = @"登录";
    KGStartSceneLoginVCTR * logview = [[KGStartSceneLoginVCTR alloc]init];
    [self addChildViewController:logview];
    [self.view addSubview:logview.view];
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
//    
}

/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
    
    if (![KGProgressHUDManager isVisible])
    {
        
        [KGProgressHUDManager show];
    }
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
        [KGProgressHUDManager dismiss];
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
                [[NSNotificationCenter defaultCenter]postNotificationName:LOGSucess object:nil];
                
              
                
            }
        
            else
            {
                [self removeBgImage];
                [self createLogView];
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
            
            [self removeBgImage];
            [self createLogView];
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
            [self removeBgImage];
            [self createLogView];
            
            
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
            [self removeBgImage];
            [self createLogView];
            
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
