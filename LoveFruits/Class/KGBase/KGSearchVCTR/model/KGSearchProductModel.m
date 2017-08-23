//
//  KGSearchProductModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchProductModel.h"
#import "KGUserModelManager.h"
#import "YZRequestItem.h"
#import "KGHomeCommodityCellModel.h"
@interface KGSearchProductModel()

@property (nonatomic,copy)NSString      * MDSearchCurPage;
@property (nonatomic,copy)NSString      * MDSearchPageSize;
//@property (nonatomic,retain)NSMutableArray * MDHistoryArr;
@end

@implementation KGSearchProductModel
//@synthesize MDHistoryArr = _MDHistoryArr;
-(id)init
{
    if (self = [super init ])
    {
        _KDGoodsModelArr = [[NSMutableArray alloc]init];
        [self resetSearch];
//        [self createHistorySearchArr];
    }
    return self;
}
-(void)resetSearch
{
    _KDHasNext = true;
    _MDSearchCurPage = @"1";
    _MDSearchPageSize = @"10";
}
//-(void)createHistorySearchArr
//{
//    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath = [path stringByAppendingPathComponent:@"sale1.data"];//取出名字为sale1.data的归档文件
//    _MDHistoryArr  = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];//self.saleArray是你声明的一个数组用来接收反归档的文件
//    if (_MDHistoryArr == nil)
//    {
//        _MDHistoryArr = [[NSMutableArray alloc]init];
//    }
//    NSLog(@"sale:%@",_MDHistoryArr);
//
//}
-(NSArray *)getHistorySearchArr
{
    KGUserModel * user =  [[KGUserModelManager shareInstanced] getUserModel];
    return user.KUserSearchHistory;
    
}

-(void)saveHistorySearchValue:(NSString *)value
{
    if (!value.length)
    {
        return;
    }
   [[KGUserModelManager shareInstanced]saveSearchHistory:value];
    
//    [_MDHistoryArr addObject:value];
//    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath = [path stringByAppendingPathComponent:@"sale1.data"];//sale1.data是你归档的数组的名字
//    [NSKeyedArchiver archiveRootObject:_MDHistoryArr toFile:filePath];//items.n12是你需要保存的数组的数据

}

-(void)cleanHistorySearch
{
      KGUserModel * user =  [[KGUserModelManager shareInstanced] getUserModel];
      [user.KUserSearchHistory removeAllObjects];
    [[KGUserModelManager shareInstanced] setUserModel:user];
    
//    [_MDHistoryArr removeAllObjects];
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath = [path stringByAppendingPathComponent:@"sale1.data"];//sale1.data是你归档的数组的名字
//    [NSKeyedArchiver archiveRootObject:_MDHistoryArr toFile:filePath];//items.n12是你需要保存的
}

-(YZRequestItem * )KDSearchRequestItem
{
    if (_KDSearchRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
      
        [paramDic setValue:_MDSearchPageSize forKey:@"pageSize"];
        _KDSearchRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDSearchRequestItem.YNetworkRequestUrl = KGSEARCHURL;
        _KDSearchRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
     [_KDSearchRequestItem.YRequestDic  setValue:_MDSearchCurPage forKey:@"curPage"];
    return _KDSearchRequestItem;
}

-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    YZProcessingDataState  state = YZPROCESSINGDATANONE;
    if (jsonDic == nil )
    {
        state = YZPROCESSINGDATAERROR;
        block(state,type);
        return;
    }
    NSDictionary * dic  =    [jsonDic valueForKey:@"data"];
    if (!dic)
    {
        state = YZPROCESSINGDATANULL;
        block(state,type);
        return;
    }
    _MDSearchCurPage     = [dic valueForKey:@"curPage"];
    NSInteger    totalPage = [[dic valueForKey:@"totalPage"]integerValue];
    if (_MDSearchCurPage.integerValue >=totalPage)
    {
        _KDHasNext = false;
    }
    else
    {
        _KDHasNext = YES;
    }
    NSArray * dataArr = [dic valueForKey:@"list"];
    if (dataArr.count)
    {
        
        [self dataProcessing:dataArr];
        state = YZPROCESSINGDATASUCCESS;
    }
    else
    {
        state = YZPROCESSINGDATANULL;
    }

    
//    switch (type) {
//
//    case YZNETWORKVERIFICATIONFIR:
//        {
//                   }
//        break;
//
//    default:
//        break;
//    }
    block(state,type);

}

-(void)dataProcessing:(NSArray *)arr
{
    if ([_MDSearchCurPage isEqualToString:@"1"])
    {
        [_KDGoodsModelArr removeAllObjects];
        
    }
    for ( NSDictionary * dic in arr )
    {
        KGHomeCommodityCellModel * model = [[KGHomeCommodityCellModel alloc]init];
        
        [model putInDataFordic:dic];
        [_KDGoodsModelArr addObject:model];
    }
    
}

@end
