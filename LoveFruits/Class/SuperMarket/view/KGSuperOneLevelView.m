//
//  KGSuperOneLevelView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSuperOneLevelView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "KGOnLevelButton.h"
#import "KGClassificationModel.h"
@interface KGSuperOneLevelView()
@property (nonatomic,retain)UIScrollView   *  MVScrollView;
@property (nonatomic,weak) KGOnLevelButton *  MVSelectbutton ;
@property (nonatomic,retain)UILabel        *  MVTopLine;
@property (nonatomic,retain)UILabel        *  MVDownLine;
@property (nonatomic,retain)UIButton       *  MVLeftButton;
@property (nonatomic,retain)UIButton       *  MVRightButton;
@end
@implementation KGSuperOneLevelView
@synthesize MVScrollView     = _MVScrollView;
@synthesize KGViewDelegate   = _KGViewDelegate;
@synthesize KGSourceDelegate = _KGSourceDelegate;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self createLineView];
        [self createDirectButton];
        [self createScrollView];
    }
    return self;
}
-(void)reloadData
{
    
    
    for(UIView *view in [_MVScrollView subviews])
    {
        [view removeFromSuperview];
    }
    
    if (self.KGSourceDelegate )
    {
        NSArray<KGClassificationModel *> * arr =[self.KGSourceDelegate getClassModel];
        float bw = 0;
        
        for (int i = 0; i< arr.count; i++)
        {
            KGClassificationModel * model = arr[i];
            KGOnLevelButton * button = [[KGOnLevelButton alloc]init];
            [button setTitle:model.name forState:UIControlStateNormal];
            [button.titleLabel sizeToFit];
            
            button.frame = CGRectMake(bw, 0, button.titleLabel.v_width +25, self.MVScrollView.v_height);
            bw = bw +button.titleLabel.v_width +25;
            button.tag = i;
            button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
           
            [button setTitleColor:[UIColor colorWithHexString:@"#585858"] forState:UIControlStateNormal];
             [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
              [button setKVModel:model];
             [self.MVScrollView addSubview:button];
            if (i == 0)
            {
//                [button setTitleColor:[UIColor colorWithHexString:@"#ffb002"] forState:UIControlStateNormal];
                [button  sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
          
            
           
           
        }
        
        
        _MVScrollView.contentSize = CGSizeMake(bw, _MVScrollView.v_height);
        
        [_MVSelectbutton setSelected:YES];
        [self resetViews];
    }
    
}
-(void)resetViews
{
    _MVTopLine.frame  = CGRectMake(0, 0, self.v_width, 0.5);
    _MVDownLine.frame =CGRectMake(0, self.v_height-0.5, self.v_width, 0.5);
    _MVLeftButton.frame =  CGRectMake(10, (self.v_height-30)/2, 15, 30);
    _MVRightButton.frame =  CGRectMake(self.v_width- 25, (self.v_height-30)/2, 15, 30);
//    _MVLeftButton.backgroundColor = [UIColor redColor];
}
-(void)btnClick:(KGOnLevelButton *)button
{
    if (_MVSelectbutton == nil)
    {
        _MVSelectbutton = button;
         [_MVSelectbutton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
      
//        _MVSelectbutton.titleLabel.highlighted = YES;
    }
    else
    {
        [_MVSelectbutton setTitleColor:[UIColor colorWithHexString:@"#585858"] forState:UIControlStateNormal];
        _MVSelectbutton = button;
        [button setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
    }
    
    if (self.KGViewDelegate && [self.KGViewDelegate respondsToSelector:@selector(pSelectedOperation:)])
    {
        [self.KGViewDelegate pSelectedOperation:_MVSelectbutton.KVModel.cid];
    }
}
-(void)createLineView
{
    _MVTopLine = [[UILabel alloc]init];
    _MVTopLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [self addSubview:_MVTopLine];
    
    _MVDownLine = [[UILabel alloc]init];
    _MVDownLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [self addSubview:_MVDownLine];
    
}
-(void)createDirectButton
{
    if (_MVLeftButton == nil)
    {
        _MVLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVLeftButton setImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
        [_MVLeftButton setImage:[UIImage imageNamed:@"left_press"] forState:UIControlStateHighlighted];
        [_MVLeftButton addTarget:self action:@selector(leftBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_MVLeftButton];
        
    }
    
    if (_MVRightButton == nil)
    {
        _MVRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVRightButton setImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
        [_MVRightButton setImage:[UIImage imageNamed:@"right_press"] forState:UIControlStateHighlighted];
        [_MVRightButton addTarget:self action:@selector(rightBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_MVRightButton];
        
    }
}
-(void)leftBtnCallback
{
    CGPoint offset = _MVScrollView.contentOffset;
    if (offset.x> (_MVScrollView.contentSize.width- _MVScrollView.v_width)) {
        return;
    }
    [_MVScrollView setContentOffset:CGPointMake(offset.x+50,offset.y) animated:YES];
    
}
-(void)rightBtnCallback
{
    CGPoint offset = _MVScrollView.contentOffset;
    if (offset.x>0)
    {
         [_MVScrollView setContentOffset:CGPointMake(offset.x-50,offset.y) animated:YES];
    }
   
}
-(void)createScrollView
{
    if (_MVScrollView == nil)
    {
        _MVScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 0.5, ScreenWidth-60, self.v_height-1)];
         _MVScrollView.showsVerticalScrollIndicator = false;
        _MVScrollView.showsHorizontalScrollIndicator = false;
         [self addSubview:_MVScrollView ];
    }
}
@end
