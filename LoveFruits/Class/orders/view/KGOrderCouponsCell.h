//
//  KGOrderCouponsCell.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"

@interface KGOrderCouponsCell : KGBaseTableViewCell
@property (nonatomic,retain)UILabel  * KVCouponValueLabel;

-(void)setUserCoupon:(NSString *)coupondenom;
-(void)setUseCouponcount:(NSInteger )count;
@end
