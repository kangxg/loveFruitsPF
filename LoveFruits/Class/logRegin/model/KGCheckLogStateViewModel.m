//
//  KGCheckLogStateViewModel.m
//  LoveFruits
//
//  Created by kangxg on 2017/1/8.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGCheckLogStateViewModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@implementation KGCheckLogStateViewModel
-(id)init
{
    if (self = [super init])
    {
            }
    return self;
}
-(YZRequestItem * )KDUserStateRequestItem
{
    if (_KDUserStateRequestItem == nil)
    {
        KGUserModelManager * manager  = [KGUserModelManager shareInstanced];
        KGUserModel * user            = [manager getUserModel];
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        [paramDic setValue:user.KUserId forKey:@"uid"];
        
        _KDUserStateRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDUserStateRequestItem.YNetworkRequestUrl = KGSTOREINFOSTATUSURL;
        _KDUserStateRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDUserStateRequestItem;
}

-(BOOL)hasLog
{
    KGUserModelManager * manager  = [KGUserModelManager shareInstanced];
    KGUserModel * user            = [manager getUserModel];
    if (user == nil || !user.KUserToken) {
        return false;
    }
    return YES;
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
    NSInteger ustate = [[jsonDic valueForKey:@"status"] integerValue];
    _KDUserAuditState  = ustate;
    state = YZPROCESSINGDATASUCCESS;
    block(state);
}
@end
