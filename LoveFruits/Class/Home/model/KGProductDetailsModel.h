//
//  KGProductDetailsModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGGoodsModelInterface.h"
@interface KGProductDetailsModel : KGBaseModel<KGGoodsModelInterface>

@property (nonatomic,copy)NSString      *  pid;
@property (nonatomic,copy)NSString      *  name;
@property (nonatomic,copy)NSString      *  imgUrl;
@property (nonatomic,copy)NSString      *  price;
@property (nonatomic,copy)NSString      *  spec;
@property (nonatomic,copy)NSString      *  totalSale;
@property (nonatomic,assign)BOOL           hot;
@property (nonatomic,assign)BOOL           onsale;
@property (nonatomic,assign)BOOL           newProduct;
@property (nonatomic,assign)NSInteger      type;
@property (nonatomic,copy)NSString      *  description;
@end
