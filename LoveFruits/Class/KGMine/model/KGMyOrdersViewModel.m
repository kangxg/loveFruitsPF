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
-(YZRequestItem * )KDOrdersRequestItem
{
    if (_KDOrdersRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        if([[KGUserModelManager  shareInstanced] getUserModel].KUserId)
        {
             NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
             [paramDic setValue:uid forKey:@"uid"];
        }
    
        [paramDic setValue:@(999) forKey:@"order_status"];
        _KDOrdersRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDOrdersRequestItem.YNetworkRequestUrl = KGUSERORDERSNURL;
        _KDOrdersRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDOrdersRequestItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    if (jsonDic == nil )
    {
        state = YZPROCESSINGDATAERROR;
        block(state);
        return;
    }
    
//    NSArray * arr  =    [jsonDic valueForKey:@"data"];
    NSArray * arr  =    @[@{@"order_id":@"ws7579399",@"create_time":@"2016-11.12",@"order_amount":@"100",@"order_status":@"1",@"order_point":@"100"},@{@"order_id":@"ws7579399",@"create_time":@"2016-11.12",@"order_amount":@"100",@"order_status":@"2",@"order_point":@"100"},@{@"order_id":@"ws7579399",@"create_time":@"2016-11.12",@"order_amount":@"100",@"order_status":@"3",@"order_point":@"100"}];
    if (arr.count)
    {
        [self putListData:arr];
        state = YZPROCESSINGDATASUCCESS;
    }
    else
    {
        state = YZPROCESSINGDATANULL;
    }
    
    block(state);
    
}
-(void)putListData:(NSArray *)arr
{
    for (NSDictionary * dic in arr)
    {
    }
}
@end
