//
//  YZNetworkRequestHelper.m
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import "YZNetworkRequestHelper.h"
#import "YZNetworkRequestPostHelper.h"
#import "YZNetworkRequestGetHelper.h"
#import "YZNetworkUploadSigleImageHelper.h"
#import "YZNetworkUploadvidelHelper.h"
#import "YZNetworkUploadMoreImageHelper.h"
#import "YZRequestItem.h"

@implementation YZNetworkRequestHelper

@synthesize YNetworkRequestCount           = _YNetworkRequestCount;
@synthesize YNetworkRequestVerificationMax = _YNetworkRequestVerificationMax;
@synthesize YNetworkRequestArr             = _YNetworkRequestArr;
@synthesize YNetworkFailureRequestArr      = _YNetworkFailureRequestArr;
@synthesize YNetworkRequestDelegate        = _YNetworkRequestDelegate;
@synthesize YRequestFinished               = _YRequestFinished;


+(instancetype)InstanceNetworkWithRequestType:(YZNetworkRequestType)requestType
{
    id<YZNetworkRequestHelperInterface>  networkrequest = nil;
    switch (requestType)
    {
         
         case YNETWORKHELPEPOSTREQUEST:
        {
            networkrequest = [[YZNetworkRequestPostHelper alloc]init];
        }
            break;
        
         case YNETWORKHELPEUPLOADVIDEO:
        {
            //networkrequest = [[YZNetworkUploadvidelHelper  alloc]init];
        }
            break;
         case YNETWORKHELPEUPLOADSIGLEIMAGE:
        {
            networkrequest = [[YZNetworkUploadSigleImageHelper alloc]init];
        }
            break;
         case YNETWORKHELPEUPLOADMOREIMAGE:
        {
            //networkrequest = [[YZNetworkUploadMoreImageHelper alloc]init];
        }
            break;
        case YNETWORKHELPEGETREQUEST:
        {
            networkrequest = [[YZNetworkRequestGetHelper alloc]init];
        }
            break;
        case YNETWORKHELPEUPLOADFILE:
        {
            
        }
            break;
        default:
            break;
    }
    
    return networkrequest;
}
-(void)setYRequestFinished:(BOOL)YRequestFinished
{
    _YRequestFinished = YRequestFinished;
    if (_YRequestFinished == YES)
    {
        if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestFinished)])
        {
            [self.YNetworkRequestDelegate pRequestFinished];
        }
    }
}
-(id)init
{
    if (self = [super init])
    {
        _YNetworkRequestCount = 0;
        _YNetworkRequestVerificationMax  = 0;
        //(1<< requestMax) | 1;
        
        _YNetworkFailureRequestArr       = [[NSMutableArray alloc]init];
        _YNetworkRequestArr              = [[NSMutableArray alloc]init];
        _YRequestFinished                = YES;
        
    }
    
    return self;
}

-(void)failureRequestSuccessBack:(YZRequestItem *)requestItem
{
    for (YZRequestItem * item in _YNetworkFailureRequestArr)
    {
        if (requestItem == item && requestItem.YRequestTag == item.YRequestTag)
        {
            [_YNetworkFailureRequestArr removeObject:item];
            break;
        }
    }
}
-(void)beginRequestWithItem:(YZRequestItem *)requestItem
{
    if (!requestItem)
    {
        NSAssert(!requestItem, @"请求数据模型参数不正确");
    }

    NSArray * arr = @[requestItem];
    [self beginRequest:arr];
    
}

-(void)beginRequest:(NSArray *)arr
{
      NSAssert(arr, @"请求数据模型参数不正确");
   
      _YNetworkRequestCount = _YNetworkRequestCount + arr.count;

}

-(void)requestDidSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{

    _YNetworkRequestCount --;
    MAX(_YNetworkRequestCount, 0);
    _YRequestFinished = !_YNetworkRequestCount;

    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestSuccess:withDic:)]) {
        [self.YNetworkRequestDelegate pRequestSuccess:requestItem withDic:jsonDic];
    }
    if (_YNetworkRequestCount == 0)
    {
        if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestFinished)])
        {
            [self.YNetworkRequestDelegate pRequestFinished];
        }
    }
    
    
}

-(void)requestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    MAX(--_YNetworkRequestCount, 0);
    self.YRequestFinished = !_YNetworkRequestCount;
    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestError:withDic:)])
    {
        [self.YNetworkRequestDelegate pRequestError:requestItem withDic:jsonDic];
    }
}

-(void)requestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    
    MAX(--_YNetworkRequestCount, 0);
    self.YRequestFinished = !_YNetworkRequestCount;
  
    if (self.YNetworkRequestDelegate && [self.YNetworkRequestDelegate respondsToSelector:@selector(pRequestFailure:withCode:)])
    {
        if (requestItem.YRequestOption.hasFailCache)
        {
            [_YNetworkFailureRequestArr addObject:requestItem];
        }
        [self.YNetworkRequestDelegate pRequestFailure:requestItem withCode:failureCode];
    }
}
-(void)addRequest:(NSArray *)arr
{
    if (!arr || arr.count == 0)
    {
        return;
    }
    
    [self beginRequest:arr];
}

-(void)addreRequestWithItem:(YZRequestItem *)requestItem
{
    if (!requestItem)
    {
        return;
    }
    [self beginRequestWithItem:requestItem];
}


-(void)transmitsFailureRequest:(YZRequestItem *)requestItem
{
    if ([_YNetworkFailureRequestArr containsObject:requestItem])
    {
        [self failureRequestSuccessBack:requestItem];
        
    }
    
    [self beginRequestWithItem:requestItem];
}
-(void)transmitsAllFailRequest
{
    [self beginRequest:_YNetworkFailureRequestArr];
}
-(void)transmitsRequest
{
//    [self transmitsAllFailRequest];
}




@end
