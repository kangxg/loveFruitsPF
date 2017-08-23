//
//  KGMyOrdersViewModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGOrderModel.h"
@class YZRequestItem;

@interface KGMyOrdersViewModel : KGBaseModel

/**
 Description  全部订单
 */
@property (nonatomic,retain)YZRequestItem            *  KDGetAllOrdersItem;
/**
 Description  等待支付
 */
@property (nonatomic,retain)YZRequestItem            *  KDWillPayOrdersItem;
/**
 Description  待发货
 */
@property (nonatomic,retain)YZRequestItem            *  KDWillSendOrdersItem;
/**
 Description  待收货
 */
@property (nonatomic,retain)YZRequestItem            *  KDWillReciveOrdersItem;
/**
 Description  已完成
 */
@property (nonatomic,retain)YZRequestItem            *  KDOverOrdersItem;


/**
 Description  删除订单
 */
@property (nonatomic,retain)YZRequestItem            *  KDDeleteOrdersItem;


/**
 Description  确认收货订单
 */
@property (nonatomic,retain)YZRequestItem            *  KDEnterOrdersItem;


/**
 Description  取消订单
 */
@property (nonatomic,retain)YZRequestItem            *  KDCannelOrdersItem;


@property (nonatomic,retain)NSMutableArray<KGOrderModel * >     *  KDAllOrdersArr;

@property (nonatomic,retain)NSMutableArray<KGOrderModel * >     *  KDWillPayArr;
@property (nonatomic,retain)NSMutableArray<KGOrderModel * >     *  KDWillSendArr;
@property (nonatomic,retain)NSMutableArray<KGOrderModel * >     *  KDWillReciveArr;
@property (nonatomic,retain)NSMutableArray<KGOrderModel * >     *  KDOverArr;
@end
