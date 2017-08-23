//
//  KGReginVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

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
#import "KGReginBaseAlertView.h"

#import "KGAddMerchantsInfoVCTR.h"
#import <SMS_SDK/SMSSDK.h>
#import "DesUtil.h"
#import "KGUserModelManager.h"
#import "KGLoginVCTR.h"
@interface KGReginVCTR()<YZNetworkRequestHelpDelegate,UITextFieldDelegate,NTAlertViewDelegate>
{
    NSInteger     _mCount;
    NSString   *  _mPhoneNum;
}
@property (nonatomic,retain)UIView       * MVRegBgView;
@property (nonatomic,retain)UITextField  * MVAcounTf;
@property (nonatomic,retain)UITextField  * MVVerCodeTf;
@property (nonatomic,retain)UITextField  * MVPwdTf;
@property (nonatomic,retain)UITextField  * MVInvCodeTf;
@property (nonatomic,retain)UIButton     * MVReginBtn;
@property (nonatomic,retain)UIButton     * MVTreatyBtn;
@property (nonatomic,retain)UIButton     * MVSendCodeBtn;
@property (nonatomic,retain)KGReginModel * MVModel;
@property (nonatomic,retain)YZNetworkRequestHelper   * MRequestHelper;
@end

@implementation KGReginVCTR
@synthesize  MVRegBgView   = _MVRegBgView;
@synthesize  MVAcounTf     = _MVAcounTf;
@synthesize  MVVerCodeTf   = _MVVerCodeTf;
@synthesize  MVPwdTf       = _MVPwdTf;
@synthesize  MVInvCodeTf   = _MVInvCodeTf;
@synthesize  MVReginBtn    = _MVReginBtn;
@synthesize  MVTreatyBtn   = _MVTreatyBtn;
@synthesize  MVSendCodeBtn = _MVSendCodeBtn;
@synthesize  MVModel       = _MVModel;
@synthesize  MRequestHelper = _MRequestHelper;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyBoard];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.KVTitleLabel.text = @"注册";
    _MVModel = [[KGReginModel alloc]init];
    [self.view addSubview:self.MVRegBgView];
    [self createAcountView];
    [self createVerificationCodeView];
    [self createPwdView];
    [self createInviteCodeView];
    
    [self.view addSubview:self.MVReginBtn];
    [self createTreatyView];
    
   
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
    
    
    if (_MVAcounTf.text.length&&_MVPwdTf.text.length>=6&&_MVVerCodeTf.text.length && _MVInvCodeTf.text.length) {
        
        _MVReginBtn.enabled=YES;
        _MVReginBtn.selected=YES;
        _MVReginBtn.backgroundColor= CommonlyUsedBtnColor;
        
    }else
    {
        _MVReginBtn.enabled=NO;
        _MVReginBtn.selected=NO;
        _MVReginBtn.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
        
    }
    
    
    
}

//点击发送验证码
-(void)clickSendCode
{
//    KGReginBaseAlertView * alertView = [KGReginBaseAlertView createAlertView:EN_NTAlertViewStyleCorner];
//    //            alertView.NTAlertDelegate = self;
//    [alertView ShowView];
//    KGReginFailAlertView * alert = [ KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
//    [alert ShowView];
    //KGAddMerchantsInfoVCTR * vctr = [[KGAddMerchantsInfoVCTR alloc]init];
//    [self.navigationController pushViewController:vctr animated:YES];
//    return;
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
            
            
            NSLog(@"sms版本%@",[SMSSDK SMSSDKVersion]);
            //链接服务器
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
                [_MVSendCodeBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];

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

//点击注册按钮
-(void)pressRegBtnCallback
{
    
    _mPhoneNum=[_MVAcounTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // BOOL isValid = [predicate evaluateWithObject:_phoneNum];
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

    else if(_MVInvCodeTf.text.length==0||_MVInvCodeTf.text==nil)
    {
        
        [CCommonClass msgHint:@"请输入邀请码" dismissAfter:1.0];
        return;
        
    }
    
    else {
  
        NSString * str = _MVVerCodeTf.text;
        KGWEAKOBJECT(weakSelf);
        [SMSSDK commitVerificationCode:str phoneNumber:_mPhoneNum zone:@"86" result:^(NSError *error) {
            if (!error)
            {
                [weakSelf initReginRequestStart];
            }
            else
            {
                
                
                [[iToast makeText:[error.userInfo valueForKey:@"commitVerificationCode"]]show];
                NSLog(@"错误信息:%@",error);
            }

        }];
     
                
        
        
    }
}

-(void)initReginRequestStart
{
    [self requestRegin];
}

-(void)requestRegin
{
    
    NSMutableDictionary *dic =   self.MVModel.KDRegRequestItem.YRequestDic;
    [dic setValue:_mPhoneNum forKey:@"phone"];
    [dic setValue:[DesUtil encryptUseAES:self.MVPwdTf.text] forKey:@"password"];
    [dic setValue:self.MVInvCodeTf forKey:@"inviter"];
    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDRegRequestItem];
}
-(BOOL)judgeIsNeedRequest
{
   
    return [[AFNetworkReachabilityManager sharedManager]isReachable];
    
}
-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
}
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    KGReginBaseAlertView  * view = sender;
    switch (view.tag)
    {
        case 100:
        {
            KGLoginVCTR * logVCTR = [[KGLoginVCTR alloc]init];
            [self.navigationController pushViewController:logVCTR animated:YES];
        }
            break;
        case 105:
        {
            KGAddMerchantsInfoVCTR * vctr = [[KGAddMerchantsInfoVCTR alloc]init];
            [self.navigationController pushViewController:vctr animated:YES];
        }
            break;
        default:
            break;
    }
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
            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
//            alertView.NTAlertDelegate = self;
            [alertView ShowView];

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
                KGReginedAlertView * alertView = [KGReginedAlertView createAlertView:EN_NTAlertViewStyleCorner];
                alertView.NTAlertDelegate = self;
                alertView.tag = 100;
                [alertView ShowView];
            }
            else
            {
                KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
             
                [alertView ShowView];
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
            KGReginSuccessAlertView * alertView = [KGReginSuccessAlertView createAlertView:EN_NTAlertViewStyleCorner ];
            alertView.NTAlertDelegate = self;
            alertView.tag = 105;
            [alertView ShowView];
         

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
            KGReginFailAlertView * alertView = [KGReginFailAlertView createAlertView:EN_NTAlertViewStyleCorner];
            
            [alertView ShowView];
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
        _MVRegBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 5 ,ScreenWidth, 192)];
        _MVRegBgView.backgroundColor=[UIColor whiteColor];
        for (int i = 1; i<4; i++)
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


-(void)createInviteCodeView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48*3, 56, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"邀请码";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVInvCodeTf];
}
-(void)createTreatyView
{
    UILabel * label= [[UILabel alloc]init];
    
    label.backgroundColor=[UIColor clearColor];
    label.text=@"点击【立即注册】表明您同意";
    label.font=[UIFont systemFontOfSize:11];
    label.textColor=[UIColor colorWithHexString:@"#a7a7a7"];
    [label sizeToFit];
    label.frame = CGRectMake(11, self.MVReginBtn.v_bottom+10 ,label.v_width, label.v_height);
    [self.view addSubview:label];
    
    [self.view addSubview:self.MVTreatyBtn];
    self.MVTreatyBtn.frame =  CGRectMake(label.v_right, label.v_y ,self.MVTreatyBtn.titleLabel.v_width, self.MVTreatyBtn.titleLabel.v_height) ;
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
-(UIButton *)MVTreatyBtn
{
    if (_MVTreatyBtn == nil)
    {
        _MVTreatyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVTreatyBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        _MVTreatyBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [_MVTreatyBtn setTitle:@"《珍味世家服务条款》" forState:UIControlStateNormal];
        [_MVTreatyBtn.titleLabel sizeToFit];
       
        
    }
    return _MVTreatyBtn;
}
-(UIButton *)MVReginBtn
{
    if (_MVReginBtn == nil)
    {
        _MVReginBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,self.MVRegBgView.v_height+15, ScreenWidth-22, 40)];
        
        _MVReginBtn.backgroundColor= [UIColor colorWithHexString:@"#cdcdcd"];
        _MVReginBtn.layer.masksToBounds=YES;
        _MVReginBtn.layer.cornerRadius=5;
        [_MVReginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_MVReginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVReginBtn addTarget:self action:@selector(pressRegBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        _MVReginBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _MVReginBtn.enabled=NO;
    }
    return _MVReginBtn;
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

-(UITextField *)MVInvCodeTf
{
    if (_MVInvCodeTf == nil)
    {
        _MVInvCodeTf=[[UITextField alloc]initWithFrame:CGRectMake(11+57, 48*3, ScreenWidth-79, 48)];
        _MVInvCodeTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVInvCodeTf.delegate=self;
        _MVInvCodeTf.secureTextEntry = YES;
        _MVInvCodeTf.placeholder=@"请输入您的邀请码";
        _MVInvCodeTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVInvCodeTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVInvCodeTf.borderStyle=UITextBorderStyleNone;
        _MVInvCodeTf.keyboardType=UIKeyboardTypeDefault;
        _MVInvCodeTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVInvCodeTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _MVInvCodeTf;
}
@end
