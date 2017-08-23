//
//  KGUserModelManager.h
//  LoveFruits
//
//  Created by kangxg on 16/9/21.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGUserModel.h"
@interface KGUserModelManager : NSObject

+(id)shareInstanced;

-(void)setUserModel:(KGUserModel *)userModel;
-(KGUserModel *)getUserModel;
//退出登录
-(void)exitLogin;

//存储历史记录
-(void)saveSearchHistory:(NSString * )str;
@end
