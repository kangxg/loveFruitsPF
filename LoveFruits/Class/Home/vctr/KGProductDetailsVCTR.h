//
//  KGProductDetailsVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//
/**
 *  Description 商品详情父类
 */
#import "KGHaveNavViewVCTR.h"
#import "KGProductDetailsViewModel.h"
@interface KGProductDetailsVCTR : KGHaveNavViewVCTR
@property (nonatomic,copy)NSString * YMProductId;
@property (nonatomic,retain)KGProductDetailsViewModel  * YMModel;

@end
