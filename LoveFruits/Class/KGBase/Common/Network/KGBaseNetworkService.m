//
//  KGBaseNetworkService.m
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseNetworkService.h"

@implementation KGBaseNetworkService
+ (AFNetworkReachabilityStatus)networkReachabilityStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    return manager.networkReachabilityStatus;
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requestFailed) {
            requestFailed(error);
        }
    }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requestFailed) {
            requestFailed(error);
        }
    }];
}


+(void)uploadImageWithUrl:(NSString *)urlStr imagefileName:(NSString*)name imageData:(NSData *)imagedata parameters:(id)parameters success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    @throw [[NSException alloc] initWithName:@"ExceptionName"                                                      reason:@"网络请求基类不提供此功能，需要调用响应子类处理"
                                    userInfo:nil];
}

+(void)uploadImagesWithUrl:(NSString *)urlStr parameters:(id)parameters withImags:(NSArray *)images success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    @throw [[NSException alloc] initWithName:@"ExceptionName"                                                      reason:@"网络请求基类不提供此功能，需要调用响应子类处理"
                                    userInfo:nil];
}
@end
