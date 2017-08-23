//
//  KGAnimationTabBarController.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGAnimationTabBarController : UITabBarController
-(NSDictionary *)createViewContainers;
-(void)createCustomIcons:(NSDictionary *)containers;
-(void)setSelectIndex:(NSInteger)from withTag:(NSInteger)tag;


-(void)addProductsAnimation:(UIImageView *)imageView;
@end
