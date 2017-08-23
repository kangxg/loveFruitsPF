//
//  KGSelectedBuyVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/2.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSelectedBuyVCTR.h"
#import "GlobelDefine.h"
#import "KGTheme.h"
#import "KGAdressTitleView.h"
#import "UIView+Extension.h"
#import "KGSearchProductVCTR.h"
@interface KGSelectedBuyVCTR ()
@property (nonatomic,retain)KGSelectBuyView *  MTitleView;
@end

@implementation KGSelectedBuyVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildbuildNavigationView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:false animated:false];
    
}
-(void)buildbuildNavigationView
{
    
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationH)];
    topView.backgroundColor= LFBNavigationHomeSearchColor;
    [self.view addSubview:topView];
    
    UIImage * image = [UIImage imageNamed:@"phone"];
    UIButton  * phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setBackgroundImage:image forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(phoneCallBack) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.frame = CGRectMake(ScreenWidth- 10- image.size.width , 20+7, image.size.width, image.size.height);
    [topView addSubview:phoneBtn];
    //输入框和背景
    UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(10,20+7, ScreenWidth-20-image.size.width-30,image.size.height)];
    backView.layer.masksToBounds=YES;
    backView.layer.cornerRadius=(NavigationH-34)/2;
    backView.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    //[UIColor whiteColor];
    backView.layer.borderWidth = 0.5f;
    backView.layer.borderColor = [UIColor colorWithHexString:@"#a6aaae"].CGColor;
    //    backView.alpha=0.85;
    [topView addSubview:backView];
    CGFloat bH=NavigationH-34;
    UIImageView * searchIcon=[[UIImageView alloc]initWithFrame:CGRectMake(9, 7.5, bH-18, bH-18)];
    searchIcon.image=[UIImage imageNamed:@"icon_search"];
    [backView addSubview:searchIcon];
    CGFloat bw=backView.frame.size.width-bH;
    
    UILabel * placeHolderLabel= [[UILabel alloc]initWithFrame:CGRectMake(bH, 0, bw, image.size.height)];
    placeHolderLabel.font = [UIFont systemFontOfSize:12.0f];
    placeHolderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    placeHolderLabel.text = @"请在此输入您想购买的商品";
    //[YZUIFactory initWithFrame:CGRectMake(bH, 0, bw, bH) text:@"搜索职位、公司" fontSize:14 textColor:searchPlaceholder];
    [backView addSubview:placeHolderLabel];
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearch)
                                  ];
    [backView addGestureRecognizer:tap];


}

-(void)tapSearch
{
    KGSearchProductVCTR * vctr = [[KGSearchProductVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
}

-(void)phoneCallBack
{
    NSString* phoneNumberURL = [NSString stringWithFormat: @"tel://4006336900"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberURL]];
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
