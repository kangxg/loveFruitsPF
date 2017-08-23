//
//  YGNetworkInterface.h
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineBlock.h"
#import "AFNetworking.h"
#import "KGNetworkHeader.h"
@protocol KGNetworkInterface <NSObject>
@optional
/**
 *  @author kxg, 16-5-20
 *
 *  @brief  网络连接状态
 *
 *  @return
 */
+ (AFNetworkReachabilityStatus)networkReachabilityStatus;
/**
 *  @author kxg, 16-5-20
 *
 *  @brief  请求网络数据
 *
 *  @param url
 *  @param params
 *  @param KGRequestSuccessBlock 网络请求成功后回调
 *  @param KGRequestFaildBlock
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed;
/**
 *  @author kxg, 16-5-20
 *
 *  @brief  提交数据到服务器
 *
 *  @param url
 *  @param params
 *  @param KGRequestSuccessBlock
 *  @param KGRequestFaildBlock
 */
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed;

/**
 *  @author kxg, 16-5-20
 *
 *  @brief  提交数据到服务器
 *
 *  @param urlStr
 *  @param name
 *  @param params
 *  @param KGRequestSuccessBlock
 *  @param KGRequestFaildBlock
 */
+(void)uploadImageWithUrl:(NSString *)urlStr imagefileName:(NSString*)name imageData:(NSData *)imagedata parameters:(id)parameters success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed;

//update more images
+(void)uploadImagesWithUrl:(NSString *)urlStr parameters:(id)parameters withImags:(NSArray *)images success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed;
@end
