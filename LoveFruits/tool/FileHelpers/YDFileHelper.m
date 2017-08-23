//
//  YDFileHelper.m
//  YZJOB-2
//
//  Created by kangxg on 16/2/26.
//  Copyright © 2016年 lfh. All rights reserved.
//

#import "YDFileHelper.h"

@implementation YDFileHelper
+(NSString *)getPathFromeBundle:(NSString *)fileName withFileType:(NSString *)fileType
{
    NSString * path         = [[NSBundle mainBundle]pathForResource:fileName ofType:fileType];
    return path;
}
+(NSURL *)getUrlValueForFileNameFromeHomeDocuments:(NSString *)fileName withFileType:(NSString *)fileType
{
    NSString * path         = [YDFileHelper getPathFromeBundle:fileName withFileType:fileType];
    NSFileManager * manager = [NSFileManager defaultManager];
    NSURL * url             = nil;
    if ([manager fileExistsAtPath:path])
    {
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileType];
        
    }
    else
    {
        NSString * filterpath = [NSString stringWithFormat:@"%@/%@.%@",[YDFileHelper getHomeDocumentsPath],fileName,fileType];
        url  = [NSURL fileURLWithPath:filterpath];
    }
    return url;
}
+(NSData *)getUrlValueForFileNameFromeHomeDocuments:(NSString *)fileName
{
    NSString *path      = [YDFileHelper getHomeDocumentsPath];
    NSString *Json_path =[path stringByAppendingPathComponent:fileName];
    NSData * data       = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:Json_path])
    {
        data=[NSData dataWithContentsOfFile:Json_path];
    }
    return data;
}

+(NSURL *)getUrlValueForFileNameFromeHomeCache:(NSString *)fileName withFileType:(NSString *)fileType
{
    NSString * path         = [YDFileHelper getPathFromeBundle:fileName withFileType:fileType];
    NSFileManager * manager = [NSFileManager defaultManager];
    NSURL * url             = nil;
    if ([manager fileExistsAtPath:path])
    {
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileType];
        
    }
    else
    {
        NSString * filterpath = [NSString stringWithFormat:@"%@/%@.%@",[YDFileHelper getHomeCachePath],fileName,fileType];
        url  = [NSURL fileURLWithPath:filterpath];
    }
    return url;
}
+(NSData *)getUrlValueForFileNameFromeHomeCache:(NSString *)fileName
{
    NSString *path      = [YDFileHelper getHomeCachePath];
    NSString *Json_path =[path stringByAppendingPathComponent:fileName];
    NSData * data       = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:Json_path])
    {
        data= [NSData dataWithContentsOfFile:Json_path];
    }
    return data;
}
+(NSString *)getHomeDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"app_home_doc: %@\n",documentsDirectory);
    return documentsDirectory;
}

+(NSString *)getHomeLibraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    //NSLog(@"app_home_lib: %@\n",libraryDirectory);
    return libraryDirectory;
}
+(NSString *)getHomeCachePath
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    //NSLog(@"app_home_tmp: %@\n",tmpDirectory);
    return tmpDirectory;
}

+(BOOL)writeFileWithDataToHomeDocuments:(id)data withFileName:(NSString *)fileName
{
    if (data == nil)
    {
        return false;
    }
    NSString * path= [YDFileHelper getHomeDocumentsPath];
    NSString  * file_path=[path stringByAppendingPathComponent:fileName];;
    return  [data writeToFile:file_path atomically:YES];
}

+(BOOL)writeFileWithDataToHomeCache:(id)data withFileName:(NSString *)fileName
{
    if (data == nil)
    {
        return false;
    }
    NSString * path= [YDFileHelper getHomeCachePath];
    NSString  * file_path=[path stringByAppendingPathComponent:fileName];;
    return  [data writeToFile:file_path atomically:YES];
}

@end
