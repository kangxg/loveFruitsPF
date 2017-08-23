//
//  KGSystemMessageVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSystemMessageVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGSystemMessageVCTR ()
@property (nonatomic,retain)UIView  * MVNomessageView;
@end

@implementation KGSystemMessageVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"消息中心";
    [self createNomessageView];
    // Do any additional setup after loading the view.
}
-(void)createNomessageView
{
    [self.view addSubview:self.MVNomessageView];
    UIImageView * imageview = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"无消息"];
    imageview.image = image;
    imageview.frame = CGRectMake((ScreenWidth-image.size.width)/2, 150, image.size.width, image.size.height);
    [_MVNomessageView addSubview:imageview];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame     = CGRectMake(0, imageview.v_bottom + 20, ScreenWidth, 20);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font  = [UIFont systemFontOfSize:15.0f];
    lab.textColor  = [UIColor colorWithHexString:@"#333333"];
    lab.text       = @"暂时还没消息哦";
    [_MVNomessageView addSubview:lab];
}
-(UIView *)MVNomessageView
{
    if(_MVNomessageView == nil)
    {
        _MVNomessageView = [[UIView alloc]init];
        _MVNomessageView.frame = CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight-NavigationH);
        
    }
    return _MVNomessageView;
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
