//
//  YZNetworkUploadSigleImage.m
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "YZNetworkUploadSigleImageHelper.h"
#import "KGUploadSingleImageService.h"
#import "YZUploadSingleImageItem.h"
@implementation YZNetworkUploadSigleImageHelper
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
    
    for (YZUploadSingleImageItem * requestItem in arr)
    {
        if (requestItem)
        {
            __weak YZUploadSingleImageItem * item = requestItem;
            if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pUpdateWillBegin:)])
            {
                [self.YNetworkRequestDelegate pUpdateWillBegin:requestItem ];
                 
                
            }
            [KGUploadSingleImageService uploadImageWithUrl:requestItem.YNetworkRequestUrl
                                            imagefileName:requestItem.YFileName imageData:requestItem.YImageData parameters:requestItem.YRequestDic
                                                   success:^(id object)
            {
                NSMutableDictionary * jsonDic = object;
                //=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
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
                NSError * error = object;
                       [self requestFailure:item withCode:error.localizedDescription];
            }];
//            [KGBaseNetworkService POST:requestItem.YNetworkRequestUrl
//                                params:requestItem.YRequestDic
//                               success:^(id object)
//             {
//                 NSMutableDictionary * jsonDic=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
//                 
//                 float sucess = [[jsonDic objectForKey:@"success"] boolValue];
//                 
//                 if (sucess)
//                 {
//                     [self failureRequestSuccessBack:item];
//                     [self requestDidSuccess:item withDic:jsonDic];
//                 }
//                 else
//                 {
//                     [self requestError:item withDic:jsonDic];
//                 }
//                 
//             }
//             
//                                failed:^(id object)
//             {
//                 NSError *error = object;
//                 [self requestFailure:item withCode:error.localizedDescription];
//             }];
            
            
            
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
    MAX(--self.YNetworkRequestCount, 0);
    self.YRequestFinished = !self.YNetworkRequestCount;

    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pUpdateError:withDic:)])
    {
        [self.YNetworkRequestDelegate pUpdateError:requestItem withDic:jsonDic];
//        [self.YNetworkRequestDelegate pRequestError:requestTag withDic:jsonDic];
    }
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
