//
//  KGBaseModel.m
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "KGDicModelManager.h"
@implementation KGBaseModel
+(void)loadData:(void (^)(id<KGModelInterface> data, NSError * error))completion
{


    
}

+(NSDictionary *)customClassMapping
{
    return nil;
}

-(BOOL)putInData:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        return [self putInDataFordic:data];
    }
    else
    {
        return [self putInDataForArr:data];
    }
    return YES;
}


-(BOOL)putInDataForArr:(id)data
{
    if (data == nil) {
        return false;
    }
    return YES;
}

-(BOOL)putInDataFordic:(id)data
{
    if (data == nil)
    {
        return false;
    }
    return YES;
    
}

-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block
{
    
}

-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger)type withBlock:(KGPutDataTypeBlock)block
{
    
}
@end

