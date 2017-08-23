//
//  YZNetworkHeader.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#ifndef YZNetworkHeader_h
#define YZNetworkHeader_h
#import "YZNetworkRequestHelpEnum.h"
/**
 *  Description 授权模式
 */
#define  KGGRANTTYPE     @"password"
/**
 *  Description 客户端标识
 */
#define  KGCLIENTID      @"zwsjpfapp"

/**
 *  Description 客户端密钥
 */
#define  KGCLIENTSECRET      @"eZn6fy6DdPmoTOIQASIqJK2AdOPaRYzN"
/**
 *  Description  首页广告请求URL
 */
#define  KGHOMEADVERTURL     @"/course_api/banner/query"
/**
 *  Description  
 */
#define  KGHOMECOUPONURL     @"/course_api/coupon/list"

/**
 *  Description  获取领券中心优惠券列表
 */
#define  KGHOMECOUPONCENTERURL     @"/course_api/coupon/center"


/**
 *  Description  领取优惠券
 */
#define  KGGETCOUPONCENTERURL     @"/course_api/coupon/achieve"
/**
 *  Description  获取用户订单列表
 */
#define  KGUSERORDERSNURL     @"/course_api/order/list"

/**
 *  Description  取消用户订单列表
 */
#define  KGCANCELORDERURL     @"/course_api/order/cancel"

/**
 *  Description  确认收货订单
 */
#define  KGCONFIRMORDERURL     @"/course_api/order/confirm"

/**
 *  Description  删除订单
 */
#define  KGDELETEORDERURL     @"/course_api/order/delete"

/**
 *  Description  获取用户订单详情
 */
#define  KGORDERDETAILURL     @"/course_api/order/detail"
/**
 *  Description  搜索请求URL
 */
#define  KGSEARCHURL     @"/course_api/search"
/**
 *  Description  首页商铺信息
 */
#define  KGHOMEWARINSTURL     @"/course_api/auth/warnings"
/**
 *  Description  商品详情
 */
#define  KGPRODUCTDETAILSURL  @"/course_api/product"
/**
 *  Description  分类
 */
#define  KGSUPRERMARKURL     @"/course_api/category/list"

/**
 *  Description  分类商品
 */
#define  KGPRODUCTSURL     @"/course_api/wares/list"
/**
 *  Description 授权模式
 */
#define  BaseUrl	     @"http://autumnrains.iask.in"
/**
 *  Description 注册
 */
#define  KGREGINURL	     @"/course_api/auth/reg"
/**
 *  Description 商户信息审核状态
 */
#define  KGSTOREINFOSTATUSURL	     @"/course_api/auth/storeinfostatus"
/**
 *  Description 获取地址列表
 */
#define  KGGETADDRESSURL	     @"/course_api/address/list"
/**
 *  Description 提交订单
 */
#define  KGORERCREATEURL	     @"/course_api/order/create"
/**
 *  Description 商户信息注册
 */
#define KGADDMERCHANTSINFO  @"/course_api/auth/storeinfo"
/**
 *  Description 登录
 */
#define  KGLOGINNURL	 @"/course_api/auth/login"

/**
 *  Description 登录
 */
#define  KGRESETPWD	     @"/course_api/auth/reset"

#endif /* YZNetworkHeader_h */
