//
//  KGUserInfo.h
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Address;
@interface KGUserInfo : NSObject
+(KGUserInfo *)sharedUserInfo;
-(BOOL)hasDefaultAdress;
-(void)setAllAdress:(NSArray<Address *> *) adresses;
-(void)cleanAllAdress;
-(Address *)defaultAdress;
-(void)setDefaultAdress:(Address *)address;
@end
