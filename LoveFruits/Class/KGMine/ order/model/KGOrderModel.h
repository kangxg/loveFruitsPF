//
//  KGOrderModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
@interface KGOrderWaresModel : KGBaseModel
@property (nonatomic,copy)NSString  * wareCount;
@property (nonatomic,copy)NSString  * wareId;
@property (nonatomic,copy)NSString  * wareImg;
@property (nonatomic,copy)NSString  * wareName;
@property (nonatomic,copy)NSString  * warePrice;
@property (nonatomic,copy)NSString  * wareSpec;

@end

@interface KGOrderModel : KGBaseModel
//订单号
@property (nonatomic,copy)NSString  * orderId;
//创建时间
@property (nonatomic,copy)NSString  * createTime;
//订单金额
@property (nonatomic,copy)NSString  * orderAmount;
//订单状态
@property (nonatomic,copy)NSString  * orderStatus;
//订单商品list，参考公共数据商品json
@property (nonatomic,copy)NSArray  * orderAares;
//订单积分
@property (nonatomic,copy)NSString  * orderPoint;

@property (nonatomic,retain)NSMutableArray <KGOrderWaresModel * > * OrderWaresArr;
@end
