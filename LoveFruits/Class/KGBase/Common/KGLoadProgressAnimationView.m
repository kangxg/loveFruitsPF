//
//  KGLoadProgressAnimationView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLoadProgressAnimationView.h"
#import "GlobelDefine.h"

@interface KGLoadProgressAnimationView()
@property (nonatomic,assign)CGFloat  MViewWidth;
@end

@implementation KGLoadProgressAnimationView
-(void)setFrame:(CGRect)frame
{
    if (frame.size.width == _MViewWidth)
    {
        self.hidden = true;
    }
    super.frame= frame;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _MViewWidth = frame.size.width;
        self.backgroundColor = LFBNavigationYellowColor;
        frame.size.width  = 0;
        self.frame  = frame;
    }
    return self;
}

-(void)startLoadProgressAnimation
{
    CGRect frame = self.frame;
    frame.size.width = 0;
    self.frame = frame;
    __weak KGLoadProgressAnimationView * tmpSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        CGRect fm = tmpSelf.frame;
        fm.size.width = tmpSelf.MViewWidth * 0.6;
        tmpSelf.frame = fm;
    } completion:^(BOOL finished) {
        dispatch_time_t  time = dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                CGRect fm2 = tmpSelf.frame;
                fm2.size.width = tmpSelf.MViewWidth * 0.8;
                tmpSelf.frame = fm2;
            }];
        });
    }];
}

-(void)endLoadProgressAnimation
{
    __weak KGLoadProgressAnimationView * tmpSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.size.width = tmpSelf.MViewWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        tmpSelf.hidden = true;
    }];
}
@end
