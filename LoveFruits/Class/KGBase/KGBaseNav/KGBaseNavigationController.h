//
//  KGBaseNavigationController.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGBaseNavigationController : UINavigationController
@property (nonatomic,retain)UIButton  *  KGNavBackButton;
@property (nonatomic,assign)BOOL KGIsAnimation;
-(void)backBtnClick;
//-(void)setNavBackItem;
@end
