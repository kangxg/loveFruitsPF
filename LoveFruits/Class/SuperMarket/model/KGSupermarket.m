//
//  KGSupermarket.m
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSupermarket.h"
#import "KGDicModelManager.h"
#import "KGHomeFreshHot.h"


@interface KGSupermarket()

@property (nonatomic,assign)NSInteger                  code;
@property (nonatomic,copy)  NSString               *   msg;
@property (nonatomic,copy)  NSString               *   reqid;

@end

@implementation KGSupermarket

+(void)loadData:(void (^)(id<KGModelInterface> data, NSError * error))completion
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    if (path)
    {
        id data =  [NSData dataWithContentsOfFile:path];
        
        if (data != nil)
        {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            KGDicModelManager * modelTool = [KGDicModelManager shareManager];
            id  da = [modelTool objectWithDictionary:dict withcls:[self class]];
            completion(da,nil);
        }
    }
    
}
+(NSDictionary *)customClassMapping
{
    return @{@"data":NSStringFromClass([KGSupermarketResouce class])};
}

+(NSArray <NSArray <KGGoods *> *>*)searchCategoryMatchProducts:(KGSupermarketResouce *)supermarketResouce
{
    NSMutableArray * arr  = [NSMutableArray new];
    KGProducts * products = supermarketResouce.products;
    for (KGCategorie * cate in  supermarketResouce.categories)
    {
        NSMutableArray * goosArr = [products valueForKey:cate.mid];
        [arr addObject:goosArr];
    }
    return arr;
}


@end


@implementation KGSupermarketResouce

+(NSDictionary *)customClassMapping
{
    return @{@"categories":NSStringFromClass([KGCategorie class]),@"products":NSStringFromClass([KGProducts class])};
}

@end

@implementation KGCategorie



@end


@interface KGProducts()<KGDictModelProtocol>

@end
@implementation KGProducts

+(NSDictionary *)customClassMapping
{
    return @{@"a82":NSStringFromClass([KGGoods class]),
             @"a96":NSStringFromClass([KGGoods class]),
             @"a99":NSStringFromClass([KGGoods class]),
             @"a106":NSStringFromClass([KGGoods class]),
             @"a134":NSStringFromClass([KGGoods class]),
             @"a135":NSStringFromClass([KGGoods class]),
             @"a136":NSStringFromClass([KGGoods class]),
             @"a141":NSStringFromClass([KGGoods class]),
             @"a143":NSStringFromClass([KGGoods class]),
             @"a147":NSStringFromClass([KGGoods class]),
             @"a151":NSStringFromClass([KGGoods class]),
             @"a152":NSStringFromClass([KGGoods class]),
             @"a158":NSStringFromClass([KGGoods class]),
             @"a137":NSStringFromClass([KGGoods class])
             };
}

@end