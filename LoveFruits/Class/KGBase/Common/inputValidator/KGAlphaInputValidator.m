//
//  KGAlphaInputValidator.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAlphaInputValidator.h"

@implementation KGAlphaInputValidator
-(BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error
{
    NSError *regError = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[a-zA-Z]*$" options:NSRegularExpressionAnchorsMatchLines error:&regError];
    NSUInteger numberOfMatches = [regex
                                  numberOfMatchesInString:[input text]
                                  options:NSMatchingAnchored range:NSMakeRange(0, [[input text] length])];
    
      if (numberOfMatches == 0)
      {
        
        if (error != nil)
        {
            NSString *description = NSLocalizedString(@"Input Validation Failed", @""); NSString *reason = NSLocalizedString(@"The input can contain only letters", @"");
            NSArray * objArr = [NSArray arrayWithObjects:description, reason, nil]; NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSLocalizedFailureReasonErrorKey, nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArr forKeys:keyArray];
            
            * error = [NSError errorWithDomain:InputValidationErrorDomain code:1002 userInfo:userInfo];

            
        }
          return NO;
    }
    return YES;
}
@end
