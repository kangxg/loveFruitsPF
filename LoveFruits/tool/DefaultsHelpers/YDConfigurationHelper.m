//
//  YDConfigurationHelper.m
//  MyPersonalLibrary
//
//  Created by kangxg on 16/1/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "YDConfigurationHelper.h"
#import "GlobelDefine.h"
@implementation YDConfigurationHelper
+(void)setApplicationStartupDefaults
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    [defaultes setBool:YES forKey:MFirstLaunch];
    //[defaultes setBool:NO forKey:bYDAuthenticated];
    [defaultes synchronize];
    
}

+(BOOL)getApplicationStartupDefaults
{
    return [YDConfigurationHelper getBoolValueForConfigurationKey:MFirstLaunch];
}
+(BOOL)getBoolValueForConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    return [defaultes boolForKey:_objectKey];
}
+(double)getDoubleValueForConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    return [defaultes doubleForKey:_objectKey];
}
+(NSString *)getStringValueFroConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    if ([defaultes stringForKey:_objectKey] == nil)
    {
        return @"";
    }
    else
    {
        return [defaultes stringForKey:_objectKey];
    }
}
+(NSArray *)getArrayValueforConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    if ([defaultes objectForKey:_objectKey] == nil)
    {
        return [NSArray array];
    }
    else
    {
//       return  [defaultes mutableArrayValueForKey:_objectKey];
        return  [defaultes arrayForKey:_objectKey];
    }

}

+(NSDictionary  *)getDicValueforConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    if ([defaultes objectForKey:_objectKey] == nil)
    {
        return nil;
    }
    else
    {
        return [defaultes dictionaryForKey:_objectKey];
    }
}
+(void)setBoolValueForConfigurationkey:(NSString *)_objectKey withValue:(BOOL)_boolValue
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    [defaultes setBool:_boolValue forKey:_objectKey];
    [defaultes synchronize];
}


+(void)setDoubleValueForConfigurationkey:(NSString *)_objectKey withValue:(double)_doubleValue
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    [defaultes setDouble:_doubleValue forKey:_objectKey];
    [defaultes synchronize];
}

+(void)setObjectForConfigurationkey:(NSString *)_objectKey withValue:(id)_object
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
//    [defaultes synchronize];
    [defaultes setObject:_objectKey forKey:_objectKey];
    [defaultes synchronize];
}
+(void)setStringValueForConfigurationKey:(NSString *)_objectKey withValue:(NSString *)_value
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    [defaultes setValue:_value forKey:_objectKey];
    [defaultes synchronize];
}

+(void)removeStringValueFroConfigurationKey:(NSString *)_objectKey
{
    NSUserDefaults * defaultes = [NSUserDefaults standardUserDefaults];
    [defaultes synchronize];
    [defaultes removeObjectForKey:_objectKey];
    [defaultes synchronize];
}
@end
