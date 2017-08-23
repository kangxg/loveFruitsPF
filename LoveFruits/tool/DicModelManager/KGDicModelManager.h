//
//  KGDicModelManager.h
//  LoveFruits
//
//  Created by kangxg on 16/4/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  KGDictModelProtocol<NSObject>
+(NSDictionary *)customClassMapping;
@end

@interface KGDicModelManager : NSObject
+(KGDicModelManager *)shareManager;
-(id)objectWithDictionary:(NSDictionary *)dic  withcls:(Class)anyclass;
@end
