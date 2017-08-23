//
//  KGMyOrdersViewModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMyOrdersViewModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"

@implementation KGMyOrdersViewModel
-(id)init
{
    if (self = [super init])
    {
        _KDAllOrdersArr   = [[NSMutableArray alloc]init];
        _KDWillPayArr     = [[NSMutableArray alloc]init];
        _KDWillSendArr    = [[NSMutableArray alloc]init];
        _KDWillReciveArr  = [[NSMutableArray alloc]init];
        _KDOverArr        = [[NSMutableArray alloc]init];
    }
    return self;
}
-(YZRequestItem * )KDGetAllOrdersItem
{
    if (_KDGetAllOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
             NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
             [paramDic setValue:uid forKey:@"uid"];
        }
    
        [paramDic setValue:@(999) forKey:@"order_status"];
        _KDGetAllOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDGetAllOrdersItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDGetAllOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDGetAllOrdersItem;
}

-(YZRequestItem * )KDWillPayOrdersItem
{
    if (_KDWillPayOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
            NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@(0) forKey:@"order_status"];
        _KDWillPayOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEC  withData:paramDic];
        _KDWillPayOrdersItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDWillPayOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDWillPayOrdersItem;
}

-(YZRequestItem * )KDWillSendOrdersItem
{
    if (_KDWillSendOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
            NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@(1) forKey:@"order_status"];
        _KDWillSendOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONTHI  withData:paramDic];
        _KDWillSendOrdersItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDWillSendOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDWillSendOrdersItem;
}

-(YZRequestItem * )KDWillReciveOrdersItem
{
    if (_KDWillReciveOrdersItem== nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
            NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@(2) forKey:@"order_status"];
        _KDWillReciveOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFOU  withData:paramDic];
        _KDWillReciveOrdersItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDWillReciveOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDWillReciveOrdersItem;
}

-(YZRequestItem * )KDOverOrdersItem
{
    if (_KDOverOrdersItem== nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
            NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@(3) forKey:@"order_status"];
        _KDOverOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIF  withData:paramDic];
        _KDOverOrdersItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDOverOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDOverOrdersItem;
}


-(YZRequestItem * )KDDeleteOrdersItem
{
    if (_KDDeleteOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        _KDDeleteOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSIX  withData:paramDic];
        _KDDeleteOrdersItem.YNetworkRequestUrl = KGDELETEORDERURL;
        _KDDeleteOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDDeleteOrdersItem;
}

-(YZRequestItem * )KDEnterOrdersItem
{
    if (_KDEnterOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        _KDEnterOrdersItem = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEV  withData:paramDic];
        _KDEnterOrdersItem.YNetworkRequestUrl = KGCONFIRMORDERURL;
        _KDEnterOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDEnterOrdersItem;
}

-(YZRequestItem * )KDCannelOrdersItem
{
    if (_KDCannelOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        _KDCannelOrdersItem = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONEIG  withData:paramDic];
        _KDCannelOrdersItem.YNetworkRequestUrl = KGCANCELORDERURL;
        _KDCannelOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCannelOrdersItem;
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
    NSArray * arr  =    [jsonDic valueForKey:@"data"];
    if (arr.count)
    {
        switch (type)
        {
            case YZNETWORKVERIFICATIONFIR :
            {
                [self putAllListData:arr];
            }
                break;
            case YZNETWORKVERIFICATIONSEC:
            {
                [self putWillPayListData:arr];
            }
                break;
            case YZNETWORKVERIFICATIONTHI :
            {
                [self putWillSendListData:arr];
            }
                break;
            case YZNETWORKVERIFICATIONFOU :
            {
                [self putWillReciveListData:arr];
            }
                break;
            case YZNETWORKVERIFICATIONFIF :
            {
                [self putOverListData:arr];
            }
                break;
                
            default:
                break;
        }
        state = YZPROCESSINGDATASUCCESS;
    }
    else
    {
        state = YZPROCESSINGDATANULL;
    }
    
    block(state,type);
}
-(void)putAllListData:(NSArray *)arr
{
    if ([arr count])
    {
        [_KDAllOrdersArr removeAllObjects];
    }
    for (NSDictionary * dic in arr)
    {
        KGOrderModel * model = [[KGOrderModel alloc]init];
        [model putInDataFordic:dic];
        [_KDAllOrdersArr addObject:model];
        
    }
}
-(void)putWillPayListData:(NSArray *)arr
{
    if ([arr count])
    {
        [_KDWillPayArr removeAllObjects];
    }
    for (NSDictionary * dic in arr)
    {
        
        KGOrderModel * model = [[KGOrderModel alloc]init];
        [model putInDataFordic:dic];
        [_KDWillPayArr addObject:model];
    }
}

-(void)putWillSendListData:(NSArray *)arr
{
    if ([arr count])
    {
        [_KDWillSendArr removeAllObjects];
    }
    for (NSDictionary * dic in arr)
    {
        KGOrderModel * model = [[KGOrderModel alloc]init];
        [model putInDataFordic:dic];
        [_KDWillSendArr addObject:model];
        
    }
}
-(void)putWillReciveListData:(NSArray *)arr
{
    if ([arr count])
    {
        [_KDWillReciveArr removeAllObjects];
    }
    for (NSDictionary * dic in arr)
    {
        
        KGOrderModel * model = [[KGOrderModel alloc]init];
        [model putInDataFordic:dic];
        [_KDWillReciveArr addObject:model];
    }
}

-(void)putOverListData:(NSArray *)arr
{
    if ([arr count])
    {
        [_KDOverArr removeAllObjects];
    }
    for (NSDictionary * dic in arr)
    {
        
        KGOrderModel * model = [[KGOrderModel alloc]init];
        [model putInDataFordic:dic];
        [_KDOverArr addObject:model];
    }
}
@end
