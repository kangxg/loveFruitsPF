//
//  KGOrderModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderModel.h"

@implementation KGOrderModel
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic =data;
    _orderId = [dic valueForKey:@"order_id"];
    _orderId = [dic valueForKey:@"create_time"];
    _orderId = [dic valueForKey:@"order_amount"];
    _orderId = [dic valueForKey:@"order_status"];
    _orderId = [dic valueForKey:@"order_point"];
//    _orderId = [dic valueForKey:@"order_wares"];
    return true;
}
@end
