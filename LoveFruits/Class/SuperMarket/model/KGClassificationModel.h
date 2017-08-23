//
//  KGClassificationModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//
/**
 *  Description 一级，二级分类 model

 */
#import "KGBaseModel.h"

@interface KGClassificationModel : KGBaseModel
@property (nonatomic,copy)NSString *  cid;
@property (nonatomic,copy)NSString *  name;
@property (nonatomic,assign)BOOL      isleafnode;
@property (nonatomic,copy)NSString * pid;
@property (nonatomic,assign)NSInteger sort;
@end
