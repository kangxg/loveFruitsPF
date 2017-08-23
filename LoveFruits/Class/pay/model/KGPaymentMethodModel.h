//
//  KGPaymentMethodModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "BCPayConstant.h"
@class KGPayMethodTableCell;
@class KGChannelModel;
#import "BCPayConstant.h"
@interface KGPaymentMethodModel : KGBaseModel
@property (nonatomic,copy)NSString             *     KDChannelName;
@property (nonatomic,assign)PayChannel               KDPayChannel;
@property (nonatomic,weak)KGPayMethodTableCell *     KDSelectView;
@property (nonatomic,retain)NSMutableArray <KGChannelModel *> *   KDChannelList;
/**
 Description  订单号
 */
@property (nonatomic,copy)NSString       *   KDOrderId;

/**
 Description  订单金额
 */
@property (nonatomic,copy)NSString       *   KDOrderAmount;
@end
