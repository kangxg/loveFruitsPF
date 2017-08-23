//
//  KGAnimationViewController.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseVCTR.h"

@interface KGAnimationViewController : KGBaseVCTR
@property (nonatomic,retain)NSMutableArray <CALayer *> * KGAnimationLayers;

-(void)addProductsAnimation:(UIImageView *)imageView;
@end
