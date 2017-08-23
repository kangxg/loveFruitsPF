//
//  KDAddAddressViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KDAddAddressViewModel.h"
#import "YZRequestItem.h"
@implementation KDAddAddressViewModel
@synthesize KDRequestItem     =  _KDRequestItem;
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
