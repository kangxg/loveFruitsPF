//
//  YZNetworkUploadMoreImageHelper.m
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "YZNetworkUploadMoreImageHelper.h"
#import "YZUploadMoreImageItem.h"
#import "KGUploadMoreImageService.h"
@implementation YZNetworkUploadMoreImageHelper
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
    
    for (YZUploadMoreImageItem * requestItem in arr)
    {
        if (requestItem)
        {
            __weak YZUploadMoreImageItem * item = requestItem;
            if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestWillBegin:)])
            {
                [self.YNetworkRequestDelegate pUpdateWillBegin:requestItem ];
                
                
            }
            [KGUploadMoreImageService uploadImagesWithUrl:requestItem.YNetworkRequestUrl             parameters:requestItem.YRequestDic
                                                withImags:requestItem.YImageArray success:^(id object)
            {
                NSMutableDictionary * jsonDic=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
                float sucess = [[jsonDic objectForKey:@"success"] boolValue];
                if (sucess)
                {
                    
                    [self failureRequestSuccessBack:item];
                    [self requestDidSuccess:item withDic:jsonDic];
                }
                else
                {
                    [self requestError:item withDic:jsonDic];
                }

                
            } failed:^(id object)
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
    self.YNetworkRequestCount--;
    
    
    MAX(self.YNetworkRequestCount, 0);
    self.YRequestFinished = !self.YNetworkRequestCount;
    
    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pUpdateSuccess:withDic:)]) {
        [self.YNetworkRequestDelegate pRequestSuccess:requestItem withDic:jsonDic];
    }
    if (self.YNetworkRequestCount == 0)
    {
        if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pUpdateFinished)])
        {
            [self.YNetworkRequestDelegate pUpdateFinished];
        }
    }
    
}

-(void)requestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    [super requestError:requestItem withDic:jsonDic];
}

-(void)requestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    self.YNetworkRequestCount --;
    MAX( self.YNetworkRequestCount, 0);
    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pUpdateFailure:withCode:)])
    {
        [self.YNetworkFailureRequestArr addObject:requestItem];
        [self.YNetworkRequestDelegate pUpdateFailure:requestItem withCode:failureCode ];
        
        
    }
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
