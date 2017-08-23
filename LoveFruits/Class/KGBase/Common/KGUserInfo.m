//
//  KGUserInfo.m
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGUserInfo.h"
#import "KGAdressData.h"
static KGUserInfo * userinfo = nil;
@interface KGUserInfo()
@property (nonatomic,retain)NSMutableArray<Address *> * MAllAdress;
@end

@implementation KGUserInfo
+(KGUserInfo *)sharedUserInfo
{
    if (userinfo == nil)
    {
        userinfo = [[KGUserInfo alloc]init];
    }
    return userinfo;
}

-(BOOL)hasDefaultAdress
{
    if (_MAllAdress == nil)
    {
        return false;
    }
    else
    {
        return true;
    }
}
-(void)setAllAdress:(NSArray<Address *> *) adresses
{
    if (adresses)
    {
        _MAllAdress = [[NSMutableArray alloc]initWithArray:adresses];
    }
}
-(void)cleanAllAdress
{
    if (_MAllAdress)
    {
        _MAllAdress = nil;
    }
}
-(Address *)defaultAdress
{
    if (_MAllAdress == nil)
    {
     __weak  KGUserInfo * tmpSelf = self;
        [KGAdressData loadData:^(id<KGModelInterface> data, NSError *error)
         {
             KGAdressData * da = (KGAdressData *)data;
             if (da.data.count>0)
             {
                 tmpSelf.MAllAdress= da.data;
             }
             else
             {
                 [tmpSelf.MAllAdress  removeAllObjects];
             }
        }];
      
    }
    if (_MAllAdress.count>1)
    {
        return _MAllAdress[0];
    }
    else
    {
        return nil;
    }
}
-(void)setDefaultAdress:(Address *)address
{
    if (_MAllAdress != nil)
    {
        [_MAllAdress insertObject:address atIndex:0];
    }
    else
    {
        _MAllAdress = [[NSMutableArray alloc]init];
        [_MAllAdress addObject:address];
    }
}

@end
