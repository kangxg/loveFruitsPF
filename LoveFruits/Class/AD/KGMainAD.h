//
//  KGMainAD.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGBaseModel.h"

@interface AD: KGBaseModel
@property (nonatomic,copy)NSString  * title;
@property (nonatomic,copy)NSString  * img_name;
@property (nonatomic,assign)NSInteger  picOrder;
@property (nonatomic,copy)NSString  * starttime;
@property (nonatomic,copy)NSString  * endtime;
@end
@interface KGMainAD : NSObject
@property (nonatomic,retain)NSArray< AD  *>  *dataArr;
@property (nonatomic,copy)NSString  * msg;
@property (nonatomic,assign)int       code;
+(void)loadADData:(void (^)(NSArray * data, NSError * error))completion;
@end
