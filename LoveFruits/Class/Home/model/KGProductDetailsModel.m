//
//  KGProductDetailsModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsModel.h"

@implementation KGProductDetailsModel

@synthesize pid       = _pid;
@synthesize name      = _name;
@synthesize imgUrl    = _imgUrl;
@synthesize price     = _price;
@synthesize spec      = _spec;
@synthesize totalSale = _totalSale;
@synthesize hot       = _hot;
@synthesize onsale    = _onsale;
@synthesize newProduct  = _newProduct;
@synthesize description = _description;
@synthesize userBuyNumber = _userBuyNumber;
@synthesize isSelected    = _isSelected;
@synthesize type          = _type;
@synthesize img           = _img;
-(id)init
{
    if (self = [super init])
    {
        _userBuyNumber = @(0);
        _isSelected = false;
    }
    return self;
}
-(BOOL)putInDataFordic:(id)data
{
    if (data== nil)
    {
        return false;
    }
    NSDictionary * dic = data;
    _pid         = [dic valueForKey:@"pid"];
    _name        = [dic valueForKey:@"name"];
    _imgUrl      = [dic valueForKey:@"imgUrl"];
    _img         = _imgUrl;
    _price       = [dic valueForKey:@"price"];
    _spec        = [dic valueForKey:@"spec"];
    _totalSale   = [dic valueForKey:@"totalSale"];
    _hot         = [[dic valueForKey:@"hot"]boolValue];
    _onsale      = [[dic valueForKey:@"onsale"]boolValue];
    _newProduct  = [[dic valueForKey:@"newProduct"]boolValue];
    _description = [dic valueForKey:@"description"];
    _type        = [[dic valueForKey:@"type"] integerValue];
    
    return YES;
}

@end
