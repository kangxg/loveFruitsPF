//
//  KGOrderModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderModel.h"
@implementation KGOrderWaresModel

-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic =data;
    _wareId = [dic valueForKey:@"order_id"];
    _wareName  = [dic valueForKey:@"ware_name"];;
    _wareImg   = [dic valueForKey:@"ware_img"];
    _wareCount = [dic valueForKey:@"ware_count"];
    _wareSpec   = [dic valueForKey:@"ware_spec"];
    _warePrice  = [dic valueForKey:@"ware_price"];
    
    return YES;
}
@end

@implementation KGOrderModel
-(id)init
{
    if (self = [super init])
    {
        _OrderWaresArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    NSDictionary * dic =data;
    _orderId      = [dic valueForKey:@"order_id"];
    _createTime   = [dic valueForKey:@"create_time"];
    _orderAmount  = [dic valueForKey:@"order_amount"];
    _orderStatus  = [dic valueForKey:@"order_status"];
    _orderPoint   = [dic valueForKey:@"order_point"];
    NSArray * arr = [dic valueForKey:@"order_wares"];
    for (NSDictionary * wareDic in arr)
    {
        KGOrderWaresModel * model = [[KGOrderWaresModel alloc]init];
        [model putInDataFordic:wareDic];
        [_OrderWaresArr addObject:model];
    }

    return true;
}
@end
