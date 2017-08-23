//
//  KGNumericInputValidator.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGNumericInputValidator.h"

@implementation KGNumericInputValidator
- (BOOL) validateInput:(UITextField *)input error:(NSError**) error {
    NSError *regError = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionAnchorsMatchLines error:&regError];
    NSUInteger numberOfMatches = [regex
                                  numberOfMatchesInString:[input text]
                                  options:NSMatchingAnchored range:NSMakeRange(0, [[input text] length])];
    if (numberOfMatches == 0)
    {
        if (error != nil)
        {
            NSString *description = NSLocalizedString(@"Input Validation Failed", @""); NSString *reason = NSLocalizedString(@"The input can contain only letters", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil]; NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,
                                                                                                          NSLocalizedFailureReasonErrorKey, nil];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            * error = [NSError errorWithDomain:InputValidationErrorDomain code:1002 userInfo:userInfo];
        }
        return NO;
    }
    
    return YES;
}
@end
