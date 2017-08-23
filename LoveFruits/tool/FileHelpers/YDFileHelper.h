//
//  YDFileHelper.h
//  YZJOB-2
//
//  Created by kangxg on 16/2/26.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDFileHelper : NSObject
+(NSString *)getPathFromeBundle:(NSString *)fileName withFileType:(NSString *)fileType;

+(NSURL *)getUrlValueForFileNameFromeHomeDocuments:(NSString *)fileName withFileType:(NSString *)fileType;
+(NSData *)getUrlValueForFileNameFromeHomeDocuments:(NSString *)fileName;

+(NSURL *)getUrlValueForFileNameFromeHomeCache:(NSString *)fileName withFileType:(NSString *)fileType;
+(NSData *)getUrlValueForFileNameFromeHomeCache:(NSString *)fileName;

+(BOOL)writeFileWithDataToHomeDocuments:(id)data withFileName:(NSString *)fileName;
+(BOOL)writeFileWithDataToHomeCache:(id)data   withFileName:(NSString *)fileName;

+(NSString *)getHomeLibraryPath;
+(NSString *)getHomeDocumentsPath;
+(NSString *)getHomeCachePath;

@end
