//
//  KGGoodsClassifiedAdsModel.m
//  LoveFruits
//
//  Created by kangxg on 16/10/4.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeGoodsAdsModel.h"
#import "KGGoodsAdsModel.h"

@implementation KGHomeGoodsAdsModel
@dynamic pid;
@dynamic adsType;
@dynamic goodsArr;
@dynamic cpName;
@end

#pragma mark
#pragma mark -------------第一类广告--------------
/**
 *  Description 第一类广告
 */
@implementation KGHomeFirstAdsModel
@synthesize pid           = _pid;
@synthesize adsType       = _adsType;
@synthesize imgUrl        = _imgUrl;
@synthesize detailUrl     = _detailUrl;
@synthesize cpName        = _cpName;
-(id)init
{
    if (self = [super init])
    {
        _adsType = KGGOODSADSTYPEFIRST ;
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic  =  data;
    _pid                =  [[dic valueForKey:@"id"]integerValue];
    _detailUrl          =  [dic valueForKey:@"detailUrl"];
    _imgUrl             =  [dic valueForKey:@"imgUrl"];
    _cpName             =  [dic valueForKey:@"cpName"];
    return YES;
    
}
@end

#pragma mark
#pragma mark -------------第二类广告--------------
/**
 *  Description 第2类广告
 */
@implementation KGHomeSecondAdsModel
@synthesize pid            =  _pid;
@synthesize adsType        =  _adsType;
@synthesize detailUrlLeft  =  _detailUrlLeft;
@synthesize detailUrlDown  =  _detailUrlDown;
@synthesize detailUrlUp    =  _detailUrlUp;
@synthesize imgUrlUp       =  _imgUrlUp;
@synthesize imgUrlDown     =  _imgUrlDown;
@synthesize imgUrlLeft     =  _imgUrlLeft;
@synthesize cpNameUp       =  _cpNameUp;
@synthesize cpNameDown     =  _cpNameDown;
@synthesize cpNameLeft     =  _cpNameLeft;

-(id)init
{
    if (self = [super init])
    {
        _adsType = KGGOODSADSTYPESECOND;
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }

    NSDictionary * dic =  data;
    _pid               =  [[dic valueForKey:@"id"]integerValue];
    _detailUrlDown     =  [dic valueForKey:@"detailUrlDown"];
    _detailUrlUp       =  [dic valueForKey:@"detailUrlUp"];
    _detailUrlLeft     =  [dic valueForKey:@"detailUrlLeft"];
    
    _imgUrlUp          =  [dic valueForKey:@"imgUrlUp"];
    _imgUrlDown        =  [dic valueForKey:@"imgUrlDown"];
    _imgUrlLeft        =  [dic valueForKey:@"imgUrlLeft"];
    
    _cpNameLeft        =  [dic valueForKey:@"cpNameLeft"];
    _cpNameDown        =  [dic valueForKey:@"cpNameDown"];
    _cpNameUp          =  [dic valueForKey:@"cpNameUp"];
    
    
    return YES;
    
}
@end

#pragma mark
#pragma mark -------------第三类广告--------------
/**
 *  Description 第3类广告
 */
@implementation KGHomeThirdAdsModel

@synthesize pid           = _pid;
@synthesize adsType       = _adsType;
@synthesize detailUrl     = _detailUrl;
@synthesize goodsArr      = _goodsArr;
@synthesize imgUrl        = _imgUrl;
@synthesize cpName        = _cpName;
-(id)init
{
    if (self = [super init])
    {
        _adsType = KGGOODSADSTYPETHIRD;
        _goodsArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic = data;
    _pid               = [[dic valueForKey:@"id"]integerValue];
    _detailUrl         = [dic valueForKey:@"detailUrl"];
    _imgUrl            = [dic valueForKey:@"imgUrl"];
    _cpName             =  [dic valueForKey:@"cpName"];
    NSArray * list     = [dic valueForKey:@"list"];
    for (NSDictionary * dic  in list)
    {
        KGGoodsAdsModel * model = [[KGGoodsAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_goodsArr addObject:model];
    }
    
    return YES;
    
}
@end


#pragma mark
#pragma mark -------------第四类广告--------------
/**
 *  Description 第4类广告
 */
@implementation KGHomeFourthAdsModel
@synthesize pid           = _pid;
@synthesize adsType       = _adsType;
@synthesize detailUrl     = _detailUrl;
@synthesize imgUrl        = _imgUrl;
@synthesize goodsArr      = _goodsArr;

-(id)init
{
    if (self = [super init])
    {
        _adsType = KGGOODSADSTYPEFOURCH ;
         _goodsArr = [[NSMutableArray alloc]init];
        
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic = data;
    _pid               = [[dic valueForKey:@"id"]integerValue];
    _detailUrl         = [dic valueForKey:@"detailUrl"];
    _imgUrl            = [dic valueForKey:@"imgUrl"];
    NSArray * list     = [dic valueForKey:@"list"];
    for (NSDictionary * dic  in list)
    {
        KGGoodsAdsModel * model = [[KGGoodsAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_goodsArr addObject:model];
    }
    
    return YES;
    
}
@end
