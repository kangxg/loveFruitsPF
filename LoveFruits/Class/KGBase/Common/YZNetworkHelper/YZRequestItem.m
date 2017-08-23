//
//  YZRequestModel.m
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import "YZRequestItem.h"
#import "KGNetworkHeader.h"
@implementation YZRequestItem
@synthesize YRequestDic = _YRequestDic;
@synthesize YRequestTag = _YRequestTag;
@synthesize YNetworkRequestUrl = _YNetworkRequestUrl;
-(instancetype)initRequestModel:(YZNetworkRequestVerification)tag withData:(NSDictionary *)dic
{
    if (self = [super init])
    {
        _YRequestDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        [self setRequestDic:dic];
        _YRequestTag = tag;
    }
    
    return self;
}

-(void)setRequestDic:(NSDictionary *)dic
{
    if (_YRequestDic)
    {
        [_YRequestDic removeAllObjects];
        [_YRequestDic setDictionary:dic];
    }
    else
    {
        _YRequestDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    }
}

-(void)setRequestDic:(NSString *)key withValue:(NSString *)value
{
    if (!_YRequestDic)
    {
        _YRequestDic = [[NSMutableDictionary alloc]init];
    }
    [_YRequestDic setObject:value forKey:key];
}

-(NSString *)YNetworkRequestUrl
{
    if (_YNetworkRequestUrl.length<1)
    {
        return KGBaseUrl;
    }
    else if (![_YNetworkRequestUrl hasPrefix:@"http"])
    {
        _YNetworkRequestUrl = URL(KGBaseUrl, _YNetworkRequestUrl);
    }
    
    return _YNetworkRequestUrl;
}

-(void)setYNetworkRequestUrl:(NSString *)YNetworkRequestUrl
{
    if (YNetworkRequestUrl.length <1)
    {
       _YNetworkRequestUrl =  KGBaseUrl;
    }
    else if (![_YNetworkRequestUrl hasPrefix:@"http"])
    {
        _YNetworkRequestUrl = URL(KGBaseUrl, YNetworkRequestUrl);

    }
    else
    {
        _YNetworkRequestUrl = @"";
    }

}
@end
