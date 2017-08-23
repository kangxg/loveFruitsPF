//
//  KGCoordinatingVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCoordinating.h"
static KGCoordinating * coord = nil;
@implementation KGCoordinating
+( KGCoordinating *)shareInstance
{
    if (coord == nil)
    {
        coord = [[self alloc]init];
    }
    return coord;
}
-(NSMutableArray *)KGControllersArray
{
    if (_KGControllersArray == nil)
    {
        _KGControllersArray = [[NSMutableArray alloc]init];
    }
    
    return _KGControllersArray;
}
-(id)copy
{
    return self;
}

-(void)setKGMainViewController:(KGBaseVCTR *)KGMainViewController
{
//    if (_KGMainViewController)
//    {
//        if (![self.KGControllersArray containsObject:_KGMainViewController])
//        {
//            [self.KGControllersArray addObject:_KGMainViewController];
//        }
//        
//    }
    
    _KGMainViewController = KGMainViewController;
}

-(void)setKGActiveController:(KGBaseVCTR *)KGActiveController
{
        if (_KGActiveController)
        {
            if (![self.KGControllersArray containsObject:_KGActiveController])
            {
                [self.KGControllersArray addObject:_KGActiveController];
            }
            
        }
    _KGActiveController = KGActiveController;
}
-(void)requestViewChange:(UIViewController *)fromView whitTo:(UIViewController *)toView
{
    if (fromView && toView)
    {
        [fromView.navigationController pushViewController:toView animated:YES];
    }
}

-(void)popCallView:(UIViewController *)fromView
{
    [fromView.navigationController popToRootViewControllerAnimated:YES];

    if (fromView == _KGMainViewController)
    {
        _KGActiveController = nil;
        [_KGControllersArray removeAllObjects];
    }

}

-(void)pesentViewChange:(UIViewController *)fromView whitTo:(UIViewController *)toView
{
    if (fromView && toView)
    {
        [fromView presentViewController:toView animated:YES completion:nil];
    }
}
@end
