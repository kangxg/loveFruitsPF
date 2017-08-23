//
//  KGOrderAlertView.h
//  LoveFruits
//
//  Created by kangxg on 2017/1/1.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "NTAlertView.h"

@interface KGOrderAlertView : NTCustomAlertView
@property (nonatomic,copy)NSString *  KVOrderId;
@end

@interface KGDeleteOrderAlertView : KGOrderAlertView

@end

@interface KGReciveOrderAlertView : KGOrderAlertView

@end


@interface KGCannelOrderAlertView : KGOrderAlertView

@end

