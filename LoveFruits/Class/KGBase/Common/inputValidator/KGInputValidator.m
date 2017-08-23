//
//  KGInputValidator.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGInputValidator.h"

@implementation KGInputValidator
-(BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error
{
    if (error)
    {
        * error = nil;
    }
    return NO;
}
@end
