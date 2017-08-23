//
//  LFBTableView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "LFBTableView.h"

@implementation LFBTableView
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delaysContentTouches    =   false;
        self.canCancelContentTouches =   true;
        self.separatorStyle          =   UITableViewCellSeparatorStyleNone;
        UIView * wrapView            =   self.subviews.firstObject;
        NSString * clz               =   NSStringFromClass([wrapView class]);
        if (wrapView != nil &&  [clz hasPrefix:@"WrapperView"])
        {
            for ( UIGestureRecognizer * gesture in wrapView.gestureRecognizers)
            {
                NSString * cl               =   NSStringFromClass([gesture class]);
                if ([cl containsString:@"DelayedTouchesBegan"])
                {
                    gesture.enabled = false;
                    break;
                }
            }
           
        }
    }
    return self;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIControl class]])
   {
       return true;
    }
    return [super touchesShouldCancelInContentView:view];
}
@end
