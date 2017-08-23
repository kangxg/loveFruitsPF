//
//  YZRequestModel.h
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZNetworkRequestHelpEnum.h"
#import "YZNetworkHeader.h"
@interface YZRequestItem : NSObject
/**
 *  Description 请求体
 */
@property (nonatomic,retain,readonly)NSMutableDictionary * YRequestDic;
/**
 *  Description 请求标记
 */
@property (nonatomic,assign,readonly)YZNetworkRequestVerification     YRequestTag;

/**
 *  Description  网络请求链接地址字符串
 */
@property (nonatomic,copy)NSString * YNetworkRequestUrl;

//请求相应的操作
@property (nonatomic,assign)YZRequestOptions       YRequestOption;
//请对任务针对的对象
@property (nonatomic,weak)id                       YOpationObject;

-(instancetype)initRequestModel:(YZNetworkRequestVerification)tag withData:(NSDictionary *)dic;
-(void)setRequestDic:(NSDictionary *)dic;
-(void)setRequestDic:(NSString *)key withValue:(NSString *)value;
@end
