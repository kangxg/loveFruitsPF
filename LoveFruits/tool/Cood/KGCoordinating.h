//
//  KGCoordinatingVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseVCTR.h"

@interface KGCoordinating : NSObject
@property (nonatomic,retain)NSMutableArray<UIViewController *>   * KGControllersArray;
@property (nonatomic,retain)KGBaseVCTR       * KGActiveController;
@property (nonatomic,retain)KGBaseVCTR       * KGMainViewController;
+( KGCoordinating *)shareInstance;
-(void)requestViewChange:(UIViewController *)fromView whitTo:(UIViewController *)toView;
-(void)pesentViewChange:(UIViewController *)fromView whitTo:(UIViewController *)toView;
-(void)popCallView:(UIViewController *)fromView;
@end
