//
//  KGSearchProductModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGBaseModel.h"
@class YZRequestItem;
@class KGHomeCommodityCellModel;
@interface KGSearchProductModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem            *  KDSearchRequestItem;
@property (nonatomic,assign,readonly)BOOL               KDHasNext;
@property (nonatomic,retain)NSMutableArray<KGHomeCommodityCellModel *>  * KDGoodsModelArr;
-(NSArray *)getHistorySearchArr;
-(void)saveHistorySearchValue:(NSString *)value;
-(void)cleanHistorySearch;
@end
