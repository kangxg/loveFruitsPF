//
//  KGHomeHeadResources.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGDicModelManager.h"
#import "KGBaseModel.h"
@interface Activities : KGBaseModel

@property (nonatomic,copy)NSString *  pid;
@property (nonatomic,copy)NSString *  name;
@property (nonatomic,copy)NSString *  img;
@property (nonatomic,copy)NSString *  detailUrl;
@property (nonatomic,copy)NSString *  desc;

@end

@interface HeadData : KGBaseModel<KGDictModelProtocol>
@property (nonatomic,retain)NSMutableArray<Activities *> * focus;
@property (nonatomic,retain)NSMutableArray<Activities *> * icons;
@property (nonatomic,retain)NSMutableArray<Activities *> * activities;


@end

@interface KGHomeHeadResources : NSObject<KGDictModelProtocol>
@property (nonatomic,copy)NSString *  msg;
@property (nonatomic,copy)NSString *  reqid;
@property (nonatomic,retain)HeadData * data;
+(void)loadHomeHeadData:(void (^)(KGHomeHeadResources * data,NSError * error))completion;
@end
