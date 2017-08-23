//
//  KGSelectCouponViewModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSelectCouponViewModel.h"
#import "KGUserModelManager.h"
#import "KGCouponModel.h"
@implementation KGSelectCouponViewModel
-(id)init
{
    if (self = [super init])
    {
        _YDCouponModelArr      = [[NSMutableArray alloc]init];
        _KDSelectedCouponDic   = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}
-(void)resetSelectedCoupon:(KGCouponModel  *)model
{
    if (model)
    {
        [_KDSelectedCouponDic setValue:model.couponId forKey:@"couponId"];
        [_KDSelectedCouponDic setValue:model.coupondenom forKey:@"coupondenom"];
    }
    
}
-(YZRequestItem * )KDCouponRequestItem
{
    if (_KDCouponRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@"unused" forKey:@"coupon_type"];
        [paramDic setValue:@"100" forKey:@"coupon_limit"];
        _KDCouponRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR withData:paramDic];
        _KDCouponRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponRequestItem;
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
    
    block(state);
    
}

-(void)putListData:(NSArray *)arr
{
    
    [_YDCouponModelArr removeAllObjects];
    for (NSDictionary * dic in arr)
    {
        KGUnUserCouponModel * modle  = [[KGUnUserCouponModel alloc]init];
        
        [modle putInDataFordic:dic];
        
        [_YDCouponModelArr addObject:modle];
        
    }
    
}
@end
