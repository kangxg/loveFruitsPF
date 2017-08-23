//
//  KGPageScrollView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPageScrollView.h"
#import "KGHomeHeadResources.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@interface KGPageScrollView()<UIScrollViewDelegate>
@property (nonatomic,assign)NSInteger          MImageViewMaxCount;
@property (nonatomic,retain)NSTimer         *  MTimer;
@property (nonatomic,retain)UIScrollView    *  MImageScrollView;
@property (nonatomic,retain)UIImage         *  MPlaceholderImage;
@property (nonatomic,retain)UIPageControl   *  MPageControl;
@property (nonatomic,copy)KGImageClick         MImageClick;


@end

@implementation KGPageScrollView
-(void)setKGHeadData:(HeadData *)KGHeadData
{
    if (KGHeadData)
    {
        _KGHeadData = KGHeadData;
        if (_MTimer)
        {
            [_MTimer invalidate];
            _MTimer = nil;
        }
        if (_KGHeadData.focus)
        {
            _MImageViewMaxCount =_KGHeadData.focus.count;
            
            
           
            [self buildImageScrollView];
            [self buildPageControl];
             _MPageControl.currentPage   = 0;
            _MPageControl.numberOfPages =  _MImageViewMaxCount;
            [self updatePageScrollView];
            [self startTimer];
         
        }
    }
}
//-(id)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame])
//    {
//       
//    }
//    return self;
//}

-(id)initWithFrame:(CGRect)frame  withPlaceholder:(UIImage *)placeholder withBlock:(KGImageClick)block
{
    if (self = [self initWithFrame:frame])
    {
        _MImageViewMaxCount = 0;
         _MPlaceholderImage = placeholder;
        _MImageClick       = block;
     
//        [self addSubview:self.MBackImageView];
        
        
       
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    _MImageScrollView.frame = self.bounds;
 

    
    _MImageScrollView.contentSize = CGSizeMake((CGFloat)_MImageViewMaxCount * self.v_width, self.v_height);
    
    for (int i = 0; i <_MImageViewMaxCount; i++)
    {
        
        UIImageView * imageview = _MImageScrollView.subviews[i];
        imageview.userInteractionEnabled  = true;
        imageview.frame = CGRectMake((CGFloat)i * _MImageScrollView.v_width, 0, _MImageScrollView.v_width, _MImageScrollView.v_height);
    }
    CGFloat pageW = 20*_MImageViewMaxCount;
    CGFloat pageH = 20;
    CGFloat pageX = _MImageScrollView.v_width  -  pageW;
    CGFloat pageY = _MImageScrollView.v_height -  pageH;
    _MPageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
//    _MPageControl.backgroundColor = [UIColor redColor];
//    [self updatePageScrollView];
}
-(void)buildImageScrollView
{
    if (_MImageScrollView  == nil)
    {
        _MImageScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _MImageScrollView.bounces  = false;
        _MImageScrollView.showsHorizontalScrollIndicator = false;
        _MImageScrollView.showsVerticalScrollIndicator   = false;
        _MImageScrollView.pagingEnabled                  = true;
        _MImageScrollView.delegate                       = self;
        [self addSubview:_MImageScrollView];
    
    
        for (int i = 0; i<_MImageViewMaxCount; i++)
        {
            UIImageView * imageview = [[UIImageView alloc]init];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
            imageview.userInteractionEnabled  = YES;
            [imageview addGestureRecognizer:tap];
            [_MImageScrollView addSubview:imageview];
        }
      
//        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 60)];
//        btn.backgroundColor= [UIColor redColor];
//        [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
        
    }
}

-(void)test
{
    
}
-(void)buildPageControl
{
    if (_MPageControl == nil)
    {
        _MPageControl = [[UIPageControl alloc]init];
        _MPageControl.hidesForSinglePage = true;
        _MPageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_normal"]];
        _MPageControl.currentPageIndicatorTintColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_selected"]];
        [self addSubview:_MPageControl];
    }
    

  
}
-(void)updatePageScrollView
{
 
    for (int i = 0; i <_MImageScrollView.subviews.count; i++)
    {
        UIImageView * imageView = _MImageScrollView.subviews[i];
        NSInteger index = _MPageControl.currentPage;
   
        if (i == 0)
        {
            index --;
            
        }
        else if ( i == 2)
        {
            index ++;
        }
        
        if (index<0)
        {
            index = _MPageControl.numberOfPages -1;
        }
        else if (index >= _MPageControl.numberOfPages )
        {
            index = 0;
        }
        imageView.tag  = index;
   

        if (_KGHeadData.focus.count)
        {
            Activities * act =_KGHeadData.focus[index];
            NSString * string = act.img;
//            imageView.image = [UIImage imageNamed:string];
            [imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:_MPlaceholderImage];
        }
        
    }

    _MImageScrollView.contentOffset = CGPointMake(_MImageScrollView.v_width, 0);
}
-(void)startTimer
{
    _MTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:_MTimer forMode:NSRunLoopCommonModes];
    
}
-(void)stopTimer
{
    if (_MTimer)
    {
        [_MTimer invalidate];
        _MTimer = nil;
    }

}
-(void)next
{
    [_MImageScrollView setContentOffset:CGPointMake(2.0 * _MImageScrollView.frame.size.width, 0) animated:YES];
}
-(void)imageViewClick:(UITapGestureRecognizer *)tap
{
    if (_MImageClick)
    {
        _MImageClick(tap.view.tag);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = 0;
   
    CGFloat  minDistance = MAXFLOAT;
    for (int i = 0; i<_MImageScrollView.subviews.count; i++)
    {
        UIImageView * imageview =(UIImageView *) _MImageScrollView.subviews[i];
    
        CGFloat distance = fabs(imageview.v_x - scrollView.contentOffset.x);
        if (distance <minDistance)
        {
            minDistance = distance;
            page = imageview.tag;
      
        }
       
    }
    _MPageControl.currentPage = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   [self updatePageScrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePageScrollView];
}
@end
