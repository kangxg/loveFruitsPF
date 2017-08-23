//
//  KGHomeWebVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeWebVCTR.h"
#import "GlobelDefine.h"
#import "KGLoadProgressAnimationView.h"
#import "UIColor+Extension.h"

#import "WebViewJavascriptBridge.h"
#import "KGMainTabBarController.h"
#import "KGProductDetailsVCTR.h"
@interface KGHomeWebVCTR()<UIWebViewDelegate>
@property (nonatomic,retain)UIWebView                *  MWebView;
@property (nonatomic,copy)NSString                   *  MUrlString;
@property (nonatomic,retain)WebViewJavascriptBridge  *  MWebbridge;
@property (nonatomic,retain)KGLoadProgressAnimationView * MLoadProgressAnimationView;
@end

@implementation KGHomeWebVCTR
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
//    {
//     
//        
//    }
//    return self;
//}
-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}
-(id)init:(NSString *)navTitle withUrlStr:(NSString *)urlStr
{
    if (self = [self init])
    {
       self.MUrlString = urlStr;
        _KVTitleString = navTitle;
    }
    return self;
}


-(UIWebView *)MWebView
{
    if (_MWebView == nil)
    {
        _MWebView = [[UIWebView alloc]initWithFrame:ScreenBounds];
         [_MWebView addSubview:self.MLoadProgressAnimationView];
        _MWebView.backgroundColor = LFBNavigationHomeSearchColor;
        
        _MWebView.delegate = self;
        _MWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        
//        [WebViewJavascriptBridge enableLogging];
//        _MWebbridge = [WebViewJavascriptBridge bridgeForWebView:_MWebView];
//        [_MWebbridge setWebViewDelegate:self];
//        
//        [_MWebbridge registerHandler:@"buyProduct" handler:^(id data, WVJBResponseCallback responseCallback) {
//            NSLog(@"商品ID %@", data);
//            responseCallback(@"Response from buyProduct");
//        }];
//        
//        [_MWebbridge registerHandler:@"goShopCart" handler:^(id data, WVJBResponseCallback responseCallback) {
//            NSLog(@"回到商城: %@", data);
//            responseCallback(@"Response from testObjcCallback");
//        }];


    }
    
    return _MWebView;
}

-(void)buyProduct
{
    
}

-(void)goShopCart
{
    
}
-(KGLoadProgressAnimationView *)MLoadProgressAnimationView
{
    if (_MLoadProgressAnimationView == nil)
    {
        _MLoadProgressAnimationView = [[KGLoadProgressAnimationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 3)];
    }
    
    return _MLoadProgressAnimationView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];

    self.KVTitleLabel.text = _KVTitleString;
    [self buildRightItemBarButton];
//
//   
//
    self.view.backgroundColor = LFBNavigationHomeSearchColor;
    
    
    [self addWebView];
    [self loadWebView];
 
    
}
-(void)addWebView
{
    [self.view addSubview:self.MWebView];
   
}

-(void)loadWebView
{
    if (_KVWebUrlString == nil || _KVWebUrlString.length<1) {
        return;
    }

    if ([_KVWebUrlString rangeOfString:@"http://"].location == NSNotFound)
    {
        _KVWebUrlString = [@"http://" stringByAppendingString:_KVWebUrlString];
    }

    NSURL *url = [NSURL URLWithString:_KVWebUrlString];
    NSURLRequest* mpUrlRequest  = [NSURLRequest requestWithURL:url];
    [_MWebView loadRequest:mpUrlRequest];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [WebViewJavascriptBridge enableLogging];
//    _MWebbridge = [WebViewJavascriptBridge bridgeForWebView:_MWebView];
//    [_MWebbridge setWebViewDelegate:self];
//    [_MWebbridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"Response from testObjcCallback");
//    }];
//    self.navigationController.navigationBar.hidden=false;
//  [self.navigationController.navigationBar setBarTintColor:LFBNavigationHomeSearchColor];
   
//        self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
//        self.navigationController.navigationBar.tintColor=[UIColor redColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}
-(void)buildRightItemBarButton
{
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"v2_refresh"] forState:UIControlStateNormal];
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -53)];
    [rightBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
}

-(void)refreshClick
{
    if (_MUrlString && _MUrlString.length >1)
    {
        [self.MWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MUrlString]]];
    }
}

- (void)disableSafetyTimeout {
    [_MWebbridge disableJavscriptAlertBoxSafetyTimeout];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.MLoadProgressAnimationView startLoadProgressAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.MLoadProgressAnimationView endLoadProgressAnimation];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    NSString * requestString = [[request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
    NSLog(@"=components=====%@",components);
    
    NSString *str1 = [components objectAtIndex:0];
    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"//"];
    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    NSLog(@"method:===%@",method);
    
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    if ([requestString hasPrefix:@"goshopcart://"]) {
        [self gotoMoreShop];
        return false;
    }else if ([requestString hasPrefix:@"buyproduct://"]) {
        [self goProductDetailsVCTR:array2.lastObject];
        return false;
    }
    return YES;
}
-(void)gotoMoreShop
{
    [self.navigationController popViewControllerAnimated:false];
    KGMainTabBarController * tabBarController  = (KGMainTabBarController * )[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setSelectIndex:0 withTag:1];
}

-(void)goProductDetailsVCTR:(NSString *)pid
{
    KGProductDetailsVCTR * vctr = [[KGProductDetailsVCTR alloc]init];
    vctr.YMProductId = pid;
    [self.navigationController pushViewController:vctr animated:YES];
}

@end
