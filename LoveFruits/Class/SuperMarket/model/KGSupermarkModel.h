//
//  KGSupermarkModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@interface KGSupermarkModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem              *  KDSuperRequestItem;
@property (nonatomic,retain)NSMutableArray             *  KDOneClassArr;
@property (nonatomic,retain)NSMutableDictionary        *  KDTwoClassDic;
@property (nonatomic,copy)NSString                     *  KDSelectId;
@property (nonatomic,weak)NSMutableArray                      *  KDSelectArr;
@end
