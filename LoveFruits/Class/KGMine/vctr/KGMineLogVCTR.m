//
//  KGMineLogVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/15.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMineLogVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGLoginVCTR.h"
#import "KGReginVCTR.h"
@interface KGMineLogVCTR ()
@property (nonatomic,retain)UIImageView * MVImageView;
@end

@implementation KGMineLogVCTR

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createImageView];
    [self createButtonView];
    // Do any additional setup after loading the view.
}
-(void)createImageView
{
    if (_MVImageView == nil)
    {
        UIImageView * imageview = [[UIImageView alloc]init];
        UIImage * image = [UIImage imageNamed:@"mine_log"];
        imageview.image = image;
        _MVImageView  = imageview;
        imageview.frame = CGRectMake((self.view.v_width-image.size.width)/2, 87, image.size.width, image.size.height);
        [self.view addSubview:_MVImageView];
    }
   
}

-(void)createButtonView
{
    UIButton * logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logBtn.backgroundColor = CommonlyUsedBtnColor;
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    logBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(logCallBack) forControlEvents:UIControlEventTouchUpInside];
    logBtn.frame = CGRectMake(10, _MVImageView.v_bottom +66, self.view.v_width-20, 40);
    logBtn.layer.masksToBounds = YES;
    logBtn.layer.cornerRadius = 5;
    [self.view addSubview:logBtn];
    
    
    UIButton * regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.backgroundColor = CommonlyUsedBtnColor;
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(regCallBack) forControlEvents:UIControlEventTouchUpInside];
    regBtn.frame = CGRectMake(10, logBtn.v_bottom +15, self.view.v_width-20, 40);
    regBtn.layer.masksToBounds = YES;
    regBtn.layer.cornerRadius = 5;
    [self.view addSubview:regBtn];
    
}

-(void)logCallBack
{
    KGLoginVCTR * Vctr = [[ KGLoginVCTR alloc]init];
    [self.navigationController pushViewController:Vctr animated:YES];
}

-(void)regCallBack
{
    KGReginVCTR *  vctr  = [[KGReginVCTR alloc]init];
    [self.navigationController pushViewController:vctr animated:YES];
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
