//
//  NSString+KGMerge.m
//  LoveFruits
//
//  Created by kangxg on 16/4/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "NSString+KGMerge.h"

@implementation NSString (KGMerge)
-(void)merge:(NSDictionary *)dic
{
     [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
      {
          [self setValue:obj forKey:key];
     }];
 
}
@end
