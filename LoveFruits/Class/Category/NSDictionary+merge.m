//
//  NSDictionary+merge.m
//  LoveFreshBeen
//
//  Created by kangxg on 16/5/2.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//

#import "NSDictionary+merge.h"

@implementation NSDictionary (merge)
-(void)merge:(NSDictionary *)dic
{
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
     {
         [self setValue:obj forKey:key];
     }];
    
}
@end
