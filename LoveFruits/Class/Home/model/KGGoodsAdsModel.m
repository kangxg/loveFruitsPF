//
//  KGGoodsAdsModel.m
//  LoveFruits
//
//  Created by kangxg on 16/10/4.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGGoodsAdsModel.h"

@implementation KGGoodsAdsModel
@synthesize pid = _pid;
@synthesize img = _img;
@synthesize price = _price;
@synthesize name = _name;
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
    return YES;
}

@end
