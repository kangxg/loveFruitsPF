//
//  KGUploadSingleImageService.m
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUploadSingleImageService.h"

@implementation KGUploadSingleImageService
+(void)uploadImageWithUrl:(NSString *)urlStr imagefileName:(NSString*)name imageData:(NSData *)imagedata parameters:(id)parameters success:(KGRequestSuccessBlock)requestSuccess failed:(KGRequestFaildBlock)requestFailed
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json",@"text/html",@"text/plain", nil];
    //lic_url multipart/form-data @"image/png"
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        //@"image/png" @"multipart/form-data"
         [formData appendPartWithFileData:imagedata name:@"lic_url" fileName:[NSString stringWithFormat:@"%@.png", @"lic_url"] mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        if (requestSuccess)
        {
            requestSuccess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (requestFailed) {
            requestFailed(error);
        }
    }];
    

}
@end
