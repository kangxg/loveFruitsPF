//
//  KGHomeCommodityCellModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCommodityCellModel.h"

@implementation KGHomeCommodityCellModel
@synthesize pid         = _pid;
@synthesize name        = _name;
@synthesize img         = _img;
@synthesize price       = _price;
@synthesize spec        = _spec;
@synthesize KDSellCount  = _KDSellCount;
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    
    NSDictionary * dic = data;
    _pid    = [dic valueForKey:@"pid"];
    _name   = [dic valueForKey:@"name"];
    _price  = [dic valueForKey:@"price"];
    _img    = [dic valueForKey:@"imgUrl"];
    _spec   = [dic valueForKey:@"spec"];
    _KDSellCount = [dic valueForKey:@"totalSale"];
    
    return YES;
}
@end
