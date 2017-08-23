//
//  KGHomeCommodityViewModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCommodityViewModel.h"

@implementation KGHomeCommodityViewModel
@synthesize KDCellModelArry = _KDCellModelArry;
-(id)init
{
    if (self = [super init ])
    {
        _KDCellModelArry = [[NSMutableArray alloc]init];
    }
    return self;
}
@end
