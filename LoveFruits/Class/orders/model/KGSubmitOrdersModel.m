//
//  KGSubmitOrdersModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSubmitOrdersModel.h"
#import "KGUserShopCarTool.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@interface KGSubmitOrdersModel()
@property (nonatomic,retain)KGUserShopCarTool  * MDShopCarTool;
@end;
@implementation KGSubmitOrdersModel
@synthesize MDShopCarTool            = _MDShopCarTool;
@synthesize KDOrdersRequestItem      = _KDOrdersRequestItem;
-(id)init
{
    if (self = [super init])
    {
        _MDShopCarTool = [KGUserShopCarTool sharedUserShopCar];
    }
    return self;
}

-(YZRequestItem * )KDOrdersRequestItem
{
    if (_KDOrdersRequestItem == nil)
    {
        KGUserModelManager * manager   = [KGUserModelManager shareInstanced];
        KGUserModel * user             = [manager getUserModel];
        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
        [paramDic setValue:user.KUserId forKey:@"uid"];
       
      
        _KDOrdersRequestItem           = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONFIR  withData:paramDic];
        _KDOrdersRequestItem.YNetworkRequestUrl = KGORERCREATEURL;
        _KDOrdersRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDOrdersRequestItem;
}

-(YZRequestItem *)KDAdressRequestItem
{
    if (_KDAdressRequestItem == nil)
    {
        KGUserModelManager * manager   = [KGUserModelManager shareInstanced];
        KGUserModel * user             = [manager getUserModel];
        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
        [paramDic setValue:user.KUserId forKey:@"uid"];
        _KDAdressRequestItem           = [[YZRequestItem alloc]initRequestModel:YZNETWORKVERIFICATIONSEC  withData:paramDic];
        _KDAdressRequestItem.YNetworkRequestUrl = KGGETADDRESSURL;
        _KDAdressRequestItem.YRequestOption = YZRequestOptionMake(true, NO, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDAdressRequestItem;

}

-(YZRequestItem * )KDCouponUnuseRequestItem
{
    if (_KDCouponUnuseRequestItem == nil)
    {
        
        NSMutableDictionary * paramDic=[NSMutableDictionary dictionary];
        NSString * uid = [[KGUserModelManager  shareInstanced] getUserModel].KUserId;
        if (uid.length)
        {
            [paramDic setValue:uid forKey:@"uid"];
        }
        
        [paramDic setValue:@"unused" forKey:@"coupon_type"];
        [paramDic setValue:@"100" forKey:@"coupon_limit"];
        _KDCouponUnuseRequestItem  = [[YZRequestItem alloc]initRequestModel:    YZNETWORKVERIFICATIONTHI  withData:paramDic];
        _KDCouponUnuseRequestItem.YNetworkRequestUrl = KGHOMECOUPONURL;
        _KDCouponUnuseRequestItem.YRequestOption = YZRequestOptionMake(true, true, YZNETOPERATIONTYPEREQUEST);
        
        
    }
    return _KDCouponUnuseRequestItem;
}
-(void)resetUseCoupon
{
    _KDUseCouponId = @"";
    _KDUseCoupondenom = @"0";
}

-(void)setUseCoupon:(NSDictionary *)dic
{
    if (dic)
    {
        _KDUseCouponId    = [dic valueForKey:@"couponId"];
        _KDUseCoupondenom = [dic valueForKey:@"coupondenom"];

    }
}
-(KGUserModel *)getUserModel
{
    KGUserModelManager * manager = [KGUserModelManager shareInstanced];
    return [manager getUserModel];
}
-(NSArray *)getOrdersProduct
{
   
    return [_MDShopCarTool getAllEnterBuyProduct];
}
-(NSString *)getProductsMoneySum
{
    float coupondenom  = _KDUseCoupondenom.floatValue;
    float seletSum =  [_MDShopCarTool getAllSeletedProductsPrice].floatValue;
    if (coupondenom>0)
    {
        
        coupondenom = seletSum- coupondenom;
        if (coupondenom<=0) {
            coupondenom = seletSum;
        }
    }
    else
    {
        coupondenom  = seletSum;
    }
   
    return [NSString stringWithFormat:@"%.2lf",coupondenom];
}
-(id<KGGoodsModelInterface>)shopGoods:(NSInteger )index
{
    
    return [_MDShopCarTool getShopCarProducts][index];
}


-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    if (type == YZNETWORKVERIFICATIONSEC)
    {
         YZProcessingDataState  state = YZPROCESSINGDATANONE;
         NSInteger status =    [[jsonDic valueForKey:@"status"] integerValue];
        if (jsonDic == nil  )
        {
            state = YZPROCESSINGDATAERROR;
            block(state,type);
            return;
        }
        if ( !status)
        {
            state = YZPROCESSINGDATAFAILT;
            block(state,type);
            return;
        }
        else
        {
            NSArray * arr = [jsonDic valueForKey:@"data"];
            if (arr.count)
            {
               
                
                NSDictionary   * dic = [self getAdressDic:arr];
                if (dic == nil)
                {
                    state = YZPROCESSINGDATAFAILT;
                   
                }
                else
                {
                    state = YZPROCESSINGDATASUCCESS;
                    NSMutableDictionary * orderDic = self.KDOrdersRequestItem.YRequestDic;
                    _KDAdressId =  [dic valueForKey:@"addr_id"];
                    _KDName   =  [dic valueForKey:@"addr_consignee"];
                    _KDPhone  =  [dic valueForKey:@"addr_phone"];
                    _KDAdress =  [dic valueForKey:@"addr_detail"];
                    [orderDic setValue:_KDAdressId forKey:@"addr_id"];

                }
                
            }
            else
            {
                state = YZPROCESSINGDATAERROR;
            }
            
             block(state,type);
        }

    }
    else if(type == YZNETWORKVERIFICATIONTHI)
    {
        YZProcessingDataState  state = YZPROCESSINGDATANONE;
        if (jsonDic == nil )
        {
            state = YZPROCESSINGDATAERROR;
            block(state,type);
            return;
        }
        
        NSArray * arr  =    [jsonDic valueForKey:@"data"];
        if (arr.count)
        {
            _KDHaveCouponCount = arr.count;
            state = YZPROCESSINGDATASUCCESS;
        }
        else
        {
            _KDHaveCouponCount = 0;
            state = YZPROCESSINGDATANULL;
        }
        
         block(state,type);
    }
    else
    {
        YZProcessingDataState  state = YZPROCESSINGDATANONE;
        if (jsonDic == nil )
        {
            state = YZPROCESSINGDATAERROR;
            block(state,type);
            return;
        }
      NSDictionary * dic =  [jsonDic valueForKey:@"data"];
      NSInteger order_status =[[dic valueForKey:@"order_status"]integerValue];
      block(state,order_status);
        
    }
}

-(NSDictionary *)getAdressDic:(NSArray *)arr
{
    NSDictionary * resultDic = nil;
    for (NSDictionary  * dic in arr)
    {
        if ([[dic valueForKey:@"addr_default"] boolValue])
        {
            resultDic = dic;
            break;
        }
    }
   return  resultDic;
}
-(NSArray *)getWaresArr
{
    NSMutableArray * rarr = [[NSMutableArray alloc]init];
    for (id<KGGoodsModelInterface> everyGoods in [_MDShopCarTool getAllEnterBuyProduct])
    {
        NSDictionary * dic = @{@"ware_id":everyGoods.pid,@"ware_count":everyGoods.userBuyNumber};
        [rarr addObject:dic];
    }
    return rarr;
}
@end
