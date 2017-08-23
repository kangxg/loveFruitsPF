//
//  KGHomeModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeModel.h"
#import "YZRequestItem.h"
#import "KGHomeGoodsAdsModel.h"
#import "KGHomeHeadResources.h"
@implementation KGHomeModel
@synthesize KDAdvertRequestItem      = _KDAdvertRequestItem;
@synthesize KDListRequestItem        = _KDListRequestItem;
@synthesize KDShopInfoRequestItem    = _KDShopInfoRequestItem;
@synthesize KDAdsModelArr               = _KDAdsModelArr;
@synthesize KDShopInformation        = _KDShopInformation;
-(id)init
{
    if (self = [super init])
    {
        _KDAdsModelArr = [[NSMutableArray alloc]init];
        [self createHeadData];
       
    }
    return self;
}
-(void)createHeadData
{
    _KDHeadData = [[HeadData alloc]init];
    Activities * ac = [[Activities alloc]init];
    ac.name  = @"购买";
    ac.img   = @"buy";
    [_KDHeadData.icons addObject:ac];
    
    Activities * ac2 = [[Activities alloc]init];
    ac2.name  = @"热门";
    ac2.img   = @"hot";
    [_KDHeadData.icons addObject:ac2];
    
    Activities * ac3 = [[Activities alloc]init];
    ac3.name  = @"优惠券";
    ac3.img   = @"coupon";
    [_KDHeadData.icons addObject:ac3];
    
    Activities * ac4 = [[Activities alloc]init];
    ac4.name  = @"订单";
    ac4.img   = @"order";
    [_KDHeadData.icons addObject:ac4];
}
-(YZRequestItem * )KDAdvertRequestItem
{
    if (_KDAdvertRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:@"1" forKey:@"type"];
       
        _KDAdvertRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDAdvertRequestItem.YNetworkRequestUrl = KGHOMEADVERTURL;
        _KDAdvertRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDAdvertRequestItem;
}

-(YZRequestItem * )KDListRequestItem
{
    if (_KDListRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:@"2" forKey:@"type"];
        
        _KDListRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEC  withData:paramDic];
        _KDListRequestItem.YNetworkRequestUrl = KGHOMEADVERTURL;
        _KDListRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDListRequestItem;
}


-(YZRequestItem * )KDShopInfoRequestItem
{
    if (_KDShopInfoRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:@"2" forKey:@"type"];
        
        _KDShopInfoRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONTHI  withData:paramDic];
        _KDShopInfoRequestItem.YNetworkRequestUrl = KGHOMEWARINSTURL ;
        _KDShopInfoRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDShopInfoRequestItem;
}


-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    if (jsonDic == nil )
    {
        state = YZPROCESSINGDATAERROR;
        block(state,type);
        return;
    }
    
     NSDictionary * dic  =    [jsonDic valueForKey:@"data"];
    if (!dic)
    {
        state = YZPROCESSINGDATANULL;
        block(state,type);
        return;
    }
    
    switch (type) {
        case YZNETWORKVERIFICATIONSEC:
        {
            [_KDAdsModelArr removeAllObjects];
            [self processingFirstAds:[dic valueForKey:@"cpOne"]];
            [self processingSecondAds:[dic valueForKey:@"cpTwo"]];
            [self processingThirdAds:[dic valueForKey:@"cpThree"]];
            [self processingFourthAds:[dic valueForKey:@"cpFour"]];

            [self sortAds];
            state = YZPROCESSINGDATASUCCESS;
//
        }
            break;
        case YZNETWORKVERIFICATIONTHI:
        {
            //_KDShopInformation = [dic valueForKey:@"imgUrl"];
            _KDShopInformation = @"http://video.yizijob.com/upload/20161005/oper/videoCover/1475639032157.jpg";
             state = YZPROCESSINGDATASUCCESS;
        }
            break;
        case YZNETWORKVERIFICATIONFIR:
        {

            NSArray *  arr = [jsonDic valueForKey:@"data"];
            if (arr )
            {
                if ([_KDHeadData putInDataForArr:arr])
                {
                    state = YZPROCESSINGDATASUCCESS;
                }
                else
                {
                    state = YZPROCESSINGDATAERROR;
                    
                }
            }
            else
            {
                state = YZPROCESSINGDATANULL;

            }
            //_KDShopInformation = [dic valueForKey:@"imgUrl"];
//            _KDShopInformation = @"http://video.yizijob.com/upload/20161005/oper/videoCover/1475639032157.jpg";
           
        }
            break;
        default:
            break;
    }
    block(state,type);
    
}


-(void)sortAds
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pid" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
    
    [_KDAdsModelArr sortUsingDescriptors:descriptors];
    for (KGHomeGoodsAdsModel * mode in _KDAdsModelArr)
    {
        NSLog(@"pid = %ld,type  = %ld",mode.pid,mode.adsType);
    }
}

-(void)processingFirstAds:(NSArray *)arr
{
    for (NSDictionary * dic in arr)
    {
        KGHomeFirstAdsModel * model = [[KGHomeFirstAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_KDAdsModelArr addObject:model];
    }
    
}

-(void)processingSecondAds:(NSArray *)arr
{
    for (NSDictionary * dic in arr)
    {
        KGHomeSecondAdsModel * model = [[KGHomeSecondAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_KDAdsModelArr addObject:model];
    }

}
-(void)processingThirdAds:(NSArray *)arr
{
    for (NSDictionary * dic in arr)
    {
        KGHomeThirdAdsModel * model = [[KGHomeThirdAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_KDAdsModelArr addObject:model];
    }

   

}

-(void)processingFourthAds:(NSArray *)arr
{
    for (NSDictionary * dic in arr)
    {
        KGHomeFourthAdsModel * model = [[KGHomeFourthAdsModel alloc]init];
        [model putInDataFordic:dic];
        [_KDAdsModelArr addObject:model];
    }
}
@end
