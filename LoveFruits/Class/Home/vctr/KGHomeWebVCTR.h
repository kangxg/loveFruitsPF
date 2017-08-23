//
//  KGHomeWebVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseVCTR.h"
#import "KGHaveNavViewVCTR.h"
#import <WebKit/WebKit.h>
@interface KGHomeWebVCTR : KGHaveNavViewVCTR
@property (nonatomic,copy)NSString     * KVTitleString;
@property (nonatomic,copy)NSString     * KVWebUrlString;
-(id)init:(NSString *)navTitle withUrlStr:(NSString *)urlStr;
@end
