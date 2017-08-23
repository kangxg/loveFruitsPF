//
//  YDConfigurationHelper.h
//  MyPersonalLibrary
//
//  Created by kangxg on 16/1/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDConfigurationHelper : NSObject
+(void) setApplicationStartupDefaults;
+(BOOL) getApplicationStartupDefaults;
+(BOOL) getBoolValueForConfigurationKey:(NSString *)_objectKey;

+(double) getDoubleValueForConfigurationKey:(NSString *)_objectKey;

+(NSString *)getStringValueFroConfigurationKey:(NSString *)_objectKey;

+(NSArray  *)getArrayValueforConfigurationKey:(NSString *)_objectKey;

+(NSDictionary  *)getDicValueforConfigurationKey:(NSString *)_objectKey;
+(void)setBoolValueForConfigurationkey:(NSString *)_objectKey withValue:(BOOL)_boolValue;

+(void)setDoubleValueForConfigurationkey:(NSString *)_objectKey withValue:(double)_doubleValue;
+(void)setStringValueForConfigurationKey:(NSString *)_objectKey withValue:(NSString *)_value;

+(void)setObjectForConfigurationkey:(NSString *)_objectKey withValue:(id)_object;
+(void)removeStringValueFroConfigurationKey:(NSString *)_objectKey;
@end

