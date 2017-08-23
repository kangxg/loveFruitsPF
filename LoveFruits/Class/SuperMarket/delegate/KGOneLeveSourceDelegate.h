//
//  KGOneLeveSourceDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/9/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KGClassificationModel;
@protocol KGOneLeveSourceDelegate <NSObject>
-(NSArray<KGClassificationModel *> *)getClassModel;
@end
