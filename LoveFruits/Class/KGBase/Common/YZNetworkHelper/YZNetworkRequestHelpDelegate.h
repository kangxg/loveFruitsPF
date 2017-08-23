//
//  YZNetworkRequestHelpDelegate.h
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//
/**
 *  Description  网络请求辅助管理 代理
 */
#import <Foundation/Foundation.h>
#import "YZNetworkRequestHelpEnum.h"
@class YZRequestItem;
@protocol YZNetworkRequestHelpDelegate <NSObject>
@optional
/**
 *  Description       请求将要开始
 *
 *  @param requestItem 请求 item
 */
-(void)pRequestWillBegin:(YZRequestItem *)requestItem;
/**
 *  Description       请求成功
 *
 *  @param requestItem 请求 item
 *  @param jsonDic    成功字典数据
 */
-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;
/**
 *  Description       请求成功
 *
 *  @param requestTag 请求 item tag
 *  @param jsonData   成功二进制数据
 */
-(void)pRequestSuccess:(YZRequestItem *)requestItem withData:(NSData *)jsonData;
/**
 *  Description       请求错误
 *
 *  @param requestTag 请求错误 item tag
 *  @param jsonData   错误二进制数据
 */
-(void)pRequestError:(YZRequestItem *)requestItem  withData:(NSData *)jsonData;

/**
 *  Description       请求错误
 *
 *  @param requestTag 请求错误 item tag
 *  @param jsonDic    错误字典数据
 */
-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;
/**
 *  Description       请求失败
 *
 *  @param requestTag 请求item tag
 *  @param jsonData   请求失败二进制数据
 */
-(void)pRequestFailure:(YZRequestItem *)requestItem withData:(NSData *)jsonData;

/**
 *  Description         请求失败
 *
 *  @param requestTag   请求item tag
 *  @param failureCode  请求失败字符串
 */
-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode;

/**
 *  Description 所有请求完成
 */
-(void)pRequestFinished;

-(void)pUpdateWillBegin:(YZRequestItem *)requestItem;



-(void)pUpdateSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;


-(void)pUpdateSuccess:(YZRequestItem *)requestItem withData:(NSData *)jsonData;

-(void)pUpdateError:(YZRequestItem *)requestItem withData:(NSData *)jsonData;

-(void)pUpdateError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic;

-(void)pUpdateFailure:(YZRequestItem *)requestItem withData:(NSData *)jsonData;

-(void)pUpdateFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode;

-(void)pUpdateFinished;
@end
