//
//  DesUtil.h
//  向前冲
//
//  Created by 纳米 on 15-3-5.
//  Copyright (c) 2015年 纳米. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "GTMBase64.h"

@interface DesUtil : NSObject
+(NSString *) encryptUseAES:(NSString *)clearText;
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key ;
/**
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)plainText;
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 DES解密
 */
+(NSString*) decryptUseDES:(NSString *)plainText key:(NSString *)key;

+(NSString*) decryptUseDES:(NSString *)plainTex;


@end
