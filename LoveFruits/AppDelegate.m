//
//  AppDelegate.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobelDefine.h"
#import "YDConfigurationHelper.h"
#import "KGADViewController.h"
#import "KGMainTabBarController.h"
#import "KGMainAD.h"
#import "AFNetworkReachabilityManager.h"
#import <SMS_SDK/SMSSDK.h>
#import "BeeCloud.h"
#import "KGUserModelManager.h"
#import "KGCheckLogStateVCTR.h"

@interface AppDelegate ()
@property (nonatomic,retain)KGADViewController  * MAdVCTR;
@property (nonatomic,retain)NSArray <AD *>      * MADArr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [SMSSDK registerApp:@"167ba0ed51604"
             withSecret:@"f73165c70c3f3e9a00c112a2f575e6a6"];
//    [KGMainAD loadADData:^(NSArray *data, NSError *error) {
//        _MADArr = data;
//    }];
    [self regisBeeCloud];
    
    self.window.backgroundColor = LFBNavigationHomeSearchColor;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [NSThread sleepForTimeInterval:1.0f];
    [self setUMeng];
    [self setAppSubject];
    [self addNotification];
    [self buildKeyWindow];
    return YES;
}

-(void)regisBeeCloud
{
    [BeeCloud initWithAppID:@"e618bedf-15d8-4c6a-8983-cc7790b7f1be" andAppSecret:@"2764d2a6-7788-4a41-b900-7ada5653a197"];
//     BOOL mode =  [BeeCloud getCurrentMode];
    [BeeCloud initBCWXPay:@"wxfa6d27941ef02880"];
    
//    [BeeCloud initWeChatPay:@"wxfa6d27941ef02880"];

//    [BeeCloud initWithAppID:@"c5d1cba1-5e3f-4ba0-941d-9b0a371fe719" andAppSecret:@"39a7a518-9ac8-4a9e-87bc-7885f33cf18c"];
//    //    [BeeCloud initWithAppID:@"c5d1cba1-5e3f-4ba0-941d-9b0a371fe719" andAppSecret:@"4bfdd244-574d-4bf3-b034-0c751ed34fee" sandbox:YES];
//    
//    //初始化微信官方APP支付
//    //此处的微信appid必须是在微信开放平台创建的移动应用的appid，且必须与在『BeeCloud控制台-》微信APP支付』配置的"应用APPID"一致，否则会出现『跳转到微信客户端后只显示一个确定按钮的现象』。
//    [BeeCloud initWeChatPay:@"wxf1aa465362b4c8f1"];
//    
//    //初始化BC微信APP支付
//    //    [BeeCloud initBCWXPay:@"wxf1aa465362b4c8f1"];
//    
//    //初始化PayPal
//    [BeeCloud initPayPal:@"AVT1Ch18aTIlUJIeeCxvC7ZKQYHczGwiWm8jOwhrREc4a5FnbdwlqEB4evlHPXXUA67RAAZqZM0H8TCR"
//                  secret:@"EL-fkjkEUyxrwZAmrfn46awFXlX-h2nRkyCVhhpeVdlSRuhPJKXx3ZvUTTJqPQuAeomXA8PZ2MkX24vF"
//                 sandbox:YES];

}
//iOS9之后官方推荐用此方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"options %@", options);
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (![BeeCloud handleOpenUrl:url])
    {
        //handle其他类型的url
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)setUMeng
{
    
}


-(void)setAppSubject
{
    //[UINavigationBar appearance];
    UITabBar * tabBarAppearance =  [UITabBar appearance];
    tabBarAppearance.backgroundColor = [UIColor whiteColor];
    tabBarAppearance.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    UINavigationBar * navBarnAppearance = [UINavigationBar appearance];
    navBarnAppearance.translucent = false;
}
-(void)loadCheckLogView
{
    KGCheckLogStateVCTR * vctr = [[KGCheckLogStateVCTR alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vctr];
    self.window.rootViewController =nav;
}
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logSucess) name:LOGSucess object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logOut) name:LOGOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarControllerSucess:) name:ADImageLoadSecussed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarControllerFale) name:ADImageLoadFail object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabBarController) name:GuideViewControllerDidFinish object:nil];
}

-(void)logSucess
{
    [self loadADRootViewController];
}

-(void)logOut
{
    [self loadCheckLogView];
}
-(void)showMainTabbarControllerSucess:(NSNotification *)notify
{
    [YDConfigurationHelper setApplicationStartupDefaults];
    UIImage *  adImage = [notify object];
    KGMainTabBarController * maintabBar = [[KGMainTabBarController alloc]init];
    [maintabBar setAdImage:adImage];
    self.window.rootViewController = maintabBar;

}

-(void) showMainTabbarControllerFale
{
    [YDConfigurationHelper setApplicationStartupDefaults];
    KGMainTabBarController * maintabBar = [[KGMainTabBarController alloc]init];
    self.window.rootViewController = maintabBar;
    
}

-(void)showMainTabBarController
{
    [YDConfigurationHelper setApplicationStartupDefaults];
     KGMainTabBarController * maintabBar = [[KGMainTabBarController alloc]init];
    self.window.rootViewController = maintabBar;
}
-(void)loadADRootViewController
{

    
#ifdef  testHidenAd
     KGMainTabBarController * maintabBar = [[KGMainTabBarController alloc]init];
     self.window.rootViewController = maintabBar;
#else
    
    
   _MAdVCTR  =  [[KGADViewController alloc]init];
    self.window.rootViewController = self.MAdVCTR;
   
#endif
}
-(void) buildKeyWindow
{
     [self loadCheckLogView];
//    BOOL isFristOpen = [YDConfigurationHelper getApplicationStartupDefaults];
//    if (isFristOpen)
//    {
//        
//        [self loadADRootViewController];
//    }
//    else
//    {
//        Class  clazz =  NSClassFromString(@"KGGuideVCTR");
//        self.window.rootViewController  = [[clazz alloc]init];
//    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
