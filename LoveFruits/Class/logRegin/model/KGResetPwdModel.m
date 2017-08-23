//
//  KGResetPwdModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGResetPwdModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@implementation KGResetPwdModel
@synthesize KDRequestItem     =  _KDRequestItem;

-(YZRequestItem * )KDRequestItem
{
    if (_KDRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:@"client_credentials" forKey:@"grant_type"];
        [paramDic setValue:KGCLIENTID forKey:@"client_id"];
        [paramDic setValue:KGCLIENTSECRET forKey:@"client_secret"];
        _KDRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDRequestItem.YNetworkRequestUrl =  KGRESETPWD;
        _KDRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDRequestItem;
}

-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    
    if (jsonDic == nil)
    {
        state = YZPROCESSINGDATAERROR;
        block(state);
        return;
    }
    
  
    bool  status   =    [jsonDic valueForKey:@"status"];
    
    
    if (!status)
    {
        state = YZPROCESSINGDATANULL;
        
    }
    else
    {
        state = YZPROCESSINGDATASUCCESS;
    }
    
    
    
    block(state);
}

@end
