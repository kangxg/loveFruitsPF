//
//  KGProductDetailsViewModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class  KGProductDetailsModel;
@class  YZRequestItem ;
@interface KGProductDetailsViewModel : KGBaseModel
@property (nonatomic,retain)KGProductDetailsModel    *  KDProductModel;
@property (nonatomic,retain)YZRequestItem            *  KDRequestItem;

@end
