//
//  KDAddAddressVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KDAddAddressVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KDAddAddressViewModel.h"
@interface KDAddAddressVCTR()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,retain)UIView                  *   MVRegBgView;
@property (nonatomic,retain)KDAddAddressViewModel   *   MVModel;
@property (nonatomic,retain)UITextField             *   MVAcounTf;
@property (nonatomic,retain)UITextField             *   MVPhoneTf;
@property (nonatomic,retain)UITextView              *   MVAddressTf;
@property (nonatomic,retain)UIButton                *   MVAreaButton;
@property (strong,nonatomic)UILabel                 *   MVPlaceHolderLabel;
@property (nonatomic,retain)UIButton                *   MVSaveButton;

@end

@implementation KDAddAddressVCTR
@synthesize  MVRegBgView   = _MVRegBgView;
@synthesize  MVModel       = _MVModel;
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
    self.KVTitleLabel.text = @"添加新地址";
    _MVModel = [[KDAddAddressViewModel alloc]init];
    [self createTopView];
    [self.view addSubview:self.MVRegBgView];
    [self createAcountView];
    [self createPhoneView];
    [self createAreaView];
    [self createAddressView];
}

-(void)createTopView
{
    if (_MVSaveButton== nil)
    {
        _MVSaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVSaveButton.frame = CGRectMake(0, 0, 40, 44);
        [_MVSaveButton setTitle:@"保存" forState:UIControlStateNormal];
   
        _MVSaveButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_MVSaveButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _MVSaveButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_MVSaveButton addTarget:self action:@selector(clickSave:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -12;
        UIBarButtonItem * rightItem=[[UIBarButtonItem alloc]initWithCustomView:_MVSaveButton];
        rightItem.width= -15;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
        //        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
}
-(void)clickSave:(id)sender
{
    
}

-(void)textFiledChange:(UITextField* )tf
{
    
    
    if (_MVAcounTf.text.length&&_MVPhoneTf.text.length>=11&&_MVAddressTf.text.length && _MVAreaButton.titleLabel.text.length) {
        
        _MVSaveButton.enabled=YES;

        [_MVSaveButton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
      
        
    }else
    {
        _MVSaveButton.enabled=NO;
     
        [_MVSaveButton setTitleColor:[UIColor colorWithHexString:@"#dcdcdc"] forState:UIControlStateNormal];
     
        
    }
    
    
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        self.MVPlaceHolderLabel.hidden=NO;
        _MVSaveButton.enabled=NO;
        
        [_MVSaveButton setTitleColor:[UIColor colorWithHexString:@"#dcdcdc"] forState:UIControlStateNormal];
    }
    else
    {
        self.MVPlaceHolderLabel.hidden=YES;
        
        _MVSaveButton.enabled=YES;
        
        [_MVSaveButton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        

    }
    
    
}

-(UIView *)MVRegBgView
{
    if (_MVRegBgView == nil)
    {
        _MVRegBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 5 ,ScreenWidth, 48*5)];
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
    leftLabel.frame = CGRectMake(11, 0, 80, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"收货人";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    [_MVRegBgView addSubview:self.MVAcounTf];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(leftLabel.v_right+0.5, 0, 0.5, 48);
    lineLabel.textColor =  [UIColor colorWithHexString:@"#d8d8d8"];
    [_MVRegBgView addSubview:lineLabel];

}

-(void)createPhoneView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48, 80, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"联系电话";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVPhoneTf];
}
-(void)createAreaView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48*2, 76, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"所在地区";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVAreaButton];
    
    
    UIImageView *rightIcon=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-6-22, 48*2 +11, 22, 22)];
    rightIcon.image=[UIImage imageNamed:@"rightlead"];
    [_MVRegBgView addSubview: rightIcon];
}

-(void)createAddressView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(11, 48*3, 76, 48);
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"详细地址";
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVRegBgView addSubview:leftLabel];
    
    [_MVRegBgView addSubview:self.MVAddressTf];
    [_MVRegBgView addSubview:self.MVPlaceHolderLabel];
}

-(UITextField *)MVAcounTf
{
    if (_MVAcounTf == nil)
    {
        _MVAcounTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81, 0, ScreenWidth-105, 48)];
        _MVAcounTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVAcounTf.delegate=self;
        _MVAcounTf.placeholder=@"请输入您的的姓名";
        
        _MVAcounTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVAcounTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVAcounTf.borderStyle=UITextBorderStyleNone;
  
        _MVAcounTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVAcounTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVAcounTf;
}

-(UITextField *)MVPhoneTf
{
    if (_MVPhoneTf == nil)
    {
        _MVPhoneTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81, 48, ScreenWidth-105, 48)];
        _MVPhoneTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVPhoneTf.delegate=self;
        _MVPhoneTf.placeholder=@"请输入您的电话号码";
        _MVPhoneTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVPhoneTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVPhoneTf.borderStyle=UITextBorderStyleNone;
        _MVPhoneTf.keyboardType=UIKeyboardTypePhonePad;
        _MVPhoneTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVPhoneTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVPhoneTf;
}

-(UIButton *)MVAreaButton
{
    if (_MVAreaButton == nil)
    {
        _MVAreaButton=[[UIButton alloc]initWithFrame:CGRectMake(11+81, 48*2, ScreenWidth-105, 48)];
        _MVAreaButton.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        [_MVAreaButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_MVAreaButton setTitleColor:[UIColor colorWithHexString:@"#dcdcdc"] forState:UIControlStateNormal];
        _MVAreaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _MVAreaButton.titleLabel.font      = [UIFont systemFontOfSize:13.0f];
     
//        _MVAreaButton.tintColor = [UIColor colorWithHexString:@"#feb001"];
        [_MVAreaButton addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _MVAreaButton;
}

-(UITextView *)MVAddressTf
{
    if (_MVAddressTf == nil)
    {
        _MVAddressTf = [[UITextView alloc]initWithFrame:CGRectMake(11+81, 48*3+10, ScreenWidth-105, 48*2-20)];
        _MVAddressTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVAddressTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVAddressTf.delegate = self;
//        _MVAddressTf.backgroundColor = [UIColor redColor];
//        [_MVAddressTf addTarget:self action:@selector(textFiledChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _MVAddressTf;
}

-(UILabel *)MVPlaceHolderLabel
{
    if (_MVPlaceHolderLabel == nil)
    {
        _MVPlaceHolderLabel = [[UILabel alloc]init];
        _MVPlaceHolderLabel.frame = CGRectMake(11+82, 48*3, ScreenWidth-106, 48);
        _MVPlaceHolderLabel.numberOfLines = 0;
        _MVPlaceHolderLabel.text = @"请输入详细地址";
        _MVPlaceHolderLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVPlaceHolderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _MVPlaceHolderLabel;
}
@end
