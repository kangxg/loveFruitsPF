//
//  KGCouponCenterModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/27.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponCenterModel.h"
#import "KGUserModelManager.h"
#import "KGCouponModel.h"

@implementation KGCouponCenterModel
-(id)init
{
    if (self = [super init])
    {
        _YDCouponModelArr      = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(YZRequestItem * )KDCouponRequestItem
{
    if (_KDCouponRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        _KDCouponRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDCouponRequestItem.YNetworkRequestUrl = KGHOMECOUPONCENTERURL;
        _KDCouponRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponRequestItem;
}

-(YZRequestItem * )KDGetCouponRequestItem
{
    if (_KDGetCouponRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
            [paramDic setValue:uid forKey:@"uid"];
        }
        _KDGetCouponRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEC   withData:paramDic];
        _KDGetCouponRequestItem.YNetworkRequestUrl =  KGGETCOUPONCENTERURL;
        _KDGetCouponRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDGetCouponRequestItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    if (type == YZNETWORKVERIFICATIONFIR )
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
            [self putListData:arr];
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            state = YZPROCESSINGDATANULL;
        }
        
        block(state,type);

    }
  
}
-(void)putJsonDataBackMessage:(NSDictionary *)jsonDic  withBlock:(KGPutDataMessageBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    if (jsonDic == nil )
    {
        state = YZPROCESSINGDATAERROR;
        block(state,@"领取失败！");
        return;
    }
    
    NSString * achieve_status = [jsonDic valueForKey:@"achieve_status"];
    if (!achieve_status.length)
    {
        state = YZPROCESSINGDATANULL;
    }
    else
    {
        state = YZPROCESSINGDATASUCCESS;
    }
    block(state,achieve_status);

}

-(void)putListData:(NSArray *)arr
{
    
    [_YDCouponModelArr removeAllObjects];
    for (NSDictionary * dic in arr)
    {
        KGHomeCouponCenterModel * modle  = [[KGHomeCouponCenterModel alloc]init];
    
        [modle putInDataFordic:dic];
        
        [_YDCouponModelArr addObject:modle];
        
    }

}
@end
