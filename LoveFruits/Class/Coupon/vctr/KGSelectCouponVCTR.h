//
//  KGSelectCouponVCTR.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"
#import "DefineBlock.h"
@interface KGSelectCouponVCTR : KGHaveNavViewVCTR
@property (nonatomic,copy)KGSelectCouponBlock   KVSelectBlock;
-(id)init:(KGSelectCouponBlock)block;
@end
