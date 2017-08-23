//
//  KGShopCartViewModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGGoodsModelInterface.h"
#import "KGEnum.h"
@class YZRequestItem;
@interface KGShopCartViewModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem            *   KDUserStateRequestItem;
@property  (nonatomic,assign)KGShopCarEditType           KDEditType;
@property  (nonatomic,assign)BOOL                        KDIsFuture ;
@property  (nonatomic,assign)KGUserAuditState            KDUserAuditState;
-(NSInteger )getGoosData;
-(id<KGGoodsModelInterface>)shopGoods:(NSInteger )index;

-(void)seletedAllGoods:(BOOL)selected;

-(NSString *)getBuyTotalAmount;

-(BOOL)getAllSelected;

-(void)removeAllSelectedGoods;


@end
