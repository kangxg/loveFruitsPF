//
//  KGDataBase.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/26.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGDataBase.h"
#import "KGUserModel.h"
@interface KGDataBase()
{
    FMDatabase * _mDatabaseServer;
}
@end

@implementation KGDataBase
+(instancetype)shareInstance
{
    static id _s;
    if (_s == nil) {
        _s = [[[self class] alloc] init];
    }
    return _s;
    
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/app.db", NSHomeDirectory()];
        // 创建一个数据库对象
        _mDatabaseServer = [[FMDatabase alloc] initWithPath:path];
        // 打开数据库
        [_mDatabaseServer open];
        
        [self createTable];
    }
    return self;
}
- (void)createTable
{
    NSString *sql = @"create table if not exists userInfoTable  ("
    " (userId varchar(100) PRIMARY KEY, "
    " headName varchar(100) , "
    " adress varchar(100) ,"
    " storeName varchar(100)"
    ");";
  
    [_mDatabaseServer executeUpdate:sql];
}
-(void)updateUserInfo:(KGUserModel *) userModel
{
    NSString *updateSql = @"";
    
    updateSql = [[NSString alloc] initWithFormat:@"UPDATE 'userInfoTable' SET 'userId' = '%@' and  'headName' = '%@' and 'adress' = '%@'and 'storeName' = '%@'", userModel.KUserId,userModel.KHeadName,userModel.KAdress,userModel.KStoreName];
    [_mDatabaseServer executeUpdate:updateSql];
}


-(void)createTableWithTablename:(NSString *)name
{
    
    NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(userId varchar(100) PRIMARY KEY,data text,updatetime integer,sort integer);",name];
    
    [_mDatabaseServer executeUpdate:sql];
    
}
@end
