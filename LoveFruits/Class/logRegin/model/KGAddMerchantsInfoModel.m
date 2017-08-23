//
//  KGAddMerchantsInfoModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAddMerchantsInfoModel.h"
#import "YZRequestItem.h"
#import "YZUploadSingleImageItem.h"
#import "KGUserModelManager.h"
@implementation KGAddMerchantsInfoModel
@synthesize KDAddRequestItem     =  _KDAddRequestItem;
@synthesize KGUploadRequestItem  =  _KGUploadRequestItem;
-(YZRequestItem * )KDAddRequestItem
{
    if (_KDAddRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
       
        _KDAddRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDAddRequestItem.YNetworkRequestUrl = KGADDMERCHANTSINFO;
        _KDAddRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDAddRequestItem;
}

-(YZUploadSingleImageItem * )KGUploadRequestItem
{
    if (_KGUploadRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        
        _KGUploadRequestItem  = [[YZUploadSingleImageItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR   withData:paramDic];
        _KGUploadRequestItem.YFileName = @"imageFile";
        _KGUploadRequestItem.YNetworkRequestUrl = KGADDMERCHANTSINFO;
        _KGUploadRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KGUploadRequestItem;
}

-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
     YZProcessingDataState  state = YZPROCESSINGDATANONE;
     NSInteger status =    [[jsonDic valueForKey:@"status"] integerValue];
    if (jsonDic == nil  )
    {
        state = YZPROCESSINGDATAERROR;
        block(state);
        return;
    }
    if ( !status)
    {
        block(state);
        return;
    }
    else
    {
        [self saveUserInfo];
        state = YZPROCESSINGDATASUCCESS;
        block(state);
    }
}

-(void)saveUserInfo
{
    KGUserModelManager * manager = [KGUserModelManager shareInstanced];
    KGUserModel * usermodel      = [manager getUserModel];
    NSDictionary   * dic         = self.KDAddRequestItem.YRequestDic;
    usermodel.KAdress            = [dic valueForKey:@"storeAdd"];
    usermodel.KHeadName          = [dic valueForKey:@"mgrName"];
    usermodel.KStoreName         = [dic valueForKey:@"storeName"];
    [manager setUserModel:usermodel];
}
@end
