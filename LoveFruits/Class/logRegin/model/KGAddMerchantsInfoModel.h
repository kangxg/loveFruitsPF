//
//  KGAddMerchantsInfoModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@class YZRequestItem;
@class YZUploadSingleImageItem;
@interface KGAddMerchantsInfoModel : KGBaseModel
@property (nonatomic,retain)YZRequestItem            *   KDAddRequestItem;
@property (nonatomic,retain)YZUploadSingleImageItem  *   KGUploadRequestItem;

-(void)saveUserInfo;
@end
