//
//  KGSupermarkModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSupermarkModel.h"
#import "YZRequestItem.h"
#import "KGClassificationModel.h"
@implementation KGSupermarkModel
@synthesize KDSuperRequestItem = _KDSuperRequestItem;
-(id)init
{
    if (self = [super init ])
    {
        _KDOneClassArr = [[NSMutableArray alloc]init];
        _KDTwoClassDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(YZRequestItem * )KDSuperRequestItem
{
    if (_KDSuperRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
       
        
        _KDSuperRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDSuperRequestItem.YNetworkRequestUrl = KGSUPRERMARKURL;
        _KDSuperRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDSuperRequestItem;
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
    NSArray * arr = [jsonDic valueForKey:@"data"];
    
    if (!arr.count )
    {
        state = YZPROCESSINGDATANULL;

    }
    else
    {
        [_KDOneClassArr removeAllObjects];
        [_KDTwoClassDic removeAllObjects];
        [self classificationDataProcessing:arr withIndex:0];
         state = YZPROCESSINGDATASUCCESS;
    }
     block(state);
}
-(void)classificationDataProcessing:(NSArray *)arr withIndex:(NSInteger )index
{
    if (index == arr.count)
    {
        return;
    }
    NSDictionary * dic   = arr[index];
    KGClassificationModel * model = [[KGClassificationModel alloc]init];
    if([model putInDataFordic:dic])
    {
        [self depositedModel:model];
    }
    index ++;
    [self classificationDataProcessing:arr withIndex:index];
    
}
/**
 *  Description 存放 数据model
 *
 *  @param model 分类model
 */
-(void)depositedModel:(KGClassificationModel *)model
{
    NSString  * keyid = nil;
    if (!model.isleafnode)
    {
        [_KDOneClassArr addObject:model];
        keyid = model.cid;
    }
    else
    {
        keyid = model.pid;
    }
    NSMutableArray * twoModelArr = [_KDTwoClassDic objectForKey:keyid];
    if (!twoModelArr)
    {
        twoModelArr = [[NSMutableArray alloc]init];
        [_KDTwoClassDic setValue:twoModelArr forKey:keyid];
        [twoModelArr addObject:model];
    }
    else
    {
        [twoModelArr addObject:model];
    }

}

-(void)setKDSelectId:(NSString *)KDSelectId
{
    if (KDSelectId)
    {
        _KDSelectId = KDSelectId;
        _KDSelectArr = [_KDTwoClassDic valueForKey:KDSelectId];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"cid" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
        [_KDSelectArr sortUsingDescriptors:descriptors];
    }
   
}
@end
