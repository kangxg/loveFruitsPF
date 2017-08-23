//
//  KGOnLevelButton.m
//  LoveFruits
//
//  Created by kangxg on 16/9/30.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOnLevelButton.h"

@implementation KGOnLevelButton
@synthesize KVModel = _KVModel;

-(void)setKVModel:(KGClassificationModel *)KVModel
{
    if (KVModel)
    {
        _KVModel = KVModel;
    }
}
@end
