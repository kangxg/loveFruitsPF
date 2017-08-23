//
//  YZNetworkRequestPostHelper.m
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import "YZNetworkRequestPostHelper.h"
#import "YZRequestItem.h"
#import "KGBaseNetworkService.h"
@implementation YZNetworkRequestPostHelper
-(id)init
{
    if (self = [super init])
    {
       
    }
    
    return self;
}

-(void)beginRequest:(NSArray *)arr
{
    if (!arr)
    {
        return;
    }
    [super beginRequest:arr];
    
    for (YZRequestItem * requestItem in arr)
    {
        if (requestItem)
        {
            __weak YZRequestItem * item = requestItem;
            if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestWillBegin:)])
            {
                [self.YNetworkRequestDelegate pRequestWillBegin:requestItem];
            }
            [KGBaseNetworkService POST:requestItem.YNetworkRequestUrl
                                params:requestItem.YRequestDic
                               success:^(id object)
                                {
                                    NSMutableDictionary * jsonDic = nil;
                                    if ([object isKindOfClass:[NSDictionary class]]) {
                                         jsonDic = object;
                                    }
                                    else
                                    {
                                       jsonDic=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
                                    }
                                   

                                   float sucess = [[jsonDic objectForKey:@"status"] boolValue];
                                   
                                   if (sucess)
                                   {
                                       [self failureRequestSuccessBack:item];
                                       [self requestDidSuccess:item withDic:jsonDic];
                                   }
                                   else
                                   {
                                       [self requestError:item withDic:jsonDic];
                                   }

                                }
             
                                failed:^(id object)
                                {
                                    NSError *error = object;
                                    [self requestFailure:item withCode:error.localizedDescription];
                                }];
            
            

        }
    }
    
}

-(void)failureRequestSuccessBack:(YZRequestItem *)requestItem
{
    [super failureRequestSuccessBack:requestItem];
}

-(void)requestDidSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super requestDidSuccess:requestItem withDic:jsonDic];
}

-(void)requestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super requestError:requestItem withDic:jsonDic];
}

-(void)requestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    [super requestFailure:requestItem withCode:failureCode];
}

-(void)beginRequestWithItem:(YZRequestItem *)requestItem
{
    if (!requestItem)
    {
        return;
    }
    
    [super beginRequestWithItem:requestItem];
}

-(void)addRequest:(NSArray *)arr
{
  
    [super addRequest:arr];
}

-(void)addreRequestWithItem:(YZRequestItem *)requestItem
{
    [super addreRequestWithItem:requestItem];
}

-(void)transmitsRequest
{
    [super transmitsRequest];
}

-(void)transmitsAllFailRequest
{
    [super transmitsAllFailRequest];
}
@end
