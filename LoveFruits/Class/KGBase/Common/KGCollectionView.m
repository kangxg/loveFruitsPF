//
//  KGCollectionView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCollectionView.h"

@implementation KGCollectionView
-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self  = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delaysContentTouches = false;
        self.canCancelContentTouches = true;
        UIView * wrapView = self.subviews.firstObject;
        if (wrapView)
        {
            NSString * string =   NSStringFromClass([wrapView class]);
            if ([string hasPrefix:@"WrapperView"])
            {
                for (UIGestureRecognizer * gesture in wrapView.gestureRecognizers)
                {
                    if ([NSStringFromClass([gesture class]) containsString:@"DelayedTouchesBegan"])
                    {
                        gesture.enabled = false;
                        break;
                    }
                }
            }
        }
    }
    
    return self;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIControl class]])
    {
        return true;
    }
    
    return [super touchesShouldCancelInContentView:view];
}
@end
