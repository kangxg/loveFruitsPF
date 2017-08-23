//
//  KGOrderDetailViewModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderDetailViewModel.h"
#import "YZRequestItem.h"
@implementation KGOrderDetailModel
-(id)init
{
    if (self = [super init])
    {
        _KDOrderWaresArr = [[NSMutableArray alloc]init];
        _KDOrderCoupon   = @"0";
        _KDOrderAmount   = @"0";

    }
    return self;
}


-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic   = data;
    _KDOrderId           =  [dic valueForKey:@"order_id"];
    _KDCreateTime        =  [dic valueForKey:@"create_time"];
    _KDOrderAmount       =  [dic valueForKey:@"order_amount"];
    _KDOrderStatus       =  [dic valueForKey:@"order_status"];
    _KDOrderCoupon       =  [dic valueForKey:@"order_coupon"];
    _KDOrderFreigh       =  [dic valueForKey:@"order_freight"];

    _KDOrderPoint        =  [dic valueForKey:@"order_point"];
     NSDictionary * addic = [dic valueForKey:@"order_addr"];
    _KDOrderUserName     = [addic valueForKey:@"addr_consignee"];
    _KDPhone     = [addic valueForKey:@"addr_phone"];
    _KDOrderAdress     = [addic valueForKey:@"addr_detail"];
    NSArray * arr = [dic valueForKey:@"order_wares"];
    for (NSDictionary * wareDic in arr)
    {
        KGOrderWaresModel * model = [[KGOrderWaresModel alloc]init];
        [model putInDataFordic:wareDic];
        [_KDOrderWaresArr addObject:model];
    }
    return YES;
}
@end

@implementation KGOrderDetailViewModel
-(id)init
{
    if (self = [super init])
    {
        _KDDetailModel = [[KGOrderDetailModel alloc]init];
    }
    return self;
}

-(void)setKDTypeMessage:(NSString *)KDTypeMessage
{
    _KDDetailModel.KDTypeMessage = KDTypeMessage;
}
-(YZRequestItem * )KDOrdersItem
{
    if (_KDOrdersItem == nil)
    {
        NSMutableDictionary * paramDic=[[NSMutableDictionary alloc]init];
        [paramDic setValue:_KDOrderId forKey:@"order_id"];
        _KDOrdersItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDOrdersItem.YNetworkRequestUrl = KGORDERDETAILURL ;
        _KDOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
    }
    return _KDOrdersItem;
}

-(YZRequestItem * )KDDeleteOrdersItem
{
    if (_KDDeleteOrdersItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
         [paramDic setValue:_KDOrderId forKey:@"order_id"];
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
         [paramDic setValue:_KDOrderId forKey:@"order_id"];
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
         [paramDic setValue:_KDOrderId forKey:@"order_id"];
        _KDCannelOrdersItem = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONEIG  withData:paramDic];
        _KDCannelOrdersItem.YNetworkRequestUrl = KGCANCELORDERURL;
        _KDCannelOrdersItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCannelOrdersItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    switch (type) {
        case YZNETWORKVERIFICATIONFIR:
        {
            [self toDealWithOrderDetail:jsonDic WithType:type withBlock:block];
        }
            break;
            
        default:
            break;
    }
}

-(void)toDealWithOrderDetail:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block

{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    if (jsonDic == nil )
    {
        state = YZPROCESSINGDATAERROR;
        block(state,type);
        return;
    }
    
    NSDictionary * dic  =    [jsonDic valueForKey:@"data"];
    if (dic)
    {
         [_KDDetailModel putInDataFordic:dic];
         state = YZPROCESSINGDATASUCCESS;
    }
    else
    {
        state = YZPROCESSINGDATANULL;
    }
    block(state,type);

}
@end
