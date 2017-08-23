//
//  CCommonClass.m
//  DLTV
//
//  Created by apple on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCommonClass.h"
#import "MBProgressHUD.h"
#include <sys/mount.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation CCommonClass

@synthesize taskURLString;
@synthesize taskTitle;

+ (void)changeStateofTask:(NSString *)taskName to:(NSString *) stateString{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *articleDic = [[NSMutableDictionary alloc] initWithDictionary:[userDefaults objectForKey:taskName]];
	if (articleDic != nil) {
        [articleDic setValue:stateString forKey:@"VideoState"];
    }
    [userDefaults setObject:articleDic forKey:taskName];
//    [articleDic release];
}

+ (NSString *)getStateofTask:(NSString *)taskName{
    
    NSString *stateString = @"";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *articleDic = [userDefaults objectForKey:taskName];
	if (articleDic != nil) {
       stateString = [NSString stringWithString:[articleDic valueForKey:@"VideoState"]];        
    }
    return stateString;
}

+ (void) dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}

+ (void)alertAutoDismiss:(NSString *)title withMessage:(NSString *)msg withTime:(NSTimeInterval)delay{            
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:msg 
                                                   delegate:nil 
                                          cancelButtonTitle:nil 
                                          otherButtonTitles:nil
                          ];
    
    [alert show];
    
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:delay];
//    [alert release];
}

+ (void)msgHint:(NSString *)msg dismissAfter:(NSTimeInterval)delay {
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *window;
    if ([windows count] > 1) {
        window = [windows objectAtIndex:1];
    } else {
        window = [windows objectAtIndex:0];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.margin = 20.0f;
    hud.yOffset = 25.0f;
    hud.opacity = 0.8f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}


+ (void)alertTitle:(NSString *)title withMessage:(NSString *)msg {
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title 
						  message:msg
						  delegate:nil 
						  cancelButtonTitle:@"确   定" 
						  otherButtonTitles:nil];
	[alert show];
//	[alert release];
}

long long freeSpace() {
    struct statfs buf;
    long long freespace = -1;
    if (statfs("/var", &buf) >= 0) {
        freespace = (long long)buf.f_bsize*buf.f_bfree;
    }
    
    return freespace;
}

//Generate a UUID.
+ (NSString *) generateBoundaryString
{
    CFUUIDRef       uuid;
    CFStringRef     uuidStr;
    NSString *      result;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithFormat:@"%@", uuidStr];
	
	result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
	CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;	
}

// Get the first image from a video.
+ (UIImage *)getImage:(NSString *)videoURL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
	
    NSURL *url =[[NSURL alloc] initFileURLWithPath:videoURL] ;
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
	
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(600, 450);
    
    NSError *error = nil;
	UIImage *image;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
    
	if (error == nil) {
		image = [UIImage imageWithCGImage: img];
	} else {
		image = [[UIImage alloc] init];
	}
    
    CFRelease(img); // Pay attation to this, there are some special rules for memory management.
    
    return image;
}

// File every view pixel with no black borders, resize and crop if needed.
+ (UIImage *)image:(UIImage *)image fileSize:(CGSize)viewSize
{
	CGSize size = image.size;
	
	// Choose the scale factor that requires the least scaling.
	CGFloat scalex = viewSize.width / size.width;
	CGFloat scaley = viewSize.height / size.height;
	CGFloat scale = MAX(scalex, scaley);
	
	UIGraphicsBeginImageContext(viewSize);
	CGFloat width = size.width * scale;
	CGFloat height = size.height * scale;
	
	// Center the scaled image
	float dwidth = ((viewSize.width - width) / 2.0f);
	float dheight = ((viewSize.height - height) / 2.0f);
	CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height *scale);
	[image drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newimg;
}

//- (void) dealloc {
//    
//    [taskURLString release];
//    [taskTitle release];
//    
//    [super dealloc];
//}
//
@end
