//
//  KGModelInterface.h
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGDicModelManager.h"
#import "DefineBlock.h"
@protocol KGModelInterface <NSObject,KGDictModelProtocol>

@optional
+(void)loadData:(void (^)(id<KGModelInterface> data,NSError * error))completion;

-(BOOL)putInData:(id)data;
-(BOOL)putInDataForArr:(id)data;
-(BOOL)putInDataFordic:(id)data;
-(void)putJsonData:(NSDictionary *)jsonDic withBlock:(KGPutDataBlock)block;

-(void)putJsonData:(NSDictionary *)jsonDic WithType:(NSInteger )type withBlock:(KGPutDataTypeBlock)block;


-(void)putJsonDataBackMessage:(NSDictionary *)jsonDic  withBlock:(KGPutDataMessageBlock)block ;
-(void)putJsonDataBackMessage:(NSDictionary *)jsonDic WithType:(NSInteger )type withBlock:(KGPutDataMessageBlock)block ;

@end
