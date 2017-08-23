//
//  KGGuideCell.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGGuideCell.h"
#import "GlobelDefine.h"
@interface KGGuideCell()

@property(nonatomic,retain)UIButton    * MNextButton;
@end

@implementation KGGuideCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {

        _KGImageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
        _KGImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_KGImageView];
        
        _MNextButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        _MNextButton.frame = CGRectMake((ScreenWidth - 100) * 0.5, ScreenHeight - 110, 100, 33);
        [_MNextButton setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        [_MNextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _MNextButton.hidden = true;
        [self.contentView addSubview:_MNextButton];
    }
    return self;
}
-(void)setNextButtonHidden:(BOOL)hidden
{
    if (_MNextButton)
    {
        _MNextButton.hidden = hidden;
    }
}
-(void)nextButtonClick
{
    [[NSNotificationCenter defaultCenter]postNotificationName:GuideViewControllerDidFinish object:nil];
}
@end
