//
//  KGProductDetailsViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsViewModel.h"
#import "YZRequestItem.h"
#import "KGProductDetailsModel.h"
@implementation KGProductDetailsViewModel
@synthesize KDProductModel = _KDProductModel;
@synthesize KDRequestItem  = _KDRequestItem;
-(YZRequestItem * )KDRequestItem
{
    if (_KDRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
              
        _KDRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDRequestItem.YNetworkRequestUrl = KGPRODUCTDETAILSURL ;
        _KDRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDRequestItem;
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
    
    NSDictionary * dic  =    [jsonDic valueForKey:@"data"];
    if (!dic)
    {
        state = YZPROCESSINGDATANULL;
        block(state);
        return;
    }
    _KDProductModel = [[KGProductDetailsModel alloc]init];
    if ( [_KDProductModel putInDataFordic:dic])
    {
        state = YZPROCESSINGDATASUCCESS;

    }
    else
    {
        state = YZPROCESSINGDATAERROR;
    }
     block(state);


}
@end
