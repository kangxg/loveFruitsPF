//
//  KGHomeTableHeadView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeTableHeadView.h"
#import "GlobelDefine.h"
#import "KGPageScrollView.h"
#import "KGHotView.h"
#import "KGHomeHeadResources.h"
@interface KGHomeTableHeadView()
@property (nonatomic,retain)KGPageScrollView * MPageScrollView;
@property (nonatomic,retain)KGHotView        * MHotView;
@property (nonatomic,retain)UIImageView     *  MBackImageView;
@end

@implementation KGHomeTableHeadView
@synthesize KGTableHeadViewHeight = _KGTableHeadViewHeight;
-(void)setKGTableHeadViewHeight:(CGFloat)KGTableHeadViewHeight
{
    _KGTableHeadViewHeight = KGTableHeadViewHeight;
    [[NSNotificationCenter defaultCenter] postNotificationName:HomeTableHeadViewHeightDidChange object:[NSNumber numberWithFloat:KGTableHeadViewHeight]];
    self.frame = CGRectMake(0, -KGTableHeadViewHeight, ScreenWidth,KGTableHeadViewHeight);
}

-(void)setKGHeadData:(KGHomeHeadResources *)KGHeadData
{
    if (KGHeadData)
    {
        _MPageScrollView.KGHeadData = KGHeadData.data;
        _MHotView.KGHeadData = KGHeadData.data;
    }
}

-(void)resetHotViews:(HeadData *)data
{
    if (data)
    {
         _MHotView.KGHeadData = data;
    }
}
-(void)resetPageViews:(HeadData *)data
{
    if (data)
    {
        _MPageScrollView.KGHeadData = data;
    }
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//       self.backgroundColor = [UIColor greenColor];
        _KGTableHeadViewHeight = 0;
        [self addSubview:self.MBackImageView];
        [self buildPageScrollView];
        [self buildHotView];
        self.KGTableHeadViewHeight =CGRectGetMaxY(_MHotView.frame);
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    assert(@"init(coder:) has not been implemented");
    return [super initWithCoder:aDecoder];
}

-(UIImageView *)MBackImageView
{
    if (_MBackImageView == nil)
    {
        _MBackImageView = [[UIImageView alloc]init];
        
        _MBackImageView.image = [UIImage imageNamed:@"v2_placeholder_full_size"];
        _MBackImageView.frame = CGRectMake(0, 0, ScreenWidth, 125);
        _MBackImageView.backgroundColor = [UIColor redColor];
        
    }
    return _MBackImageView;
}
- (void) buildPageScrollView
{
   
    if (_MPageScrollView == nil)
    {
         __weak KGHomeTableHeadView * tmpSelf = self;
        _MPageScrollView = [[KGPageScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,125) withPlaceholder:[UIImage imageNamed:@"v2_placeholder_full_size"] withBlock:^(NSInteger index) {
            if ( tmpSelf.KGDelegate && [tmpSelf.KGDelegate respondsToSelector:@selector(tableHeadView:focusImageViewClick:)])
            {
                [tmpSelf.KGDelegate tableHeadView:tmpSelf focusImageViewClick:index];
            }
        }];
  
        [self addSubview:_MPageScrollView];
    }
}

-(void) buildHotView
{
    if (_MHotView == nil)
    {
         __weak KGHomeTableHeadView * tmpSelf = self;
        _MHotView = [[KGHotView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_MPageScrollView.frame), ScreenWidth, 97) iconClick:^(NSInteger index) {
            if ( tmpSelf.KGDelegate && [tmpSelf.KGDelegate respondsToSelector:@selector(tableHeadView:iconClick:)])
            {
                [tmpSelf.KGDelegate tableHeadView:tmpSelf iconClick:index];
            }
        }];
        
        _MHotView.backgroundColor= [UIColor whiteColor];
        [self addSubview:_MHotView];
    }
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    _MBackImageView.frame = CGRectMake(0, 0, ScreenWidth, 125);
//    if (_MPageScrollView)
//    {
//        _MPageScrollView.frame = CGRectMake(0, 0, ScreenWidth,125);
//      
//    }
//    if (_MHotView )
//    {
//        CGRect frame = _MHotView.frame;
//        frame.origin = CGPointMake(0, CGRectGetMaxY(_MPageScrollView.frame));
//        _MHotView.frame  = frame;
//
//    }
//    
//    self.KGTableHeadViewHeight = CGRectGetMaxY(_MHotView.frame);
//}
@end
