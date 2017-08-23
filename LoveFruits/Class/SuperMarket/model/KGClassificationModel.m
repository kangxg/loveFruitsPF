//
//  KGClassificationModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGClassificationModel.h"

@implementation KGClassificationModel
@synthesize cid        = _cid;
@synthesize name       = _name;
@synthesize isleafnode = _isleafnode;
@synthesize pid        = _pid;
@synthesize sort       = _sort;

-(BOOL)putInDataFordic:(id)data
{
    if (data== nil)
    {
        return false;
    }
    NSDictionary * dic = data;
    _cid        =  [dic valueForKey:@"cid"];
    _name       =  [dic valueForKey:@"name"];
    _isleafnode =  [[dic valueForKey:@"isleafnode"]boolValue];
    _pid        =  [dic valueForKey:@"pid"];
    NSLog(@"%@",dic);
    _sort       =  [[dic valueForKey:@"sort"]integerValue];
    return true;
}
@end
