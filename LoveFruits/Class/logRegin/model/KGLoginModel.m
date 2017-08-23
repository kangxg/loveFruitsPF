//
//  KGLoginModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLoginModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@implementation KGLoginModel
@synthesize KDLogRequestItem     =  _KDLogRequestItem;
@synthesize KDLogStatus          =  _KDLogStatus;
@synthesize KDLogMessage         =  _KDLogMessage;
-(YZRequestItem * )KDLogRequestItem
{
    if (_KDLogRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:@"password" forKey:@"grant_type"];
        [paramDic setValue:KGCLIENTID forKey:@"client_id"];
        [paramDic setValue:KGCLIENTSECRET  forKey:@"client_secret"];
        _KDLogRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDLogRequestItem.YNetworkRequestUrl = KGLOGINNURL;
        _KDLogRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDLogRequestItem;
}
-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    _KDLogStatus        =    [[jsonDic valueForKey:@"status"] integerValue];
    
    if (jsonDic == nil || !_KDLogStatus)
    {
        state = YZPROCESSINGDATAERROR;
        block(state);
        return;
    }
    
    NSDictionary * dic  =    [jsonDic valueForKey:@"data"];
    NSString * token    =    [jsonDic valueForKey:@"token"];
    
    
    if (!dic|| !token.length)
    {
        state = YZPROCESSINGDATANULL;
        
    }
    else
    {
        _KDLogMessage  =  [jsonDic valueForKey:@"message"];
//        if (_KDLogStatus != 2)
//        {
//            KGUserModelManager * manager  = [KGUserModelManager shareInstanced];
//            KGUserModel * user            = [[KGUserModel alloc]init];
//            user.KUserToken               = token;
//            user.KUserId                  = [dic valueForKey:@"uid"];
//            user.KUserMobile              = [dic valueForKey:@"mobi"];
//            user.KUserName                = [dic valueForKey:@"username"];
//            
//            [manager setUserModel:user];
//            
//        }
        KGUserModelManager * manager  = [KGUserModelManager shareInstanced];
        KGUserModel * user            = [[KGUserModel alloc]init];
        user.KUserToken               = token;
        user.KUserId                  = [dic valueForKey:@"uid"];
        user.KUserMobile              = [dic valueForKey:@"mobi"];
        user.KUserName                = [dic valueForKey:@"username"];
        
        [manager setUserModel:user];

        state = YZPROCESSINGDATASUCCESS;
    }
    
    
    
    block(state);
}

@end
