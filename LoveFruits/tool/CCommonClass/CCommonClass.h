//
//  CCommonClass.h
//  DLTV
//
//  Created by apple on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ITEMCOLOR [UIColor colorWithRed:0/255.0 green:60/255.0 blue:140/255.0 alpha:1.0]

@interface CCommonClass : NSObject

@property (nonatomic, copy) NSString        *taskURLString;
@property (nonatomic, copy) NSString        *taskTitle;

long long freeSpace();
//- (void)downloadVideoFromURLPath:(NSString *)URLString with:(NSRange)range;
+ (void)changeStateofTask:(NSString *)taskName to:(NSString *) stateString;
+ (NSString *)getStateofTask:(NSString *)taskName;
+ (void)alertTitle:(NSString *)title withMessage:(NSString *)msg;
+ (void)alertAutoDismiss:(NSString *)title withMessage:(NSString *)msg withTime:(NSTimeInterval)delay;
+ (void)msgHint:(NSString *)msg dismissAfter:(NSTimeInterval)delay;
+ (NSString *) generateBoundaryString;
+ (UIImage *)getImage:(NSString *)videoURL;
+ (UIImage *)image:(UIImage *)image fileSize:(CGSize)viewSize;
@end
