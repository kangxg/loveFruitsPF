//
//  KGProductsModel.m
//  LoveFruits
//
//  Created by kangxg on 16/10/1.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductsModel.h"
#import "YZRequestItem.h"
#import "KGGoodsModel.h"
@interface KGProductsModel()
@property (nonatomic,assign)NSInteger     MDCurPage;
@property (nonatomic,copy)NSString      * MDPageSize;

@end

@implementation KGProductsModel
@synthesize KDRequestItem   = _KDRequestItem;
@synthesize KDGoodsModelArr = _KDGoodsModelArr;
-(id)init
{
    if (self = [super init ])
    {
       
        _KDGoodsModelArr = [[NSMutableArray alloc]init];
        [self resetModel];
//        _KDOneClassArr = [[NSMutableArray alloc]init];
//        _KDTwoClassDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)resetModel
{
    _KDHasNext = true;
    _MDCurPage = 1;
    _MDPageSize = @"10";
//    if (_KDGoodsModelArr.count)
//    {
//        [_KDGoodsModelArr removeAllObjects];
//    }
}
-(YZRequestItem * )KDRequestItem
{
    if (_KDRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[[NSMutableDictionary alloc]init];
       
        [paramDic setValue:_MDPageSize forKey:@"pageSize"];
        _KDRequestItem  = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDRequestItem.YNetworkRequestUrl = KGPRODUCTSURL;
        _KDRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    [_KDRequestItem.YRequestDic  setValue:@(_MDCurPage) forKey:@"curPage"];
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
    _MDCurPage     = [[dic valueForKey:@"curPage"] integerValue];
    NSInteger    totalPage = [[dic valueForKey:@"totalPage"]integerValue];
    if (_MDCurPage < totalPage)
    {
        if (_MDCurPage == 1)
        {
            [_KDGoodsModelArr removeAllObjects];
            
        }
        _MDCurPage ++;
        _KDHasNext = YES;
    }
    else
    {
        _KDHasNext = false;
    }
    NSArray * dataArr = [dic valueForKey:@"list"];
   
//    [self dataProcessing:dataArr];
    if (dataArr.count)
    {
       
        [self dataProcessing:dataArr];
         state = YZPROCESSINGDATASUCCESS;
    }
    else
    {
        state = YZPROCESSINGDATANULL;
    }
    
    block(state);
}

-(void)dataProcessing:(NSArray *)arr
{
    if (_MDCurPage == 1)
    {
        [_KDGoodsModelArr removeAllObjects];
        
    }
    for ( NSDictionary * dic in arr )
    {
         KGGoodsModel * model = [[KGGoodsModel alloc]init];
        
        [model putInDataFordic:dic];
        [_KDGoodsModelArr addObject:model];
    }
    
 
//    for (int i = 0; i<15; i++)
//    {
//     NSDictionary *   dic = @{@"pid":@(i),
//                @"name":@"儿童酱油",
//                @"image":@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=9&spn=0&di=40074234230&pi=0&rn=1&tn=baiduimagedetail&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=868248776%2C2327923617&os=3386972311%2C3649847831&simid=0%2C0&adpicid=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=11&oriquery=&objurl=http%3A%2F%2Fscimg.jb51.net%2Fallimg%2F160826%2F103-160R60Z21SF.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Ffv_z%26e3B3kc8_z%26e3BgjpAzdH3FPtvp76jAzdH3FG6wtgAzdH3F8988nc_z%26e3Bip4&gsm=0",@"price":@"18",
//                @"spec":@"瓶"};
//        KGGoodsModel * model = [[KGGoodsModel alloc]init];
//        [model putInDataFordic:dic];
//        [_KDGoodsModelArr addObject:model];
//    }
}
@end
