//
//  KGBaseNavigationController.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseNavigationController.h"
#import "GlobelDefine.h"
@interface KGBaseNavigationController ()
{
    BOOL _MIsAnimation;
}
//@property(nonatomic,retain)NSArray<NSString *> * MIconsImageName;
//@property(nonatomic,retain)NSArray<NSString *> * MIconsSelectedImageName;
//@property(nonatomic,retain)UIImageView         * ShopCarIconImageView;
@end

@implementation KGBaseNavigationController
@synthesize KGIsAnimation  = _MIsAnimation;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _MIsAnimation = true;
    self.interactivePopGestureRecognizer.delegate = nil;
    // Do any additional setup after loading the view.
}

//-(void)setNavBackItem
//{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.KGNavBackButton];
//    
//}
-(UIButton *)KGNavBackButton
{
    if (_KGNavBackButton == nil)
    {
        _KGNavBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _KGNavBackButton.titleLabel.hidden = true;
        [_KGNavBackButton setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        [_KGNavBackButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _KGNavBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _KGNavBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        CGFloat btnW = ScreenWidth>375.0?50:44;
        _KGNavBackButton.frame =  CGRectMake(0, 0, btnW, 40);
        
    }
    return _KGNavBackButton;
}


-(void)backBtnClick
{
    [self popViewControllerAnimated:_MIsAnimation];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0)
    {
        [UINavigationBar appearance].backItem.hidesBackButton = false;
//        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.KGNavBackButton];
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
