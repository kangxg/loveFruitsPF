//
//  KGProductDetailsVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsVCTR.h"
#import "KGProductDetailsHeadView.h"
#import "KGProductDetailsBuyView.h"
#import "KGProductDetailsdescriptionView.h"
#import "YZNetworkRequestHelper.h"
#import "YZRequestItem.h"
#import "KGShoppingCarView.h"
#import "KGProgressHUDManager.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "KGMainTabBarController.h"
#import "KGUserShopCarTool.h"
#import "KGShopCarRedDotView.h"
@interface KGProductDetailsVCTR ()<YZNetworkRequestHelpDelegate,KGBaseViewDelegate>
@property (nonatomic,retain)KGProductDetailsHeadView         * MVHeadView;
@property (nonatomic,retain)KGProductDetailsBuyView          * MVBuyView;
@property (nonatomic,retain)KGShoppingCarView                * MVCardView;
@property (nonatomic,retain)KGProductDetailsdescriptionView  * MVDescriptionView;
@property (nonatomic,retain)YZNetworkRequestHelper           * MRequestHelper;
@property (nonatomic,retain)UIScrollView                     * MVScrollView;
@property (nonatomic,retain)NSMutableArray <CALayer *>       * MAnimationLayers;
@end
@implementation KGProductDetailsVCTR
@synthesize YMModel             = _YMModel;
@synthesize YMProductId         = _YMProductId;
@synthesize MVHeadView          = _MVHeadView;
@synthesize MVBuyView           = _MVBuyView;
@synthesize MVDescriptionView   = _MVDescriptionView;
@synthesize MRequestHelper      = _MRequestHelper;
@synthesize MVCardView          = _MVCardView;
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _MVHeadView.frame =CGRectMake(0, 0, _MVScrollView.v_width, 172);
    _MVBuyView.frame =CGRectMake(0, _MVHeadView.v_bottom, _MVScrollView.v_width, 48);
    _MVDescriptionView.frame = CGRectMake(0, _MVBuyView.v_bottom, _MVScrollView.v_width, _MVDescriptionView.v_height);
    _MVScrollView.contentSize = CGSizeMake(ScreenWidth, _MVDescriptionView.v_bottom);
    
    _MVCardView.frame = CGRectMake(self.view.v_width-72, self.view.v_height-91, 61, 61);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=false;
//    [self.navigationController setNavigationBarHidden:false animated:false];
//    [self.navigationController setNavigationBarHidden:YES animated:false];
    
}
-(UIScrollView *)MVScrollView
{
    if (_MVScrollView == nil)
    {
       _MVScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, ScreenHeight-NavigationH)];
        _MVScrollView.showsVerticalScrollIndicator=NO;
//        _MVScrollView.bounces = false;
        _MVScrollView.backgroundColor = [UIColor whiteColor];

    }
    return _MVScrollView;
}
-(KGProductDetailsHeadView *)MVHeadView
{
    if (_MVHeadView == nil)
    {
        _MVHeadView = [[KGProductDetailsHeadView alloc]initWithFrame:CGRectZero];
//        [_MVHeadView updateView:nil];
        //CGRectMake(0, 0, _MVScrollView.v_width, 172)
    }
    return _MVHeadView;
}
-(KGProductDetailsBuyView *)MVBuyView
{
    if (_MVBuyView == nil)
    {
        _MVBuyView = [[KGProductDetailsBuyView alloc]initWithFrame:CGRectZero];
        _MVBuyView.KVDelegate = self;
        [_MVBuyView updateView:nil];
//        _MVBuyView.backgroundColor = [UIColor redColor];
        //CGRectMake(0, 172, _MVScrollView.v_width, 48)
        
    }
    return _MVBuyView;
}

-(KGProductDetailsdescriptionView *)MVDescriptionView
{
    if (_MVDescriptionView == nil)
    {
        _MVDescriptionView = [[KGProductDetailsdescriptionView alloc]initWithFrame:CGRectZero];
        [_MVDescriptionView updateView:nil];
    }
    return _MVDescriptionView;

}

-(KGShoppingCarView *)MVCardView
{
    if (_MVCardView == nil)
    {
        _MVCardView = [[KGShoppingCarView alloc]initWithFrame:CGRectZero];
        _MVCardView.KVDelegate = self;
    }
    return _MVCardView;
}
-(id)init
{
    if (self = [super init ])
    {
        _YMModel = [[KGProductDetailsViewModel alloc]init];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    [self.view addSubview:self.MVScrollView];
    [self.MVScrollView addSubview:self.MVHeadView];
    [self.MVScrollView addSubview:self.MVBuyView];
    [self.MVScrollView addSubview:self.MVDescriptionView];
    [self.view addSubview:self.MVCardView];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"商品详情";

    
    if (_YMProductId.length)
    {
        [self initloadRequestStart];
    }
}
-(void)pGotoShoppingCar:(id)sender
{
//    [self.navigationController popViewControllerAnimated:false];
    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setSelectIndex:0 withTag:2];
}
-(void)pAddOperation:(id)sender
{
    UIImageView * imageView=_MVHeadView.KVProductImageView;
    if(imageView == nil)
    {
        return;
    }
    if (_MAnimationLayers == nil)
    {
        _MAnimationLayers = [[NSMutableArray alloc]init];
    }
    CGRect  frame = [imageView convertRect:imageView.bounds toView:self.view];
    
    CALayer *  transitionLayer = [CALayer layer];
    
    transitionLayer.frame = frame;
    
    transitionLayer.contents = imageView.layer.contents;
    
    [self.view.layer addSublayer:transitionLayer];
    
    [_MAnimationLayers  addObject:transitionLayer];
    
    CGPoint p1 = transitionLayer.position;
    float width = _MVCardView.v_width;
    //self.view.frame.size.width;
    CGPoint p3 = CGPointMake(self.view.v_width-11 - width/2 - width / 8 , _MVCardView.v_y);
    
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path  = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, p1.x, p1.y);
    CGPathAddCurveToPoint(path, nil, p1.x, p1.y -30, p3.x, p1.y - 30, p3.x, p3.y);
    positionAnimation.path = path;
    
    CABasicAnimation * opacityAnimation =  [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.5);
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = true;
    
    CABasicAnimation * transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    transformAnimation.fromValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
    
    
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.1, 0.2, 1)];
    
    
    CAAnimationGroup *  groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    [transitionLayer addAnimation:groupAnimation forKey:@"cartParabola"];

}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.MAnimationLayers.count)
    {
        CALayer *  transitionLayer = _MAnimationLayers[0];
        transitionLayer.hidden = YES;
        
        [transitionLayer removeFromSuperlayer];
        [_MAnimationLayers removeObject:_MAnimationLayers.firstObject];
        [self.view.layer removeAnimationForKey:@"cartParabola"];
        [_MVCardView startAnimtion];
        
        [[KGShopCarRedDotView sharedRedDotView] addProductToRedDotView:true];
        [[KGUserShopCarTool sharedUserShopCar] addSupermarkProductToShopCar:(id)self.YMModel.KDProductModel];
        [[NSNotificationCenter defaultCenter]postNotificationName:LFBShopCarBuyPriceDidChangeNotification object:nil];
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
    NSDictionary * dic = self.YMModel.KDRequestItem.YRequestDic;
    [dic setValue:_YMProductId forKey:@"pid"];
    [self.MRequestHelper beginRequestWithItem:self.YMModel.KDRequestItem];
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
            [self.YMModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
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
            if ([[jsonDic valueForKey:@"message"] isEqualToString:@"手机号已注册"])
            {
                //                KGReginedAlertView * alertView = [KGReginedAlertView createAlertView:EN_NTAlertViewStyleCorner];
                //                alertView.NTAlertDelegate = self;
                //                alertView.tag = 100;
                //                [alertView ShowView];
            }
            else
            {
                //                KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
                //
                //                [alertView ShowView];
            }
            
            
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
            //            KGAddMerchantsInfoVCTR * vctr = [[KGAddMerchantsInfoVCTR alloc]init];
            //            [self.navigationController pushViewController:vctr animated:YES];
            [self.MVHeadView updateView:self.YMModel.KDProductModel];
            [self.MVBuyView updateView:self.YMModel.KDProductModel];
            [self.MVDescriptionView updateView:self.YMModel.KDProductModel];
            
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




@end
