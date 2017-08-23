//
//  NSString+Extension.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(NSString *)cleanDecimalPointZear
{
    NSString * newStr = self;
    NSString  * s = nil;
    NSInteger offset = newStr.length -1;
    while (offset>0)
    {
        s = [newStr substringWithRange:NSMakeRange(offset, 1)];
        if ([s isEqualToString:@"0"] || [s isEqualToString:@"."])
        {
            offset--;

        }
        else
        {
            break;
        }
    }
    return  [newStr substringToIndex:offset + 1];
}
@end
