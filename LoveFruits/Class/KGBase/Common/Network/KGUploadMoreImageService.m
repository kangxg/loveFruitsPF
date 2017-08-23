//
//  KGUploadMoreImageService.m
//  LoveFruits
//
//  Created by kangxg on 16/5/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUploadMoreImageService.h"

@implementation KGUploadMoreImageService
+(void)uploadImagesWithUrl:(NSString *)urlStr parameters:(id)parameters withImags:(NSArray *)images success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];

    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
        
         if (images.count > 0) {
             NSObject *firstObj = [images objectAtIndex:0];
             if ([firstObj isKindOfClass:[UIImage class]])
             {     // 图片
                 for(NSInteger i=0; i<images.count; i++) {
                     UIImage *eachImg = [images objectAtIndex:i];
                     //NSData *eachImgData = UIImagePNGRepresentation(eachImg);
                     NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.8);
                     [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"img%ld", i+1] fileName:[NSString stringWithFormat:@"img%ld.jpg", i+1] mimeType:@"multipart/form-data"];
               
                 }
             }
         }
         
         
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
          {
             if (requestSuccess)
             {
               requestSuccess(responseObject);
             }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
          {
             if (requestFailed) {
                 requestFailed(error);
         }
     }];
    
    
}

@end
