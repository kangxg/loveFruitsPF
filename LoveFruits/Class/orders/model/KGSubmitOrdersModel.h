//
//  KGSubmitOrdersModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGGoodsModelInterface.h"
#import "KGUserModel.h"
@class YZRequestItem;
@interface KGSubmitOrdersModel : KGBaseModel
@property (nonatomic,assign)BOOL   KDPaySelected;
@property (nonatomic,copy)NSString  * KDAdress;
@property (nonatomic,copy)NSString  * KDAdressId;
@property (nonatomic,copy)NSString  * KDName;
@property (nonatomic,copy)NSString  * KDPhone;

@property (nonatomic,assign)NSInteger  KDHaveCouponCount;

@property (nonatomic,copy)NSString  * KDUseCouponId;
@property (nonatomic,copy)NSString  * KDUseCoupondenom;

@property (nonatomic,copy,readonly)NSString  * KDPayAmount;
@property (nonatomic,retain)YZRequestItem            *   KDOrdersRequestItem;
@property (nonatomic,retain)YZRequestItem            *   KDAdressRequestItem;

@property (nonatomic,retain)YZRequestItem            *   KDCouponUnuseRequestItem;


-(NSArray *)getOrdersProduct;

-(NSString *)getProductsMoneySum;
-(id<KGGoodsModelInterface>)shopGoods:(NSInteger )index;
-(NSArray *)getWaresArr;
-(KGUserModel *)getUserModel;

-(void)resetUseCoupon;

-(void)setUseCoupon:(NSDictionary *)dic;
@end
