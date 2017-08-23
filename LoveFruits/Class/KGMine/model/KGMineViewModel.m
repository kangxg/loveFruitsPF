//
//  KGMineViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/19.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMineViewModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@implementation KGMineViewModel
@synthesize name = _name;
@synthesize imageName = _imageName;

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
        _KDCouponUnuseRequestItem  = [[YZRequestItem alloc]initRequestModel:    YZNETWORKVERIFICATIONTHI  withData:paramDic];
        _KDCouponUnuseRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponUnuseRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponUnuseRequestItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    if(type == YZNETWORKVERIFICATIONTHI)
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
            _KDHaveCouponCount = arr.count;
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            _KDHaveCouponCount = 0;
            state = YZPROCESSINGDATANULL;
        }
        
        block(state,type);
    }

}
-(NSString *)UserName
{
    return [[KGUserModelManager  shareInstanced] getUserModel].KUserName;
}
@end
