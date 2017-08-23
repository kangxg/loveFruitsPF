//
//  KGUserModel.m
//  LoveFruits
//
//  Created by kangxg on 16/9/21.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUserModel.h"
#import "YDConfigurationHelper.h"
@implementation KGUserModel
@synthesize KUserId             = _KUserId;
@synthesize KUserName           = _KUserName;
@synthesize KUserEmail          = _KUserEmail;
@synthesize KUserToken          = _KUserToken;
@synthesize KUserMobile         = _KUserMobile;
@synthesize KUserLogoUrl        = _KUserLogoUrl;
@synthesize KUserSearchHistory  = _KUserSearchHistory;
-(id)init
{
    if (self = [super init])
    {
        _KUserId              =  @"";
        _KUserName            =  @"";
        _KUserEmail           =  @"";
        _KUserToken           =  @"";
        _KUserMobile          =  @"";
        _KUserLogoUrl         =  @"";
        _KAdress              =  @"";
        _KHeadName            =  @"";
        _KStoreName           =  @"";
        _KUserSearchHistory   =  [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_KUserToken forKey:@"AUTHTOKEN"];
  
    [aCoder encodeObject:_KUserSearchHistory forKey:@"searchHistoryArr"];

    [aCoder encodeObject:_KUserId forKey:@"uid"];
    
    
    [aCoder encodeObject:_KUserLogoUrl forKey:@"userLogoUrl"];
    
    
    [aCoder encodeObject:_KUserName  forKey:@"userName"];
    [aCoder encodeObject:_KUserEmail forKey:@"userEmail"];
    
    
    [aCoder encodeObject:_KUserMobile forKey:@"userMobile"];
   
    [aCoder encodeObject:_KAdress forKey:@"userAdress"];
    
    [aCoder encodeObject:_KStoreName forKey:@"storeName"];
    
    [aCoder encodeObject:_KHeadName forKey:@"headName"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init])
    {
        _KUserToken         = [aDecoder decodeObjectForKey:@"AUTHTOKEN"];
        _KUserId            = [aDecoder decodeObjectForKey:@"uid"];
        _KUserSearchHistory = [aDecoder decodeObjectForKey:@"searchHistoryArr"];
        
        
        _KUserMobile        = [aDecoder decodeObjectForKey:@"userMobile"];
        _KUserEmail         = [aDecoder decodeObjectForKey:@"userEmail"];
        _KUserName          = [aDecoder decodeObjectForKey:@"userName"];
        _KUserLogoUrl       = [aDecoder decodeObjectForKey:@"userLogoUrl"];
    
        _KHeadName          = [aDecoder decodeObjectForKey:@"headName"];
        _KStoreName         = [aDecoder decodeObjectForKey:@"storeName"];
        _KAdress            = [aDecoder decodeObjectForKey:@"userAdress"];
        
    }
    
    return self;
    
}

-(void)setuserStoreInfo
{
   
}
-(void)saveUserInfo
{
    
}
@end
