//
//  KGDataBase.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/26.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@class KGUserModel;
@interface KGDataBase : NSObject
+(instancetype)shareInstance;

//增加一个与用户关联的表
-(void)createTableWithTablename:(NSString* )name;

-(void)updateUserInfo:(KGUserModel *) userModel;
@end
