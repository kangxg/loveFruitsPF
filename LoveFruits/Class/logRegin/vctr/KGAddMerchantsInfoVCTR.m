//
//  KGAddMerchantsInfoVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAddMerchantsInfoVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGAddMerchantsInfoModel.h"
#import "CCommonClass.h"
#import "AFNetworkReachabilityManager.h"
#import "YZNetworkRequestHelper.h"
#import "YZRequestItem.h"
#import "iToast.h"
#import "KGProgressHUDManager.h"
#import "YCMCreditImageView.h"
#import "SDPhotoBrowser.h"
#import "KGSheetView.h"
#import "YZUploadSingleImageItem.h"
#import "KGAddMerchantsInfoAlertView.h"
#import "KGMainTabBarController.h"
#import "InlineFunc.h"
#import "FeHandwriting.h"
@interface KGAddMerchantsInfoVCTR()<YZNetworkRequestHelpDelegate,UITextFieldDelegate,KGBaseViewDelegate,SDPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NTAlertViewDelegate>
@property (nonatomic,retain)UIView                  * MVRegBgView;
@property (nonatomic,retain)UITextField             * MVStoreNameTf;
@property (nonatomic,retain)UITextField             * MVHeadNameTf;
@property (nonatomic,retain)UITextField             * MVAdressTf;
@property (nonatomic,retain)UIButton                * MVSubmitBtn;
@property (nonatomic,retain)KGAddMerchantsInfoModel * MVModel;
@property (nonatomic,retain)YCMCreditImageView      * MVImageView;
@property (nonatomic,retain)YZNetworkRequestHelper  * MRequestHelper;
@property (nonatomic,retain)YZNetworkRequestHelper  * MRequestUpdateHelper;
@property (nonatomic,retain)FeHandwriting           * MVLoadingView;

@end

@implementation KGAddMerchantsInfoVCTR
@synthesize MVStoreNameTf        = _MVStoreNameTf;
@synthesize MVHeadNameTf         = _MVHeadNameTf;
@synthesize MVAdressTf           = _MVAdressTf;
@synthesize MVRegBgView          = _MVRegBgView;
@synthesize MVModel              = _MVModel;
@synthesize MVSubmitBtn          = _MVSubmitBtn;
@synthesize MVImageView          = _MVImageView;
@synthesize MRequestHelper       = _MRequestHelper;
@synthesize MRequestUpdateHelper = _MRequestUpdateHelper;

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
    
    self.KVTitleLabel.text = @"添加商户信息";
    _MVModel = [[KGAddMerchantsInfoModel alloc]init];
    [self.view addSubview:self.MVRegBgView];

    [self createStoreNameView];
    [self createheadNameView];
    [self createAddressView];
    [self createBusinessLicenseView];
    [self.view addSubview:self.MVSubmitBtn];
    [self createMarkView];
   
    
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

    
    
    if (_MVStoreNameTf.text.length&&_MVAdressTf.text.length&&_MVHeadNameTf.text.length ) {
        
        _MVSubmitBtn.enabled=YES;
        _MVSubmitBtn.selected=YES;
        _MVSubmitBtn.backgroundColor= CommonlyUsedBtnColor;
        
    }else
    {
        _MVSubmitBtn.enabled=NO;
        _MVSubmitBtn.selected=NO;
        _MVSubmitBtn.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
        
    }
    
    
    
}



-(void)clickSubmit
{
    if ([_MVStoreNameTf.text isEqualToString:@""] ) {
        
        [CCommonClass msgHint:@"请输入店面名称"  dismissAfter:1.0];
        return;
    }
    
    else if(_MVHeadNameTf.text.length==0)
    {
        
        [CCommonClass msgHint:@"请输入负责人的姓名" dismissAfter:1.0];
        return;
        
    }
    else if(_MVAdressTf.text.length==0||_MVAdressTf.text==nil)
    {
        
        [CCommonClass msgHint:@"请输入商店地址" dismissAfter:1.0];
        return;
        
    }
    else
    {
        [self initAddInfoRequestStart];
    }

}

-(void)pOperitionViewEvent:(id)sender  withState:(KGFunctionOperation)state
{
    [self.view endEditing:YES];
    switch (state)
    {
        case KGOPRERATIOAADD:
        {
            [self addCreditObject];
        }
            break;
        case KGOPRERATIOOPENIMAGE:
        {
            [self enlargementPicture:sender];
        }
            break;
        default:
            break;
    }
}
-(void)pSelectWithIndex:(NSInteger)index
{
    
    //拍照
    if (index==1)
    {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            // picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            
        } else {
            NSString *title = @"错误信息";
            NSString *msg = @"对不起，您的设备不支持拍照或者拍照设备损坏！";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
        
    }
    else if(index==2)
    {
        //从相册选
        
        UIImagePickerController *picker_library = [[UIImagePickerController alloc] init];
        picker_library.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // picker_library.allowsEditing = YES;
        picker_library.delegate = self;
        
        [self presentViewController:picker_library animated:YES completion:nil];
        
        
        
    }
}

#pragma  mark ------ UIImagePickerViewdelegate ----
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage * newImage;
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        UIImage * image=[info valueForKey:UIImagePickerControllerOriginalImage];
        //横拍
        
        if (image.size.width>image.size.height) {
            newImage= scaleFromImage(image,CGSizeMake(ScreenWidth*1.33,ScreenWidth));
//            [YZUIFactory scaleFromImage:image toSize:CGSizeMake(kScreenWith*1.33,kScreenWith)];
        }
        else{
              newImage= scaleFromImage(image,CGSizeMake(ScreenWidth,ScreenWidth*1.33));
//            newImage=[YZUIFactory scaleFromImage:image toSize:CGSizeMake(kScreenWith,kScreenWith*1.333)];
            
        }
        
        newImage = image;
    }
    else if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary)
    {
        UIImage * image=[info valueForKey:UIImagePickerControllerOriginalImage];
        if (image.size.width>image.size.height) {
            newImage= scaleFromImage(image,CGSizeMake(ScreenWidth*1.33,ScreenWidth));
//            newImage=[YZUIFactory scaleFromImage:image toSize:CGSizeMake(kScreenWith*1.33,kScreenWith)];
        }
        else{
             newImage= scaleFromImage(image,CGSizeMake(ScreenWidth,ScreenWidth*1.33));
//            newImage=[YZUIFactory scaleFromImage:image toSize:CGSizeMake(kScreenWith,kScreenWith*1.333)];
            
        }
        
        newImage = image;

    }
        if (newImage  == nil)
    {
        [[iToast makeText:@"拍摄失败，请重新操作"] show];
        return;
    }
    NSData * imagedata=UIImagePNGRepresentation(newImage);
//    UIImageJPEGRepresentation(newImage, 1.0);
    //UIImagePNGRepresentation(newImage);
    //UIImageJPEGRepresentation(newImage, 0.5);
    if (imagedata == nil )
    {
        [[iToast makeText:@"拍摄失败，请重新操作"] show];
    }
    //UIImagePNGRepresentation(newImage);
    self.MVModel.KGUploadRequestItem.YImageData = imagedata;
    [self.MVImageView putinImage:newImage];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [picker dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)addCreditObject
{
    KGSheetView * view  =   [KGSheetView initWithSuperView:self.navigationController.view frame:self.navigationController.view.bounds titleContent:nil cancleBtnName:@"取消" otherBtnArr:@[@"拍照",@"从相册选择"] ];
    view.KVDelegate = self;
    
}

-(void)enlargementPicture:(id)sender
{
    if (sender == nil)
    {
        return;
    }
    YCMCreditImageView  * view  = sender;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = _MVImageView; // 原图的父控件
    browser.imageCount = 1; // 图片总数
    browser.currentImageIndex =(int)view.tag;
    browser.delegate = self;
    [browser show];
}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.MVImageView.MBackGroundBtn.imageView.image;
    //return [_mCreditView.subviews[index] currentImage];
//    YCMCreditImageView * view = _mCreditView.subviews[index];
//
//    //
//    return [view.MBackGroundBtn currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
//    YCCreditImageModel * model = _mCreditImageModelArr[index];
//    NSString *urlStr = [model.MImageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    return [NSURL URLWithString:urlStr];
    return nil;
    
}

-(void)initAddInfoRequestStart
{
    [self requestRegin];
}

-(void)requestRegin
{
//    NSMutableDictionary *dic =   self.MVModel.KDAddRequestItem.YRequestDic;
//    [dic setValue:self.MVStoreNameTf.text forKey:@"storeName"];
//    [dic setValue:self.MVHeadNameTf.text forKey:@"mgrName"];
//    [dic setValue:self.MVAdressTf.text forKey:@"storeAdd"];
//    [dic setValue:self.MVModel.KGUploadRequestItem.YImageData forKey:@"lic_url"];
//
//    [self.MRequestHelper beginRequestWithItem:self.MVModel.KDAddRequestItem ];
    NSMutableDictionary *dic =   self.MVModel.KGUploadRequestItem.YRequestDic;
    [dic setValue:self.MVStoreNameTf.text forKey:@"storeName"];
    [dic setValue:self.MVHeadNameTf.text forKey:@"mgrName"];
    [dic setValue:self.MVAdressTf.text forKey:@"storeAdd"];
//    [dic setValue:self.MVModel.KGUploadRequestItem.YImageData forKey:@"lic_url"];
//    self.MVModel.KGUploadRequestItem.YFileName  = @"image";
    [self.MRequestUpdateHelper beginRequestWithItem:self.MVModel.KGUploadRequestItem];

}
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    [self.navigationController popViewControllerAnimated:false];
//    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
//    [tabBarController setSelectIndex:3 withTag:0];
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
    
    [self createLoadingView];
//    [self  startLoadingView];
    
    
}
-(void)pUpdateWillBegin:(YZRequestItem *)requestItem
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

-(void)pUpdateFinished
{
    if (self.MRequestUpdateHelper.YNetworkRequestCount== 0)
    {
        [self stopLoadingView];
    }
}
/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
//    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
//    
//    if (![KGProgressHUDManager isVisible])
//    {
//        [KGProgressHUDManager showWithStatus:@"正在加载中"];
//    }
    [self createLoadingView];
    //    [YZLoadingVew showLoadingViewWithSuperView:self frame:CGRectMake(0,kDHeight , kScreenWith, kScreenHeight-kDHeight)];
    
}
/**
 *  Description 停止 加载 网络请求指示视图
 */
-(void)stopLoadingView
{
    //    if ([YZLoadingVew isLoadingViewShow])
    //    {
//    if (self.MRequestHelper.YNetworkRequestCount == 0)
//    {
//        [KGProgressHUDManager dismiss];
//        //        [YZLoadingVew dissmissLaodingViewFromSuperView:self];
//    }
    
    //}
    [self removeLoadingView];
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
            [_MVModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
                [weakSelf ProcessingNetworkBack:state];
            }];
            
            
        }
            
            break;
               default:
            break;
    }
    
    
    
    
}
-(void)pUpdateSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
  
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            KGWEAKOBJECT(weakSelf);
            [_MVModel putJsonData:jsonDic withBlock:^(YZProcessingDataState state) {
                [weakSelf ProcessingNetworkBack:state];
            }];
            
            
        }
            
            break;
        default:
            break;
    }

}

-(void)pUpdateError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            [[iToast makeText:[jsonDic valueForKey:@"message"]]show];
            
        }
            break;
            
        default:
            break;
    }
}
-(void)pUpdateFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            [[iToast makeText:@"提交失败，请重试"]show];
            
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
            [[iToast makeText:[jsonDic valueForKey:@"message"]]show];
            
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
           [[iToast makeText:@"提交失败，请重试"]show];

        }
            break;
            
        default:
            break;
    }
 
    
}
-(void)ProcessingNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            
            KGAddMerchantsInfoAlertView *  alertView =[KGAddMerchantsInfoAlertView createAlertView:EN_NTAlertViewStyleCorner];
             alertView.NTAlertDelegate = self;
             [alertView ShowView];
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
            [[iToast makeText:@"提交失败，请重新提交"]show];
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

-(YZNetworkRequestHelper *)MRequestUpdateHelper
{
    if (_MRequestUpdateHelper == nil)
    {
        _MRequestUpdateHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEUPLOADSIGLEIMAGE];
        _MRequestUpdateHelper .YNetworkRequestDelegate = self;
    }
    
    return _MRequestUpdateHelper;
}
-(void)createStoreNameView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"门店名称";
    [leftLabel sizeToFit];
    float w = leftLabel.v_width;
    float h = leftLabel.v_height;
    leftLabel.frame = CGRectMake(11, 0, 81, 48);
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    UILabel * markLabel = [self createMarkLabel];
    markLabel.frame     = CGRectMake(leftLabel.v_x+w, (48-h)/2, markLabel.v_width, markLabel.v_height);
    [_MVRegBgView addSubview:markLabel];
    [_MVRegBgView addSubview:self.MVStoreNameTf];
    
    
    
}

-(void)createheadNameView
{
    
    UILabel * leftLabel = [[UILabel alloc]init];
    
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"负责人姓名";
    [leftLabel sizeToFit];
    float w = leftLabel.v_width;
    float h = leftLabel.v_height;
    leftLabel.frame = CGRectMake(11, 48, 81, 48);
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    UILabel * markLabel = [self createMarkLabel];
    markLabel.frame     = CGRectMake(leftLabel.v_x+w, (48-h)/2+48, markLabel.v_width, markLabel.v_height);
    [_MVRegBgView addSubview:markLabel];
    [_MVRegBgView addSubview:self.MVHeadNameTf];
   

}
-(void)createAddressView
{
    UILabel * leftLabel = [[UILabel alloc]init];
  
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"地址";
    [leftLabel sizeToFit];
    float w = leftLabel.v_width;
    float h = leftLabel.v_height;

    leftLabel.frame = CGRectMake(11, 48*2, 81, 48);
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    UILabel * markLabel = [self createMarkLabel];
    markLabel.frame     = CGRectMake(leftLabel.v_x+w, (48-h)/2+48*2, markLabel.v_width, markLabel.v_height);
    [_MVRegBgView addSubview:markLabel];
    
    
    [_MVRegBgView addSubview:self.MVAdressTf];
   

}

-(void)createBusinessLicenseView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48*3, 81, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"营业执照";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(11+81+25 , 48*3, ScreenWidth-118, 48);
    titleLabel.font  = [UIFont systemFontOfSize:13.0f];
    titleLabel.text  = @"上传照片 (小于10MB)";
    titleLabel.textColor =  [UIColor colorWithHexString:@"#999999"];
    [_MVRegBgView addSubview:titleLabel];
    
    UIImageView * lineImageView = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"xuxian"];
    lineImageView.image = image;
    lineImageView.frame = CGRectMake(11+106, 48*3+47, ScreenWidth-107, 0.5);
    [_MVRegBgView addSubview:lineImageView];
    
    _MVImageView = [[YCMCreditImageView alloc]initWithFrame:CGRectMake(11+106 ,48*4+12, 64, 64)];
    _MVImageView.KVDelegate = self;
    
    [_MVRegBgView addSubview:_MVImageView];
    
}
-(void)createMarkView
{
    UILabel * markLabel = [self createMarkLabel];
    
    UILabel * msglabel = [[UILabel alloc]init];
    msglabel.text = @"标为必填选项";
    msglabel.font = [UIFont systemFontOfSize:11.0f];
    msglabel.textColor = [UIColor colorWithHexString:@"#a1a1a1"];
    [msglabel sizeToFit];
    
    msglabel.frame = CGRectMake(11+markLabel.v_width+2, self.MVSubmitBtn.v_bottom+10, msglabel.v_width, msglabel.v_height) ;
    
    markLabel.frame = CGRectMake(11, self.MVSubmitBtn.v_bottom+10, markLabel.v_width, markLabel.v_height);
    [self.view addSubview:markLabel];
    [self.view addSubview:msglabel];
    
}
-(UIView *)MVRegBgView
{
    if (_MVRegBgView == nil)
    {
        _MVRegBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 5 ,ScreenWidth, 188+88)];
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

-(UITextField *)MVStoreNameTf
{
    if (_MVStoreNameTf == nil)
    {
        _MVStoreNameTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81+25, 0, ScreenWidth-118, 48)];
        _MVStoreNameTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVStoreNameTf.delegate=self;
        _MVStoreNameTf.placeholder=@"请输入您的店名";
        _MVStoreNameTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVStoreNameTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVStoreNameTf.borderStyle=UITextBorderStyleNone;
//        _MVStoreNameTf.keyboardType=UIKeyboardTypePhonePad;
        _MVStoreNameTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVStoreNameTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVStoreNameTf;
}

-(UITextField *)MVHeadNameTf
{
    if (_MVHeadNameTf == nil)
    {
        _MVHeadNameTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81+25, 48, ScreenWidth-118, 48)];
        _MVHeadNameTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVHeadNameTf.delegate=self;
        _MVHeadNameTf.placeholder=@"请输入负责人的姓名";
        _MVHeadNameTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVHeadNameTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVHeadNameTf.borderStyle=UITextBorderStyleNone;
//        _MVHeadNameTf.keyboardType=UIKeyboardTypePhonePad;
        _MVHeadNameTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVHeadNameTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVHeadNameTf;
}

-(UITextField *)MVAdressTf
{
    if (_MVAdressTf == nil)
    {
        _MVAdressTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81+25, 48*2, ScreenWidth-118, 48)];
        _MVAdressTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVAdressTf.delegate=self;
        _MVAdressTf.placeholder=@"请输入您的商店地址";
//        _MVAdressTf.secureTextEntry = YES;
        _MVAdressTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVAdressTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVAdressTf.borderStyle=UITextBorderStyleNone;
        _MVAdressTf.keyboardType=UIKeyboardTypeDefault;
        _MVAdressTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVAdressTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVAdressTf;
}
-(UIButton *)MVSubmitBtn
{
    if (_MVSubmitBtn == nil)
    {
        _MVSubmitBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,self.MVRegBgView.v_height+15, ScreenWidth-22, 40)];
        
        _MVSubmitBtn.backgroundColor= [UIColor colorWithHexString:@"#cdcdcd"];
        _MVSubmitBtn.layer.masksToBounds=YES;
        _MVSubmitBtn.layer.cornerRadius=5;
        [_MVSubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_MVSubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVSubmitBtn addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
        _MVSubmitBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _MVSubmitBtn.enabled=NO;
    }
    return _MVSubmitBtn;
}
-(UILabel *)createMarkLabel
{
    UILabel * markLabel = [[UILabel alloc]init];
    markLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
    markLabel.text      = @"*";
    markLabel.font      = [UIFont systemFontOfSize:12.0f];
    [markLabel sizeToFit];
    return markLabel;
}
@end


@implementation KGAuditAddMerchantsInfoVCTR
-(void)NTAlertViewCallBack:(id)sender WithTag:(NSInteger)tag
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
