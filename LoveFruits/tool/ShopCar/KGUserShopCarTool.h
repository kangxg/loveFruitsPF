//
//  KGUserShopCarTool.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGGoodsModelInterface.h"
@class KGGoods;
@interface KGUserShopCarTool : NSObject
+(KGUserShopCarTool *)sharedUserShopCar;
-(BOOL)isEmpty;

-(NSInteger )userShopCarProductsNumber;

-(NSString *) getAllProductsPrice;
-(NSString *) getAllSeletedProductsPrice;
-(BOOL)getAllGoodsSelected;
-(NSMutableArray <id<KGGoodsModelInterface>>  *) getShopCarProducts;

-(NSInteger ) getShopCarProductsClassifNumber;

-(void)addSupermarkProductToShopCar:(id<KGGoodsModelInterface>)goods;
-(void)removeSupermarketProduct:(id<KGGoodsModelInterface>)goods;

-(void)removeAllSeletedSupermarketProduct;

-(NSArray *)getAllEnterBuyProduct;
@end
