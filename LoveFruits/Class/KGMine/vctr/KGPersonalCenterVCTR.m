//
//  KGPersonalCenterVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPersonalCenterVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "iToast.h"
#import "YZUploadSingleImageItem.h"
#import "InlineFunc.h"
#import "KGHeadSelectVCTR.h"
#import "KGUserModelManager.h"
@interface KGPersonalCenterVCTR ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain)UIView                  * MVBgView;
@property (nonatomic,retain)UIButton               *  MVEditButton;
@end

@implementation KGPersonalCenterVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"个人资料";
    [self createTopView];
    [self createBgView];
    [self createPersonalIconView];
    [self createPersonalNameView];
    // Do any additional setup after loading the view.
}
-(void)createTopView
{
    if (_MVEditButton== nil)
    {
        _MVEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVEditButton.frame = CGRectMake(0, 0, 40, 44);
        [_MVEditButton setTitle:@"保存" forState:UIControlStateNormal];
        _MVEditButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_MVEditButton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        _MVEditButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_MVEditButton addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
        
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
-(void)clickSave
{
    
}
-(void)createBgView
{
    [self.view addSubview:self.MVBgView];
}


-(void)createPersonalIconView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"头像";
    [leftLabel sizeToFit];

    leftLabel.frame = CGRectMake(11, 0, 81, 89);
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVBgView addSubview:leftLabel];
    
    
    
    UIImageView * direcImageView = [[UIImageView alloc]init];
    UIImage     * dimage = [UIImage imageNamed:@"mine_head_enter"];
    direcImageView.image = dimage;
    direcImageView.frame = CGRectMake(self.view.v_width-10-dimage.size.width, (89-dimage.size.height)/2, dimage.size.width, dimage.size.height);
    [_MVBgView addSubview:direcImageView];
    
    [_MVBgView addSubview:self.MVHeadImage];
    _MVHeadImage.frame = CGRectMake(self.view.v_width-82.5-dimage.size.width, 14.5, 60, 60);
    _MVHeadImage.image = [UIImage imageNamed:@"defail_myIcon"];

    
}

-(void)createPersonalNameView
{
    UILabel * leftLabel = [[UILabel alloc]init];
    
    leftLabel.font  = [UIFont systemFontOfSize:15.0f];
    leftLabel.text  = @"昵称";
    [leftLabel sizeToFit];
   
    leftLabel.frame = CGRectMake(11, 89, 81, 48);
    leftLabel.textColor =  [UIColor colorWithHexString:@"#333333"];
    [_MVBgView addSubview:leftLabel];
    
    [_MVBgView addSubview:self.MVHeadNameTf];
}

-(UIView *)MVBgView
{
    if (_MVBgView == nil)
    {
        _MVBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 5 ,ScreenWidth, 137)];
        _MVBgView.backgroundColor=[UIColor whiteColor];
        UILabel * midline = [[UILabel alloc]init];
        midline.frame = CGRectMake(0, 88.5, ScreenWidth, 0.5);
        midline.backgroundColor =  [UIColor colorWithHexString:@"#d8d8d8"];
        
        
        [_MVBgView addSubview:midline];

    }
    return _MVBgView;
}

-(UIImageView *)MVHeadImage
{
    if (_MVHeadImage == nil)
    {
        _MVHeadImage = [[UIImageView alloc]init];
      
        _MVHeadImage.layer.masksToBounds  = YES;
        _MVHeadImage.layer.cornerRadius = 30;
        _MVHeadImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoHeadSelectView)];
        [_MVHeadImage addGestureRecognizer:tap];
        
    }
    return _MVHeadImage;
}
-(void)gotoHeadSelectView
{
    KGHeadSelectVCTR  * vctr = [[ KGHeadSelectVCTR alloc]init];
    KGWEAKOBJECT(weakSelf);
    vctr.YVViewBacBlock = ^(id  object){
        weakSelf.MVHeadImage.image = (UIImage *)object;
    };
    
    [self.navigationController pushViewController:vctr animated:YES];
}
-(UITextField *)MVHeadNameTf
{
    if (_MVHeadNameTf == nil)
    {
        _MVHeadNameTf=[[UITextField alloc]initWithFrame:CGRectMake(11+81+25, 89, ScreenWidth-118-11, 48)];
        _MVHeadNameTf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _MVHeadNameTf.delegate=self;
        _MVHeadNameTf.text = [[KGUserModelManager  shareInstanced] getUserModel].KUserName;
        _MVHeadNameTf.placeholder=@"填写昵称";
        _MVHeadNameTf.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVHeadNameTf.font      = [UIFont systemFontOfSize:13.0f];
        _MVHeadNameTf.borderStyle=UITextBorderStyleNone;
        //        _MVHeadNameTf.keyboardType=UIKeyboardTypePhonePad;
        _MVHeadNameTf.tintColor = [UIColor colorWithHexString:@"#feb001"];
        _MVHeadNameTf.textAlignment = NSTextAlignmentRight;
       
    }
    return _MVHeadNameTf;
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

@implementation KGPersonalCenterSettingVCTR

@end



@implementation KGPersonalCenterEditVCTR

@end
