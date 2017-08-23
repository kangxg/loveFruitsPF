//
//  KGAdressData.h
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGBaseModel.h"
@interface Address:NSObject
@property (nonatomic,copy)NSString *  accept_name;
@property (nonatomic,copy)NSString *  telphone;
@property (nonatomic,copy)NSString *  province_name;
@property (nonatomic,copy)NSString *  city_name;
@property (nonatomic,copy)NSString *  address;
@property (nonatomic,copy)NSString *  lng;
@property (nonatomic,copy)NSString *  lat;
@property (nonatomic,copy)NSString *  gender;
@end

@interface KGAdressData : KGBaseModel
@property (nonatomic,retain)NSMutableArray<Address *>  * data;
@end
