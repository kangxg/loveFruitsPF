//
//  YZNetworkRequestHelperInterface.h
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

/**
 *  Description  网络请求辅助管理 继承接口文件
 */
#import <Foundation/Foundation.h>
#import "YZNetworkRequestHelpDelegate.h"
#import "YZNetworkRequestHelpEnum.h"
#import "KGNetworkInterface.h"
@class YZRequestItem;
@protocol YZNetworkRequestHelperInterface <NSObject>

@optional
//@property (nonatomic,retain)id<KGNetworkInterface>  YNetWorkService;

@property (nonatomic,assign,readwrite) BOOL YRequestFinished;
/**
 *  Description  网络请求最大个数
 */
@property (nonatomic,assign,readwrite)NSInteger   YNetworkRequestCount;

/**
 *  Description  网络请求最大校验值
 */
@property (nonatomic,assign,readonly)NSInteger   YNetworkRequestVerificationMax;

/**
 *  Description  网络请求完成后代理
 */
@property (nonatomic,weak)id<YZNetworkRequestHelpDelegate>   YNetworkRequestDelegate;

/**
 *  Description  网络请求基本地址字符串
 */
@property (nonatomic,copy)NSString * YNetworkRequestBaseUrl;

/**
 *  Description 将请求加入到数组中
 */
@property (nonatomic,retain,readonly) NSMutableArray *  YNetworkRequestArr;

/**
 *  Description 将失败请求加入到数组中
 */
@property (nonatomic,retain) NSMutableArray *  YNetworkFailureRequestArr;

/**
 *  Description 获取网络请求付出类 的类方法
 *
 *  @param requestMax 请求最大值
 *  @param requestType  请求类型枚举值 根据此值 创建适合的类
 *
 *  @return  ZNetworkRequestHelperInterface 类型类
 */
@optional
+(instancetype)InstanceNetworkWithRequestType:(YZNetworkRequestType)requestType;

/**
 *  Description  开始发送多个请求
 *
 *  @param arr
 */
-(void)beginRequest:(NSArray *)arr;

/**
 *  Description  开始发送单个请求
 *
 *  @param requestModel
 */
-(void)beginRequestWithItem:(YZRequestItem *)requestItem;

/**
 *  Description 追加请求
 *
 *  @param arr 请求YZRequestItem 类型 数组
 */
-(void)addRequest:(NSArray *)arr;

/**
 *  Description 追加请求
 *
 *  @param requestItem  追加请求item
 */
-(void)addreRequestWithItem:(YZRequestItem *)requestItem;

/**
 *  Description 重新发送失败请求
 */
-(void)transmitsFailureRequest:(YZRequestItem *)requestItem;
/**
 *  Description 发送所有失败请求
 */
-(void)transmitsAllFailRequest;
/**
 *  Description 重新发送所有请求
 */
-(void)transmitsRequest;
/**
 *  Description   用于将失败的请求重发成功后，将任务移除
 *
 *  @param requestItem 请求item
 */
-(void)failureRequestSuccessBack:(YZRequestItem *)requestItem;

/**
 *  Description  请求成功后回调
 *
 *  @param requestTag 请求tag
 *  @param jsonDic    请求响应的字典数据
 */
-(void)requestDidSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;
/**
 *  Description  请求失败后回调
 *
 *  @param requestItem 请求item
 *  @param jsonDic     请求响应失败的字典数据
 */
-(void)requestFailure:(YZRequestItem *)requestItem   withDic:(NSDictionary *)jsonDic;

/**
 *  Description  请求失败后回调
 *
 *  @param requestItem 请求item
 *  @param failureCode 请求响应的字符串数据
 */
-(void)requestFailure:(YZRequestItem *)requestItem  withCode:(NSString *)failureCode;

/**
 *  Description 请求错误回调
 *
 *  @param requestTag  请求tag
 *  @param jsonDic     请求错误的字典数据
 */
-(void)requestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;


@end
