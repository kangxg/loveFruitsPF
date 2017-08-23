//
//  KGLoginModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@interface KGLoginModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem       *   KDLogRequestItem;
@property (nonatomic,assign)NSInteger               KDLogStatus;
@property (nonatomic,copy)  NSString            *   KDLogMessage;
@end
