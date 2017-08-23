//
//  KGUserModel.h
//  LoveFruits
//
//  Created by kangxg on 16/9/21.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGUserModel : NSObject
//用户id
@property(copy,nonatomic)NSString * KUserId;

//用户标识符
@property(copy,nonatomic)NSString * KUserToken;
/**
 *  Description
 */
@property(copy,nonatomic)NSString * KUserMobile;

/**
 *  Description
 */
@property(copy,nonatomic)NSString * KUserEmail;

/**
 *  Description
 */
@property(copy,nonatomic)NSString * KUserName;

/**
 *  Description 店铺名称
 */
@property(copy,nonatomic)NSString * KStoreName;

/**
 *  Description 负责人姓名
 */
@property(copy,nonatomic)NSString * KHeadName;
/**
 *  Description 地址
 */
@property(copy,nonatomic)NSString * KAdress;
/**
 *  Description
 */
@property(copy,nonatomic)NSString * KUserLogoUrl;

//@property(copy,nonatomic)NSString * KUserNickname;


/**
 *  Description
 */
@property(strong,nonatomic)NSMutableArray<NSString *> * KUserSearchHistory;

-(void)saveUserInfo;

@end
