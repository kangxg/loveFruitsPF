//
//  KGShopCartViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGShopCartViewModel.h"
#import "KGUserShopCarTool.h"
#import "KGShopCarCellModel.h"
#import "YZRequestItem.h"
#import "KGUserModelManager.h"
@interface KGShopCartViewModel()
@property (nonatomic,retain)KGUserShopCarTool  * MDShopCarTool;
@end;

@implementation KGShopCartViewModel
@synthesize MDShopCarTool    = _MDShopCarTool;
@synthesize KDUserStateRequestItem   = _KDUserStateRequestItem;
-(id)init
{
    if (self = [super init])
    {
        _MDShopCarTool = [KGUserShopCarTool sharedUserShopCar];
    }
    return self;
}
-(NSInteger )getGoosData
{
    return [_MDShopCarTool getShopCarProducts].count;
}
-(BOOL)getAllSelected
{
    return [_MDShopCarTool getAllGoodsSelected];
}
-(id<KGGoodsModelInterface>)shopGoods:(NSInteger )index
{
    
    return [_MDShopCarTool getShopCarProducts][index];
}

-(void)seletedAllGoods:(BOOL)selected
{
    for (id<KGGoodsModelInterface> model in [_MDShopCarTool getShopCarProducts])
    {
        model.isSelected = selected;
    }
}
-(NSString *)getBuyTotalAmount
{
    return [_MDShopCarTool getAllSeletedProductsPrice];
}

-(void)removeAllSelectedGoods
{
    [_MDShopCarTool removeAllSeletedSupermarketProduct];
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
