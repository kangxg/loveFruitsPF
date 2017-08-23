//
//  KGSupermarket.h
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"

@class KGGoods;
@interface KGProducts:NSObject
@property (nonatomic,retain)NSArray  * a82;
@property (nonatomic,retain)NSArray  * a96;

@property (nonatomic,retain)NSArray  * a99;

@property (nonatomic,retain)NSArray  * a106;

@property (nonatomic,retain)NSArray  * a134;

@property (nonatomic,retain)NSArray  * a135;

@property (nonatomic,retain)NSArray  * a136;

@property (nonatomic,retain)NSArray  * a137;

@property (nonatomic,retain)NSArray  * a141;

@property (nonatomic,retain)NSArray  * a142;

@property (nonatomic,retain)NSArray  * a143;

@property (nonatomic,retain)NSArray  * a147;

@property (nonatomic,retain)NSArray  * a151;

@property (nonatomic,retain)NSArray  * a152;

@property (nonatomic,retain)NSArray  * a158;

@end

@interface KGCategorie : NSObject
@property (nonatomic,copy)  NSString    *  mid;
@property (nonatomic,copy)  NSString    *  name;
@property (nonatomic,copy)  NSString    *  sort;
@end


@interface KGSupermarketResouce : KGBaseModel
@property (nonatomic,retain)NSArray<KGCategorie *>     *  categories;
@property (nonatomic,retain)KGProducts                 *  products;
@property (nonatomic,copy)  NSString                   *  trackid;
@end




@interface KGSupermarket : KGBaseModel

@property (nonatomic,retain)KGSupermarketResouce   *   data;
+(NSArray  <NSArray <KGGoods *> *>*)searchCategoryMatchProducts:(KGSupermarketResouce *) supermarketResouce;
@end
