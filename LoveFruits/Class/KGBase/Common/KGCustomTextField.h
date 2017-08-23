//
//  KGCustomTextField.h
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGInputValidator.h"
@interface KGCustomTextField : UITextField
@property (nonatomic, retain) KGInputValidator * KInputValidator;
- (BOOL) validate;
@end
