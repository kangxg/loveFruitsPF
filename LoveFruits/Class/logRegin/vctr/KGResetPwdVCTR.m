//
//  KGResetPwdVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGResetPwdVCTR.h"
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
#import "KGReginBaseAlertView.h"
#import <SMS_SDK/SMSSDK.h>
#import "KGResetPwdModel.h"
#import "DesUtil.h"
#import "KGUserModelManager.h"
#import "KGLogFailAlertView.h"
#import "KGLoginVCTR.h"
@interface KGResetPwdVCTR()<YZNetworkRequestHelpDelegate,UITextFieldDelegate,NTAlertViewDelegate>
{
    NSInteger     _mCount;
    NSString   *  _mPhoneNum;
}
@property (nonatomic,retain)UIView           * MVRegBgView;
@property (nonatomic,retain)UITextField      * MVAcounTf;
@property (nonatomic,retain)UITextField      * MVPwdTf;
@property (nonatomic,retain)UITextField      * MVVerCodeTf;
@property (nonatomic,retain)UIButton         * MVSendCodeBtn;
@property (nonatomic,retain)UIButton         * MVEnterBtn;
@property (nonatomic,retain)KGResetPwdModel  * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@end
@implementation KGResetPwdVCTR
@synthesize  MVRegBgView   = _MVRegBgView;
@synthesize  MVAcounTf     = _MVAcounTf;
@synthesize  MVVerCodeTf   = _MVVerCodeTf;
@synthesize  MVPwdTf       = _MVPwdTf;
@synthesize  MVEnterBtn    = _MVEnterBtn;
@synthesize  MVSendCodeBtn = _MVSendCodeBtn;
@synthesize  MVModel       = _MVModel;
@synthesize  MRequestHelper = _MRequestHelper;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyBoard];
}
-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
  
    self.KVTitleLabel.text = @"重置密码";
    _MVModel = [[KGResetPwdModel alloc]init];
    [self.view addSubview:self.MVRegBgView];
    [self createAcountView];
    [self createVerificationCodeView];
    [self createPwdView];

    
    [self.view addSubview:self.MVEnterBtn];
    
}
//点击发送验证码
-(void)clickSendCode
{

    _mPhoneNum=[_MVAcounTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // BOOL isValid = [predicate evaluateWithObject:_phoneNum];
    if ([_MVAcounTf.text isEqualToString:@""]) {
        
        [CCommonClass msgHint:@"请输入有效的手机号码" dismissAfter:1.0];
        
    }
    
    else
    {
        
        //?mobilePhone=%@
        
        //         [self getPhoneCode];
        BOOL haveNet=[self judgeIsNeedRequest];
        if (haveNet) {
            
            
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_mPhoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
                if (!error) {
                    NSLog(@"获取验证码成功");
                } else {
                    NSLog(@"错误信息：%@",error);
                }
            }];

      
                       
            [self getPhoneCode];
            
            
        }else
        {
            
            [[iToast makeText:@"似乎已断开与互联网的连接"] show];
            
            
        }
        
        
    }
    
}
- (void)getPhoneCode
{
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_MVSendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //                _MVSendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
                [_MVSendCodeBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
                
                _MVSendCodeBtn.userInteractionEnabled = YES;
                _MVSendCodeBtn.enabled=YES;
                _MVSendCodeBtn.selected=NO;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"获取验证码(%.2d秒)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [_MVSendCodeBtn setTitleColor:[UIColor colorWithHexString:@"#ffae02"] forState:UIControlStateNormal];
                
                //                 _MVSendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
                [_MVSendCodeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                
                _MVSendCodeBtn.enabled=NO;
                _MVSendCodeBtn.selected=YES;
                _MVSendCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)pressEnterBtnCallback
{
    if ([_MVAcounTf.text isEqualToString:@""] || _mPhoneNum.length != 11) {
        
        [CCommonClass msgHint:@"请输入有效的手机号码"  dismissAfter:1.0];
        return;
    }
    
    else if(_MVPwdTf.text.length==0)
    {
        
        [CCommonClass msgHint:@"请输入密码" dismissAfter:1.0];
        return;
        
    }
    else if(_MVVerCodeTf.text.length==0||_MVVerCodeTf.text==nil)
    {
        
        [CCommonClass msgHint:@"请输入验证码" dismissAfter:1.0];
        return;
        
    }
    else
    {
        [self initResetRequestStart];
    }

}

-(void)initResetRequestStart
{
    [self requestRegin];
}
-(void)requestRegin
{
    NSMutableDictionary *dic =   self.MVModel.KDRequestItem.YRequestDic;
    [dic setValue:_mPhoneNum forKey:@"phone"];
    [dic setValue:[DesUtil encryptUseAES:self.MVPwdTf.text] forKey:@"password"];
//    [dic setValue:self.MVInvCodeTf forKey:@"inviter"];
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDRequestItem];
}
-(BOOL)judgeIsNeedRequest
{
    
    return [[AFNetworkReachabilityManager sharedManager]isReachable];
    
}
-(void)textFiledChange:(UITextField* )tf
{
    
    if (tf==_MVAcounTf) {
        
        if (tf.text.length>_mCount) {
            
            if (_mCount==3||_mCount==8) {
                
                NSMutableString * str=[NSMutableString stringWithFormat:@"%@",tf.text];
                [str insertString:@" " atIndex:_mCount];
                
                tf.text=str;
            }
        }
        
        else if(_mCount>tf.text.length)
        {
            if (_mCount==5||_mCount==10) {
                
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@",tf.text];
                tf.text = [str substringToIndex:_mCount -2];
                
            }
            
            
        }
        
        _mCount=tf.text.length;
        
    }
    
    
    if (_MVAcounTf.text.length&&_MVPwdTf.text.length>=6&&_MVVerCodeTf.text.length ) {
        
        _MVEnterBtn.enabled=YES;
        _MVEnterBtn.selected=YES;
        _MVEnterBtn.backgroundColor= CommonlyUsedBtnColor;
        
    }else
    {
        _MVEnterBtn.enabled=NO;
        _MVEnterBtn.selected=NO;
        _MVEnterBtn.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
        
    }
    
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.textInputMode.primaryLanguage isEqualToString:@"emoji"]) {
        
        return NO;
    }
    if (textField==_MVAcounTf) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        
        if (existedLength - selectedLength + replaceLength > 13) {
            return NO;
        }
    }
    
    if (textField==_MVPwdTf) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        
        if (existedLength - selectedLength + replaceLength > 16) {
            return NO;
        }
        
    }
    
    
    return YES;
    
    
}

-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
            [self.MVModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
                [weakSelf ProcessingOrderStatusBack:state];
                
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
            KGReginBaseAlertView * alertView = [KGReginBaseAlertView createAlertView:EN_NTAlertViewStyleCorner];
            //            alertView.NTAlertDelegate = self;
            [alertView ShowView];
            //            [self.MRequestHelper beginRequestWithItem:requestItem];
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
            NSString * message =[jsonDic valueForKey:@"message"];
            if (message.length)
            {
                [[iToast makeText:message]show];
            }
            else
            {
                [[iToast makeText:@"设置失败，请重试！"]show];
            }
           
        }
            break;
            
        default:
            break;
    }
    
}
-(void)ProcessingOrderStatusBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            KGLogFailAlertView * alertView = [KGLogFailAlertView  createAlertView:EN_NTAlertViewStyleCorner];
            alertView.NTAlertDelegate = self;
            [alertView setFailMeg:@"密码修改成功！"];
            [alertView.NTALertEnterButton setTitle:@"确定" forState:UIControlStateNormal];
            [alertView ShowView];
        }
            break;
        case YZPROCESSINGDATAERROR:
        {
           
        }
           
        case YZPROCESSINGDATAFAILT:
        {
           
        }
        case YZPROCESSINGDATANULL:
        {
           
            
        }
            break;
        case YZPROCESSINGDATANONE:
        {
           [[iToast makeText:@"设置失败，请重试！"]show];
        }
            break;
        default:
            break;
    }
    
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
-(UIView *)MVRegBgView
{
    if (_MVRegBgView == nil)
    {
        _MVRegBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 5 ,ScreenWidth, 144)];
        _MVRegBgView.backgroundColor=[UIColor whiteColor];
        for (int i = 1; i<3; i++)
        {
            UILabel * midline = [[UILabel alloc]init];
            midline.frame = CGRectMake(0, 48*i, ScreenWidth, 0.5);
            midline.backgroundColor =  [UIColor colorWithHexString:@"#d8d8d8"];
            [_MVRegBgView addSubview:midline];
        }
        
    }
    return _MVRegBgView;
}

-(void)createAcountView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 0, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"账号";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    [_MVRegBgView addSubview:self.MVAcounTf];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(leftLabel.v_right+0.5, 0, 0.5, 48);
    lineLabel.textColor =  [UIColor colorWithHexString:@"#d8d8d8"];
    [_MVRegBgView addSubview:lineLabel];
    [_MVRegBgView addSubview:self.MVSendCodeBtn];
}
-(void)createVerificationCodeView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"验证码";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVVerCodeTf];
}

-(void)createPwdView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48*2, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"密码";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVPwdTf];
}

-(UIButton *)MVEnterBtn
{
    if (_MVEnterBtn == nil)
    {
        _MVEnterBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,self.MVRegBgView.v_height+15, ScreenWidth-22, 40)];
        
        _MVEnterBtn.backgroundColor= [UIColor colorWithHexString:@"#cdcdcd"];
        _MVEnterBtn.layer.masksToBounds=YES;
        _MVEnterBtn.layer.cornerRadius=5;
        [_MVEnterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_MVEnterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVEnterBtn addTarget:self action:@selector(pressEnterBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        _MVEnterBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _MVEnterBtn.enabled=NO;
    }
    return _MVEnterBtn;
}

-(UIButton *)MVSendCodeBtn
{
    if (_MVSendCodeBtn == nil)
    {
        _MVSendCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.MVRegBgView.v_width-97, 0, 97, 48)];
        [_MVSendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _MVSendCodeBtn.backgroundColor  = [UIColor colorWithHexString:@"#fafafa"];
        [_MVSendCodeBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        //        _MVSendCodeBtn.titleLabel.numberOfLines = 0;
        _MVSendCodeBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_MVSendCodeBtn addTarget:self action:@selector(clickSendCode) forControlEvents:UIControlEventTouchUpInside];
        _MVSendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _MVSendCodeBtn;
}

-(UITextField *)MVAcounTf
{
    if (_MVAcounTf == nil)
    {
        _MVAcounTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 0, ScreenWidth-68-98, 48)];
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
-(UITextField *)MVVerCodeTf
{
    if (_MVVerCodeTf == nil)
    {
        _MVVerCodeTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 48, ScreenWidth-79, 48)];
        _MVVerCodeTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVVerCodeTf.delegate=self;
        _MVVerCodeTf.placeholder=@"请输入您的邀请码";
        _MVVerCodeTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVVerCodeTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVVerCodeTf.borderStyle=UITextBorderStyleNone;
        _MVVerCodeTf.keyboardType=UIKeyboardTypePhonePad;
        _MVVerCodeTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVVerCodeTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVVerCodeTf;
}

-(UITextField *)MVPwdTf
{
    if (_MVPwdTf == nil)
    {
        _MVPwdTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 48*2, ScreenWidth-79, 48)];
        _MVPwdTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVPwdTf.delegate=self;
        _MVPwdTf.placeholder=@"请输入6-16位密码";
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


@end
