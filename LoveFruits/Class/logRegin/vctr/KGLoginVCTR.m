//
//  KGLoginVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLoginVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGLoginModel.h"
#import "AFNetworkReachabilityManager.h"
#import "YZNetworkRequestHelper.h"
#import "YZRequestItem.h"
#import "KGProgressHUDManager.h"
#import "KGResetPwdVCTR.h"
#import "KGReginVCTR.h"
#import "DesUtil.h"
#import "KGUserModelManager.h"
#import "KGLogFailAlertView.h"
#import "iToast.h"
#import "KGMainTabBarController.h"
#import "KGLogauditAlertView.h"
#import "KGLogauditAlertView.h"
#import "KGAddMerchantsInfoVCTR.h"
#import "FeHandwriting.h"
#import "KGAddMerchantsInfoAlertView.h"
@interface KGLoginVCTR()<YZNetworkRequestHelpDelegate,UITextFieldDelegate,NTAlertViewDelegate>
@property (nonatomic,retain)UIView                  * MVLogBgView;
@property (nonatomic,retain)KGLoginModel            * MVModel;
@property (nonatomic,retain)UITextField             * MVAcounTf;
@property (nonatomic,retain)UITextField             * MVPwdTf;
@property (nonatomic,retain)UIButton                * MVLoginBtn;
@property (nonatomic,retain)UIButton                * MVReginBtn;
@property (nonatomic,retain)UIButton                * MVForgetBtn;
@property (nonatomic,retain)YZNetworkRequestHelper  * MRequestHelper;
@property (nonatomic,retain)FeHandwriting           * MVLoadingView;
@end
@implementation KGLoginVCTR
@synthesize  MVLogBgView      = _MVLogBgView;
@synthesize  MVModel          = _MVModel;
@synthesize  MVLoginBtn       = _MVLoginBtn;
@synthesize  MRequestHelper   = _MRequestHelper;
@synthesize  MVReginBtn       = _MVReginBtn;
@synthesize  MVForgetBtn      = _MVForgetBtn;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyBoard];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
  
    self.KVTitleLabel.text = @"登录";
    _MVModel = [[KGLoginModel  alloc]init];
    [self.view addSubview:self.MVLogBgView];
    
    [self createAcountView];
    [self createPwdView];
    [self.view addSubview:self.MVLoginBtn];
    [self.view addSubview:self.MVReginBtn];
    [self.view addSubview:self.MVForgetBtn];
    
    

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
        [_MVLoadingView dismiss];
        [_MVLoadingView removeFromSuperview];
        _MVLoadingView = nil;
    }
}
-(FeHandwriting *)MVLoadingView
{
    if (_MVLoadingView == nil)
    {
        _MVLoadingView = [[FeHandwriting alloc] initWithView:self.view];
        [_MVLoadingView show];
    }
    return _MVLoadingView;
}
-(void)textFiledChange:(UITextField* )tf
{
    if (_MVAcounTf.text.length&&_MVPwdTf.text.length) {
        
        _MVLoginBtn.enabled=YES;
        _MVLoginBtn.selected=YES;
        _MVLoginBtn.backgroundColor= CommonlyUsedBtnColor;
        
    }else
    {
        _MVLoginBtn.enabled=NO;
        _MVLoginBtn.selected=NO;
        _MVLoginBtn.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
        
    }

}
-(void)pressLogBtnCallback
{
    [self initLoginRequestStart];
}
-(void)pressReginBtnCallback
{
    if ([self.navigationController.viewControllers objectAtIndex:1]==self) {
        KGReginVCTR * vctr = [[KGReginVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];

        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}
-(void)pressForgetBtnCallback
{
    KGResetPwdVCTR * vctr = [[KGResetPwdVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}
-(void)initLoginRequestStart
{
    [self requestLogin];
}

-(void)requestLogin
{
    NSMutableDictionary *dic =   self.MVModel.KDLogRequestItem.YRequestDic;
    [dic setValue:_MVAcounTf.text forKey:@"phone"];
    [dic setValue:[DesUtil encryptUseAES:self.MVPwdTf.text] forKey:@"password"];
   
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDLogRequestItem];
}
-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
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
//    [KGProgressHUDManager setSuccessImage:[UIImage imageNamed:@"loading"]];
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
//        [KGProgressHUDManager dismiss];
        [self removeLoadingView];
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
-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            NSString * msg = [jsonDic valueForKey:@"message"];
            KGLogFailAlertView * alertview = [KGLogFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            [alertview setFailMeg:msg];
            [alertview ShowView];
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
            [self ProcessingNetworkBack:YZPROCESSINGDATAERROR];
       
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
            [self OrderLogStatus:self.MVModel.KDLogStatus];
        }
            break;
       
        case YZPROCESSINGDATAFAILT:
        {
            
           
        }
            
        case YZPROCESSINGDATANULL:
        {
            
            
        }
           
        case YZPROCESSINGDATANONE:
        {
           
        }
            
        case YZPROCESSINGDATAERROR:
        {
            KGLogFailAlertView * alertview = [[KGLogFailAlertView alloc]init];
            [alertview setFailMeg:nil];
            [alertview ShowView];
        }
            break;
        default:
            break;
    }
    
}

-(void)OrderLogStatus:(NSInteger )state
{
//    [self enterLogSuccess];
//    return;
    switch (state) {
        case 1:
        {
           
            [self enterLogSuccess];
            /**
             *  Description  登录成功 跳转首页
             */
           
        }
            break;
        case 2:
        {
            //跳转首页 审核中
//             [[iToast makeText:@"商户信息审核中无法购物"] show];
            KGMerchantsInforeviewAlertView * alertview = [KGMerchantsInforeviewAlertView createAlertView:EN_NTAlertViewStyleCorner];

            alertview.NTAlertDelegate = self;
            alertview.tag = 101;
            [alertview ShowView];
//            [self gotoHomePage];
        }
            break;
        case 3:
        {
            /**
             *  Description  弹出 商户信息未审核通过请重新提交 确定 去填写资料 取消跳转首页
             */
            KGLogauditAlertView  * alerView = [KGLogauditAlertView createAlertView:EN_NTAlertViewStyleCorner];
//            [alerView setFailMeg:self.MVModel.KDLogMessage];
            alerView.NTAlertDelegate = self;
            alerView.tag = 100;
            [alerView ShowView];
        }
            break;
        default:
            break;
    }
    
}
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    NTCustomAlertView * alertView = sender;
    if (alertView.tag == 100)
    {
        if (!tag)
        {
            KGAddMerchantsInfoVCTR * vctr = [[KGAddMerchantsInfoVCTR alloc]init];
            [self.navigationController pushViewController:vctr animated:YES];
        }
      

    }
    else
    {
        if (tag)
        {
            NSString* phoneNumberURL = [NSString stringWithFormat: @"tel://4006336900"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberURL]];
        }
        else
        {
             [self gotoHomePage];
        }
       
    }
   
}
-(void)gotoHomePage
{
    [self.navigationController popViewControllerAnimated:false];
    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setSelectIndex:3 withTag:0];
}
-(void)enterLogSuccess
{
    [self gotoHomePage];
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

-(UIView *)MVLogBgView
{
    if (_MVLogBgView == nil)
    {
        _MVLogBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 10 ,ScreenWidth, 96.5)];
        _MVLogBgView.backgroundColor=[UIColor whiteColor];
        UILabel * midline = [[UILabel alloc]init];
        midline.frame = CGRectMake(0, 48, ScreenWidth, 0.5);
        midline.backgroundColor =  [UIColor colorWithHexString:@"#d8d8d8"];
        [_MVLogBgView addSubview:midline];
    }
    return _MVLogBgView;
}

-(void)createAcountView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 0, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"账号";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVLogBgView addSubview:leftLabel];
    [_MVLogBgView addSubview:self.MVAcounTf];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(leftLabel.v_right+0.5, 0, 0.5, 48);
    lineLabel.textColor =  [UIColor colorWithHexString:@"#d8d8d8"];
    [_MVLogBgView addSubview:lineLabel];
   
}
-(void)createPwdView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"密码";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVLogBgView addSubview:leftLabel];
    
    [_MVLogBgView addSubview:self.MVPwdTf];
}
-(UITextField *)MVAcounTf
{
    if (_MVAcounTf == nil)
    {
        _MVAcounTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 0, ScreenWidth-79, 48)];
        _MVAcounTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVAcounTf.delegate=self;
        _MVAcounTf.placeholder=@"请输入您的的手机号";
        _MVAcounTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVAcounTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVAcounTf.borderStyle=UITextBorderStyleNone;
        _MVAcounTf.keyboardType=UIKeyboardTypePhonePad;
        _MVAcounTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVAcounTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVAcounTf;
}
-(UITextField *)MVPwdTf
{
    if (_MVPwdTf == nil)
    {
        _MVPwdTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 48, ScreenWidth-79, 48)];
        _MVPwdTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVPwdTf.delegate=self;
        _MVPwdTf.placeholder=@"请输入登录密码";
        _MVPwdTf.secureTextEntry = YES;
        _MVPwdTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVPwdTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVPwdTf.borderStyle=UITextBorderStyleNone;
        _MVPwdTf.keyboardType=UIKeyboardTypeDefault;
        _MVPwdTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVPwdTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVPwdTf;
}

-(UIButton *)MVLoginBtn
{
    if (_MVLoginBtn == nil)
    {
        _MVLoginBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,self.MVLogBgView.v_bottom+15, ScreenWidth-22, 40)];
        
        _MVLoginBtn.backgroundColor= [UIColor colorWithHexString:@"#cdcdcd"];
        _MVLoginBtn.layer.masksToBounds=YES;
        _MVLoginBtn.layer.cornerRadius=5;
        [_MVLoginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_MVLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVLoginBtn addTarget:self action:@selector(pressLogBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        _MVLoginBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _MVLoginBtn.enabled=NO;
    }
    return _MVLoginBtn;
}

-(UIButton *)MVForgetBtn
{
    if (_MVForgetBtn == nil)
    {
        _MVForgetBtn=[[UIButton alloc]init];
        _MVForgetBtn.titleLabel.font=[UIFont boldSystemFontOfSize:11];

        [_MVForgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_MVForgetBtn.titleLabel sizeToFit];
        _MVForgetBtn.frame = CGRectMake(ScreenWidth-11-_MVForgetBtn.titleLabel.v_width,_MVLoginBtn.v_bottom+10, _MVForgetBtn.titleLabel.v_width, _MVForgetBtn.titleLabel.v_height);
        [_MVForgetBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        [_MVForgetBtn addTarget:self action:@selector(pressForgetBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _MVForgetBtn;
}

-(UIButton *)MVReginBtn
{
    if (_MVReginBtn == nil)
    {
        _MVReginBtn=[[UIButton alloc]init];
        _MVReginBtn.titleLabel.font=[UIFont boldSystemFontOfSize:11];
        [_MVReginBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_MVReginBtn.titleLabel sizeToFit];
        _MVReginBtn.frame = CGRectMake(11,_MVLoginBtn.v_bottom+10, _MVReginBtn.titleLabel.v_width, _MVReginBtn.titleLabel.v_height);
        [_MVReginBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        [_MVReginBtn addTarget:self action:@selector(pressReginBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        
      
    }
    return _MVReginBtn;
}
@end
@implementation KGStartSceneLoginVCTR
-(void)pressReginBtnCallback
{
    KGReginVCTR * vctr = [[KGReginVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
    
}
-(void)gotoHomePage
{
//    [self enterLogSuccess];
}

-(void)enterLogSuccess
{
   
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGSucess object:nil];
}
@end
@implementation KGPresentLoginVCTR : KGLoginVCTR

@end
