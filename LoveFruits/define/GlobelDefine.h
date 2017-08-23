//
//  Globel.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#ifndef Globel_h
#define Globel_h
#import "KGTheme.h"
#import "DebugMacro.h"

#define KGWEAKOBJECT(weakSelf) __weak __typeof(self)weakSelf = self;
// MARK: - 全局常用属性
#define NavigationH         64.0

#define  kTabarH            48.0

#define  NavigationStatusH  20.0


#define  ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight        [UIScreen mainScreen].bounds.size.height
#define  ScreenBounds        [UIScreen mainScreen].bounds

#define ShopCarRedDotAnimationDuration  0.2

#define  CommonlyUsedBtnColor  [UIColor colorWithHexString:@"#a66211"]
//
//// MARK: - Home 属性
#define HotViewMargin  10
#define HomeCollectionViewCellMargin 10
#define HomeCollectionTextFont  [UIFont systemFontOfSize:13]
#define HomeCollectionCellAnimationDuration 1.0
//
//// MARK: - 通知
// 首页headView高度改变
#define HomeTableHeadViewHeightDidChange @"HomeTableHeadViewHeightDidChange"
/////// 首页商品库存不足
#define HomeGoodsInventoryProblem        @"HomeGoodsInventoryProblem"
//
#define GuideViewControllerDidFinish     @"GuideViewControllerDidFinish"

// MARK: - 广告页通知
#define  ADImageLoadSecussed @"ADImageLoadSecussed"
#define  ADImageLoadFail     @"ADImageLoadFail"

#define  LOGSucess           @"logSucess"
#define  LOGOut              @"logOut"

// MARK: - Mine属性
//public let CouponViewControllerMargin: CGFloat = 20
//
//// MARK: - HTMLURL
/////优惠劵使用规则
//public let CouponUserRuleURLString = "http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D"
//
//// MARK: - Cache路径
//#define LFBCachePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
//
//// MARK: - AuthorURL
//public let GitHubURLString: String = "https://github.com/ZhongTaoTian"
//public let SinaWeiBoURLString: String = "http://weibo.com/tianzhongtao"
//public let BlogURLString: String = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"
//

//
//// MARK: - 购物车管理工具通知
#define  LFBShopCarDidRemoveProductNSNotification @"LFBShopCarDidRemoveProductNSNotification"
///// 购买商品数量发生改变
#define LFBShopCarBuyProductNumberDidChangeNotification @"LFBShopCarBuyProductNumberDidChangeNotification"
///// 购物车商品价格发送改变
#define LFBShopCarBuyPriceDidChangeNotification   @"LFBShopCarBuyPriceDidChangeNotification"
//// MARK: - 购物车ViewController
#define  ShopCartRowHeight    50
//
//// MARK: - 搜索ViewController
#define LFBSearchViewControllerHistorySearchArray @"LFBSearchViewControllerHistorySearchArray"

#define  MFirstLaunch                @"MFirstLaunch"



#endif /* Globel_h */
