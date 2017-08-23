//
//  KGUserModelManager.m
//  LoveFruits
//
//  Created by kangxg on 16/9/21.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUserModelManager.h"

@interface KGUserModelManager()
{
    KGUserModel * _mUserModel;
}
@property(nonatomic,retain)KGUserModel * MDUserModel;
@end
@implementation KGUserModelManager
@synthesize MDUserModel = _mUserModel;
+(id)shareInstanced
{
    static KGUserModelManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KGUserModelManager alloc]init];
    });
    return instance;
    
}

-(id)init
{
    if (self =  [super init])
    {
       
        
    }
    return self;
}

-(NSString *)getPath
{
    return [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),@"Library/Caches/CurrentUser"];
    
}

-(void)setUserModel:(KGUserModel *)userModel
{
    _mUserModel  = userModel;
    
    [NSKeyedArchiver archiveRootObject:_mUserModel toFile:[self getPath]];
}
-(KGUserModel *)getUserModel
{
    KGUserModel * userModel=[NSKeyedUnarchiver unarchiveObjectWithFile:[self getPath]];
//    if (userModel == nil) {
//        userModel = [[KGUserModel alloc]init];
//    }
    return userModel;
}

-(void)saveSearchHistory:(NSString *)str
{
    KGUserModel * user = [[KGUserModelManager shareInstanced]getUserModel];
    if (user.KUserSearchHistory.count)
    {
        NSMutableArray *   array= user.KUserSearchHistory;
        if ([array containsObject:str])
        {
            return;
        }
        if (array.count>20)
        {
            [array removeObjectAtIndex:0];
        }
    
        [array addObject:str];
        [[KGUserModelManager shareInstanced]setUserModel:user];
    }
    else
    {
        NSMutableArray<NSString *> *  array=[[NSMutableArray alloc]init];
        [array addObject:str];
        user.KUserSearchHistory  = [array mutableCopy];
    
        [[KGUserModelManager shareInstanced]setUserModel:user];
    }
}
-(void)exitLogin
{
    NSString * path=[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),@"Library/Caches/CurrentUser"];
    NSFileManager * manager=[NSFileManager defaultManager];
    
    
    
    if ([manager fileExistsAtPath:path])
    {
        
        [manager removeItemAtPath:path error:nil];
     
    
    }
    

}
@end
