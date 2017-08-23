//
//  KGCustomTextField.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCustomTextField.h"

@implementation KGCustomTextField
@synthesize KInputValidator = _KInputValidator;
- (BOOL) validate
{
    NSError *error = nil;
    BOOL validationResult = [_KInputValidator validateInput:self error:&error];
    if (!validationResult)
    {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:[error localizedDescription]];
//                                  
//        [alertView show];
    }
    return validationResult;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if ([textField isKindOfClass:[CustomTextField class]]) {
//        [(CustomTextField*)textField validate]; }
//}
@end
