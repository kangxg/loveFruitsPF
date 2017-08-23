//
//  KGUserShopCarTool.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUserShopCarTool.h"
#import "KGHomeFreshHot.h"
#import "KGShopCarRedDotView.h"
#import "GlobelDefine.h"
#import "NSString+Extension.h"
#import "KGGoodsModelInterface.h"
@interface KGUserShopCarTool()
@property (nonatomic,retain)NSMutableArray <id<KGGoodsModelInterface>> * MSupermarketProducts;
@end

@implementation KGUserShopCarTool
+(KGUserShopCarTool *)sharedUserShopCar
{
    static KGUserShopCarTool * instance = nil;
    if (instance == nil)
    {
        instance = [[self alloc]init];
    }
    
    return instance;
}

-(id)init
{
    if (self = [super init])
    {
        
        
    }
    return self;
}
-(NSMutableArray <id<KGGoodsModelInterface>> *)MSupermarketProducts
{
    if (_MSupermarketProducts == nil)
    {
        _MSupermarketProducts = [[NSMutableArray alloc]init];
    }
    return _MSupermarketProducts;
}
-(BOOL)isEmpty
{
    return self.MSupermarketProducts.count;
}
-(NSInteger )userShopCarProductsNumber
{
    return [KGShopCarRedDotView sharedRedDotView].KGBuyNumber;
}
-(void)addSupermarkProductToShopCar:(id<KGGoodsModelInterface>)goods
{
    if (goods == nil)
    {
        return;
    }
   
    for ( id<KGGoodsModelInterface>  everyGoods in  self.MSupermarketProducts)
    {
     
      
       if (goods.pid.integerValue == everyGoods.pid.integerValue)
        {

            NSInteger buyNum = [everyGoods userBuyNumber].integerValue;
            buyNum ++;
//            everyGoods.isSelected = goods.isSelected;
            [everyGoods setUserBuyNumber:[NSNumber numberWithInteger:buyNum]];
           return;
        }
        
    }
    NSInteger buyNum = [goods userBuyNumber].integerValue;
    buyNum ++;
    [goods setUserBuyNumber:[NSNumber numberWithInteger:buyNum]];
    [self.MSupermarketProducts addObject:goods];
}
-(NSMutableArray <id<KGGoodsModelInterface>> *) getShopCarProducts
{
    return self.MSupermarketProducts;
}

-(NSInteger ) getShopCarProductsClassifNumber
{
    return self.MSupermarketProducts.count;
}


-(void)removeSupermarketProduct:(id<KGGoodsModelInterface>)goods
{
    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
    {
        if ([goods.pid isEqualToString:everyGoods.pid])
        {
            [_MSupermarketProducts removeObject:everyGoods];
            [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarDidRemoveProductNSNotification object:nil];
            
          
            return;
        }
    }
}
-(void)removeAllSeletedSupermarketProduct
{
   
    NSArray * array = [NSArray arrayWithArray: _MSupermarketProducts];
    for (id<KGGoodsModelInterface> everyGoods in array) {
        if (everyGoods.isSelected)
        {
            
            [_MSupermarketProducts removeObject:everyGoods];
            
            
        }
    }
///    int  i = 0;
//    while(bArr.count>i)
//    {
//        NSObject * itemObject =  [bArr objectAtIndex:i];
//        if([itemObject isKindOfClass:[NSString class]])
//        {
//            [bArr removeObject:itemObject]; //释放
//            itemObject = nil;
//        }else{
//            i++;
//        }
//    }
 
//    [_MSupermarketProducts enumerateObjectsUsingBlock:^(id<KGGoodsModelInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.isSelected)
//        {
//            *stop = YES;
//            if (* stop == YES)
//            {
//                  [_MSupermarketProducts removeObject:obj];
//            }
//          
//            
//        }
//    }];
//    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
//    {
//       
//        if (everyGoods.isSelected)
//        {
//            
//            [_MSupermarketProducts removeObject:everyGoods];
//            
//        }
//    }
//    [_MSupermarketProducts removeAllObjects];

}
-(BOOL)getAllGoodsSelected
{
    NSInteger selectedCount = 0;
    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
    {
        if (everyGoods.isSelected)
        {
            selectedCount++;
        }
        
    }
    if (selectedCount == [self getShopCarProductsClassifNumber])
    {
        return YES;
    }
    return false;

}
-(NSString *) getAllProductsPrice
{
    double allPrice = 0;
    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
    {
        allPrice = allPrice +  everyGoods.partner_price.doubleValue * everyGoods.userBuyNumber.doubleValue;
    
    }
    NSString * result = [NSString stringWithFormat:@"%lf",allPrice];
    return  [result cleanDecimalPointZear];
    
}
-(NSString *)getAllSeletedProductsPrice
{
    double allPrice = 0;
    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
    {
        if (everyGoods.isSelected)
        {
             allPrice = allPrice +  everyGoods.price.doubleValue * everyGoods.userBuyNumber.doubleValue;
        }
    
    }
    NSString * result = [NSString stringWithFormat:@"%.2lf",allPrice];
    return result;
//   return  [result cleanDecimalPointZear];

}
-(NSArray *)getAllEnterBuyProduct
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for ( id<KGGoodsModelInterface> everyGoods in  self.MSupermarketProducts)
    {
        if (everyGoods.isSelected)
        {
            [arr addObject:everyGoods];
        }
    }
    return arr;
}

@end
