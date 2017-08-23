//
//  KGChannelModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGChannelModel.h"

@implementation KGChannelModel
-(BOOL)putInDataFordic:(id)data
{
    if (data)
    {
        NSDictionary * dic   =   data;
        _KDImg               =   [dic valueForKey:@"img"];
        _KDTitle             =   [dic valueForKey:@"title"];
        _KDContent           =   [dic valueForKey:@"content"];
        _KDPayChannel        =   [[dic valueForKey:@"sub"] integerValue];
    }
    return false;
}

@end
