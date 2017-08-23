//
//  KGShipingAddressViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShipingAddressViewModel.h"
#import "YZRequestItem.h"
@implementation KGShipingAddressViewModel
@synthesize KDRequestItem     =  _KDRequestItem;
@synthesize KDAddressModelArr =  _KDAddressModelArr;
-(id)init
{
    if (self = [super init])
    {
        _KDAddressModelArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(YZRequestItem * )KDRequestItem
{
    if (_KDRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:KGGRANTTYPE forKey:@"grant_type"];
        [paramDic setValue:KGCLIENTID forKey:@"client_id"];
        [paramDic setValue:KGCLIENTSECRET  forKey:@"client_secret"];
        _KDRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDRequestItem.YNetworkRequestUrl = KGLOGINNURL;
        _KDRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDRequestItem;
}


@end
