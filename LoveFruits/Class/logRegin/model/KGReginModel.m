//
//  KGReginModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGReginModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@implementation KGReginModel
@synthesize KDRegRequestItem     =  _KDRegRequestItem;
-(YZRequestItem * )KDRegRequestItem
{
    if (_KDRegRequestItem == nil)
    {
    
            NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
           [paramDic setValue:@"client_credentials" forKey:@"grant_type"];
           [paramDic setValue:KGCLIENTID forKey:@"client_id"];
           [paramDic setValue:KGCLIENTSECRET forKey:@"client_secret"];
            _KDRegRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
            _KDRegRequestItem.YNetworkRequestUrl = KGREGINURL;
            _KDRegRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
            
     
    }
    return _KDRegRequestItem;
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
 
    NSDictionary * dic =    [jsonDic valueForKey:@"data"];
    NSString * token    =    [jsonDic valueForKey:@"token"];
   
    
      if (!dic|| !token.length)
      {
          state = YZPROCESSINGDATANULL;
       
      }
      else
      {
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
