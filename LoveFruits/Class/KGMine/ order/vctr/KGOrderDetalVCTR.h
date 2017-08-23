//
//  KGOrderDetalVCTR.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"

@interface KGOrderDetalVCTR : KGHaveNavViewVCTR
@property (nonatomic,copy)NSString   * KVOrderId;
@property (nonatomic,retain)UIView   * KVDownView;
-(void)initData;

-(void)createDownView;
@end

@interface KGWillPayOrderDetalVCTR : KGOrderDetalVCTR

@end

@interface KGWillSendOrderDetalVCTR : KGOrderDetalVCTR

@end

@interface KGWillReciveOrderDetalVCTR : KGOrderDetalVCTR

@end

@interface KGOverOrderDetalVCTR : KGOrderDetalVCTR

@end


@interface KGCancelOrderDetalVCTR : KGOverOrderDetalVCTR

@end

@interface KGInvalidOrderDetalVCTR :KGOverOrderDetalVCTR

@end
