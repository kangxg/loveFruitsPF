//
//  YZUploadSingleImageItem.h
//  LoveFruits
//
//  Created by kangxg on 16/5/20.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "YZRequestItem.h"

@interface YZUploadSingleImageItem : YZRequestItem
@property(nonatomic,copy)NSString    *  YFileName;
@property(nonatomic,retain)NSData    *  YImageData;
@end
