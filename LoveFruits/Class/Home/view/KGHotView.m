//
//  KGHotView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHotView.h"
#import "GlobelDefine.h"
#import "KGHomeHeadResources.h"
#import "KGIconImageTextView.h"
@interface KGHotView()
{
    
}
@property (nonatomic,assign)CGFloat MIConW;
@property (nonatomic,assign)CGFloat MIConH;
@property (nonatomic,copy)KGImageClick MClick;
@property (nonatomic,assign)NSInteger MRows;

@end

@implementation KGHotView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _MIConH  = 97;
        _MIConW  = (ScreenWidth -2 * HotViewMargin) * 0.25;

    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame iconClick:(KGImageClick)block
{
    if (self = [self initWithFrame:frame])
    {
        self.MClick = block;
    }
    return self;
}

-(void)setKGHeadData:(HeadData *)KGHeadData
{
    if (KGHeadData.icons.count)
    {
        if (KGHeadData.icons.count %4!=0 )
        {
            self.MRows = KGHeadData.icons.count/4 +1;
        }
        else
        {
            self.MRows = KGHeadData.icons.count/4;
        }
        CGFloat iconX = 0;
        CGFloat iconY = 0;
        for (int i = 0; i<KGHeadData.icons.count; i++)
        {
            iconX =(CGFloat)(i %4)* _MIConW + HotViewMargin;
            iconY = _MIConW * (CGFloat)(i/4);
            KGIconImageTextView * icon = [[KGIconImageTextView alloc]initWithFrame:CGRectMake(iconX, iconY, _MIConW, _MIConH) withPlaceholderImage:[UIImage imageNamed:@"icon_icons_holder"]];
            icon.tag = i;
            icon.KGActivity = KGHeadData.icons[i];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick:)];
            [icon addGestureRecognizer:tap];
            [self addSubview:icon];
            
        }
    }
}

-(void)setMRows:(NSInteger)MRows
{
    self.bounds = CGRectMake(0, 0, ScreenWidth, _MIConH * (CGFloat)MRows);
}
-(void)iconClick:(UIGestureRecognizer *)tap
{
    if (_MClick)
    {
        _MClick(tap.view.tag);
    }
}
@end
