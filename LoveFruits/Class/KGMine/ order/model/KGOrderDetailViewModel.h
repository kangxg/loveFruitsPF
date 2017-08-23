//
//  KGOrderDetailViewModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGOrderModel.h"
@class YZRequestItem;
@interface KGOrderDetailModel : KGBaseModel
/**
 Description  收货人
 */
@property (nonatomic,copy)NSString       *   KDOrderUserName;

/**
 Description  电话
 */
@property (nonatomic,copy)NSString       *   KDPhone;

/**
 Description  收货地址
 */
@property (nonatomic,copy)NSString       *   KDOrderAdress;

/**
 Description  订单号
 */
@property (nonatomic,copy)NSString       *   KDOrderId;
/**
 Description  创建时间
 */
@property (nonatomic,copy)NSString       *   KDCreateTime;
/**
 Description  订单金额
 */
@property (nonatomic,copy)NSString       *   KDOrderAmount;
/**
 Description  订单状态
 */
@property (nonatomic,copy)NSString       *   KDOrderStatus;
/**
 Description  优惠金额
 */
@property (nonatomic,copy)NSString       *   KDOrderCoupon;
/**
 Description  运费金额
 */
@property (nonatomic,copy)NSString       *   KDOrderFreigh;

/**
 Description 订单积分
 */
@property (nonatomic,copy)NSString       *   KDOrderPoint;

/**
 Description 订单商品
 */

@property (nonatomic,retain)NSMutableArray <KGOrderWaresModel * > * KDOrderWaresArr;

@property (nonatomic,copy)NSString   * KDTypeMessage;
@end

@interface KGOrderDetailViewModel : KGBaseModel
@property (nonatomic,copy)NSString   * KDOrderId;

@property (nonatomic,copy)NSString   * KDTypeMessage;
/**
 Description  全部订单
 */
@property (nonatomic,retain)YZRequestItem            *  KDOrdersItem;

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

/**
 Description  详情信息
 */
@property (nonatomic,retain)KGOrderDetailModel       *  KDDetailModel;

@end
