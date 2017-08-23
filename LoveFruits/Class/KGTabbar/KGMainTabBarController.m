//
//  KGMainTabBarController.m
//  LoveFruits
//
//  Created by kangxg on 16/5/3.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMainTabBarController.h"
#import "GlobelDefine.h"
#import "KGHomeVCTR.h"
#import "KGShopCartVCTR.h"
#import "KGSupermarketVCTR.h"
#import "KGMineVCTR.h"
#import "KGBaseNavigationController.h"
#import "KGItemAnimation.h"
#import "KGAnimatedTabBarItem.h"
@interface KGMainTabBarController()<UITabBarControllerDelegate>
@property (nonatomic,retain)UIImageView * MImageView;
@property (nonatomic,assign)BOOL          MIsFristLoadMainTabBarController;

@end
@implementation KGMainTabBarController
@synthesize MImageView = _MImageView;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    _MIsFristLoadMainTabBarController = true;
    [self createImageView];
     [self buildMainTabBarChildViewController];
    
}
-(void)viewWillAppear:(BOOL)animated
{
  
    [super viewWillAppear:animated];
    if (_MIsFristLoadMainTabBarController)
    {
       NSDictionary * dic =  [self createViewContainers];
      [self createCustomIcons:dic];
       _MIsFristLoadMainTabBarController = false;
    }
}
-(void) buildMainTabBarChildViewController
{
    
    [self tabBarControllerAddChildViewController:[[KGHomeVCTR alloc]init] withTitle:@"首页" withImageName:@"v2_home" withselectedImageName:@"v2_home_r" withTag:0];
    [self tabBarControllerAddChildViewController:[[KGSupermarketVCTR alloc]init] withTitle:@"分类" withImageName:@"v2_order" withselectedImageName:@"v2_order_r" withTag:1];
    [self tabBarControllerAddChildViewController:[[KGShopCartVCTR alloc]init] withTitle:@"购物车" withImageName:@"shopCart" withselectedImageName:@"shopCart" withTag:2];
    [self tabBarControllerAddChildViewController:[[KGMineVCTR alloc]init] withTitle:@"我的" withImageName:@"v2_my" withselectedImageName:@"v2_my_r" withTag:3];
}
-(void)createImageView
{
    if (_MImageView == nil)
    {
        _MImageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
        [self.view addSubview:_MImageView];
    }
}
-(UIImageView *)MImageView
{
    if (_MImageView == nil)
    {
        _MImageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
        [self.view addSubview:_MImageView];
    }
    return _MImageView;
}
-(void)setAdImage:(UIImage *)adImage
{

    if (adImage && self.MImageView)
    {
        __weak  KGMainTabBarController * tmpself = self;
        self.MImageView.image = adImage;
        [UIImageView animateWithDuration:2.0f animations:^{
            
            [tmpself.MImageView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
            tmpself.MImageView.alpha = 0;

        } completion:^(BOOL finished) {
            [tmpself.MImageView removeFromSuperview];
            tmpself.MImageView = nil;
        }];
    
    }
}

-(void)tabBarControllerAddChildViewController:(UIViewController *)childView withTitle:(NSString *)title withImageName:(NSString *)imageName withselectedImageName:(NSString *)selectedImageName withTag:(NSInteger)tag
{
    KGAnimatedTabBarItem * vcItem = [[KGAnimatedTabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    vcItem.tag = tag;
    vcItem.KGAnimation = [[KGBounceAnimation alloc]init];
     childView.tabBarItem = vcItem;
    KGBaseNavigationController * navigationVC = [[KGBaseNavigationController alloc]initWithRootViewController:childView];
    [self addChildViewController:navigationVC];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSArray * childArr = self.childViewControllers;
    NSInteger index = [childArr indexOfObject:viewController];
    if (index == 2)
    {
        return false;
    }
    return true;
}
@end
