//
//  KGCheckLogStateViewModel.h
//  LoveFruits
//
//  Created by kangxg on 2017/1/8.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGEnum.h"
@class YZRequestItem;
@interface KGCheckLogStateViewModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem            *   KDUserStateRequestItem;
@property  (nonatomic,assign)KGUserAuditState            KDUserAuditState;

-(BOOL)hasLog;
@end
