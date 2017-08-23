//
//  KGGoodsModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGGoodsModel.h"

@implementation KGGoodsModel
@synthesize pid = _pid;
@synthesize img = _img;
@synthesize price = _price;
@synthesize name = _name;
@synthesize spec = _spec;
@synthesize userBuyNumber = _userBuyNumber;
@synthesize isSelected    = _isSelected;
-(id)init
{
    if ([super init])
    {
        _userBuyNumber = @(0);
        _isSelected = false;
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
   
    NSDictionary * dic = data;
    _pid  = [dic valueForKey:@"pid"];
    _img  = [dic valueForKey:@"imgUrl"];
    _price = [dic valueForKey:@"price"];
    _name  = [dic valueForKey:@"name"];
    _spec  = [dic valueForKey:@"spec"];
    
    return YES;
}
@end
