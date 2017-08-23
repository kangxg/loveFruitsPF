//
//  KGCouponViewModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponViewModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
#import "KGCouponModel.h"
@implementation KGCouponViewModel
-(id)init
{
    if (self = [super init])
    {
        _YDUsedArr      = [[NSMutableArray alloc]init];
        _YDUnUseArr     = [[NSMutableArray alloc]init];
        _YDExpiredArr   = [[NSMutableArray alloc]init];
    }
    return self;
}
-(YZRequestItem * )KDCouponUnuseRequestItem
{
    if (_KDCouponUnuseRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
             [paramDic setValue:uid forKey:@"uid"];
        }
       
        [paramDic setValue:@"unused" forKey:@"coupon_type"];
        [paramDic setValue:@"100" forKey:@"coupon_limit"];
        _KDCouponUnuseRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDCouponUnuseRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponUnuseRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponUnuseRequestItem;
}
-(YZRequestItem * )KDCouponExpiredRequestItem
{
    if (_KDCouponExpiredRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@"expired" forKey:@"coupon_type"];
        [paramDic setValue:@"100" forKey:@"coupon_limit"];
        _KDCouponExpiredRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONTHI  withData:paramDic];
        _KDCouponExpiredRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponExpiredRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponExpiredRequestItem;
}

-(YZRequestItem * )KDCouponUsedRequestItem
{
    if (_KDCouponUsedRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@"used" forKey:@"coupon_type"];
        [paramDic setValue:@"100" forKey:@"coupon_limit"];
        _KDCouponUsedRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEC  withData:paramDic];
        _KDCouponUsedRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponUsedRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponUsedRequestItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    if (type == YZNETWORKVERIFICATIONFIR  )
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
            [self putUnuseListData:arr];
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            state = YZPROCESSINGDATANULL;
        }
        
        block(state,type);

    }
    else if(type == YZNETWORKVERIFICATIONSEC)
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
            [self putUsedListData:arr];
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            state = YZPROCESSINGDATANULL;
        }
        
        block(state,type);
    }
    else
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
            [self putExpiredListData:arr];
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            state = YZPROCESSINGDATANULL;
        }
        
        block(state,type);
    }
}
-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
    
    
}
-(void)putUnuseListData:(NSArray *)arr
{
    [_YDUnUseArr removeAllObjects];
    for (NSDictionary * dic in arr)
    {
        KGCouponModel * modle = nil;
        NSString * type = [dic valueForKey:@"coupon_type"];
        if ([type isEqualToString:@"unused"])
        {
            modle = [[KGUnUserCouponModel alloc]init];
            [_YDUnUseArr addObject:modle];
        }
        [modle putInDataFordic:dic];
        
    }

}

-(void)putExpiredListData:(NSArray *)arr
{
    [_YDExpiredArr removeAllObjects];
    for (NSDictionary * dic in arr)
    {
        KGCouponModel * modle = nil;
        NSString * type = [dic valueForKey:@"coupon_type"];
        if ([type isEqualToString:@"expired"])
        {
            modle = [[KGOverCouponModel alloc]init];
            [_YDExpiredArr addObject:modle];
        }

    }

}
-(void)putUsedListData:(NSArray *)arr
{
    [_YDUsedArr removeAllObjects];
    for (NSDictionary * dic in arr)
    {
        NSString * type = [dic valueForKey:@"coupon_type"];
        if ([type isEqualToString:@"used"])
        {
            KGCouponModel * modle = modle = [[KGUseCouponModel alloc]init];
            [_YDUsedArr addObject:modle];
             [modle putInDataFordic:dic];
        }
       
        
    }
    
}
@end
