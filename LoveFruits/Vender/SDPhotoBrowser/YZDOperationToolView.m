//
//  YZDOperationToolView.m
//  YZJOB-2
//
//  Created by kangxg on 15/9/29.
//  Copyright (c) 2015年 lfh. All rights reserved.
//

#import "YZDOperationToolView.h"
#import "GlobelDefine.h"
#import "YZInsetsLabel.h"
@interface YZDOperationToolView()
{
    void (^ _mBlock)(NSInteger tag);
    NSArray  *  _mDataArr;
    NSString *  _mTitleString;
    UIView   *  _mBodyView;
}
@end

@implementation YZDOperationToolView
-(id)initWithTitle:(NSString *)title withBodyData:(NSArray *)arr withFrame:(CGRect)frame withBackBlock:(void (^)(NSInteger))block{
    //YZDOperationToolView * view = [self initWithFrame:frame];
    if (self = [self initWithFrame:frame])
    {
        _mTitleString = title;
        _mBlock = block;
        _mDataArr = [arr copy];
        [self initView];
    }
    return self;
}

-(void)initView
{
    UIButton * lab = [UIButton buttonWithType:UIButtonTypeCustom];
    lab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    lab.backgroundColor = [UIColor blackColor];
    lab.alpha =0.4f;
    [lab addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lab];
    float height = _mTitleString?40+44*_mDataArr.count +55:44*_mDataArr.count+55;
    _mBodyView  = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth,height)];
//    _mBodyView.layer.masksToBounds = YES;
//    _mBodyView.layer.cornerRadius  = 5f;
    //_mBodyView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_mBodyView];
    
    UIView * bodyTopView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, _mBodyView.frame.size.width-10,height-55)];
    bodyTopView.backgroundColor = [UIColor whiteColor];
    bodyTopView.layer.masksToBounds=YES;
    bodyTopView.layer.cornerRadius=5;
    bodyTopView.layer.borderWidth=0.5;
    bodyTopView.layer.borderColor= [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
   
    [_mBodyView addSubview:bodyTopView];
    float  titleHeight = 0;
    if (_mTitleString) {
        UILabel * titlelabe = [[YZInsetsLabel alloc]initWithFrame:CGRectMake(0, 0, _mBodyView.frame.size.width, 44) andInsets:UIEdgeInsetsMake(0, 14, 0, 0)];
        titlelabe.text = _mTitleString;
        titlelabe.font = [UIFont systemFontOfSize:18.0f];
        titlelabe.textColor = [UIColor colorWithHexString:@"#dcdcdc"];
        titlelabe.backgroundColor = [UIColor whiteColor];
        [bodyTopView addSubview:titlelabe];
        titleHeight = titlelabe.frame.size.height;
    }
 
    
    for (int i = 0; i<[_mDataArr count]; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
       btn.frame = CGRectMake(0,titleHeight+ 44* i, _mBodyView.frame.size.width, 44);
       
        [btn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        btn.titleLabel.font      = [UIFont systemFontOfSize:16.0f];
        [btn setTitle:[_mDataArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnCallback:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 0)];
        [bodyTopView addSubview:btn];
    }
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5 ,bodyTopView.frame.size.height+5, _mBodyView.frame.size.width-10, 44);
    [btn setTitleColor:[UIColor colorWithHexString:@"#535353"]forState:UIControlStateNormal];
    btn.titleLabel.font      = [UIFont systemFontOfSize:16.0f];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnCallback:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor whiteColor];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    btn.layer.borderWidth=0.5;
    btn.layer.borderColor=[[UIColor colorWithHexString:@"#d8d8d8"]CGColor];
    btn.tag = 0;
    
//btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 0)];
    [_mBodyView addSubview:btn];

    NSInteger count = _mTitleString?_mDataArr.count:_mDataArr.count-1;
    for (int i = 1; i<=count; i++)
    {
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 44*i-0.5, _mBodyView.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        [_mBodyView addSubview:line];
    }
}
-(void)btnCallback:(UIButton *)btn
{
    if (_mBlock) {
        _mBlock(btn.tag);
    }
    [self removeFromSuperview];
}

-(void)removeFromSuperview
{
   // self.alpha = 1.0f;

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    self.alpha =0.0f;
    _mBodyView.frame = CGRectMake(_mBodyView.frame.origin.x, ScreenHeight, _mBodyView.frame.size.width, _mBodyView.frame.size.height);
    [UIView setAnimationDuration:1.0f];
    
    [UIView commitAnimations];
    [super removeFromSuperview];
}
-(void)showInView:(UIView *)view
{
    self.alpha = 0.0f;
    [view addSubview:self];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    self.alpha =1.0f;
    _mBodyView.frame = CGRectMake(_mBodyView.frame.origin.x, ScreenHeight- _mBodyView.frame.size.height , _mBodyView.frame.size.width, _mBodyView.frame.size.height);
    [UIView setAnimationDuration:1.0f];
    
    [UIView commitAnimations];
    
//    CAKeyframeAnimation * animation;
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    animation.delegate = self;
//    animation.removedOnCompletion = YES;
//    animation.fillMode = kCAFillModeForwards;
//    
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    
//    animation.values = values;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    [_mBodyView.layer addAnimation:animation forKey:nil];

  
    
}

-(void)show
{
    UIApplication *lpApplication=[UIApplication sharedApplication];
    
    //拿到window
    UIWindow *window = [lpApplication keyWindow];
    [self showInView:window];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
