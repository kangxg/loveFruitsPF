//
//  KGPaymentMethodVCTR.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"

@interface KGPaymentMethodVCTR : KGHaveNavViewVCTR
/**
 Description  订单号
 */
@property (nonatomic,copy)NSString       *   KDOrderId;

/**
 Description  订单金额
 */
@property (nonatomic,copy)NSString       *   KDOrderAmount;
@end
