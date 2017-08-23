//
//  KGInputValidator.h
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define InputValidationErrorDomain @"inputCheckError"
@interface KGInputValidator : NSObject
-(BOOL)validateInput:(UITextField *)input  error:(NSError **)error;
@end
