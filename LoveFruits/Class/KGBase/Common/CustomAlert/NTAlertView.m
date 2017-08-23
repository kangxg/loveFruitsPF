//
//  NTBaseAlertView.m
//  test
//
//  Created by kangxiaoguang on 14/11/3.
//  Copyright (c) 2014年 kangxiaoguang. All rights reserved.
//

#import "NTAlertView.h"

#pragma mark
#pragma mark----------- 虚基类 NTAlertView-------
@interface NTAlertView ()
{
  
}

@end
@implementation NTAlertView
@synthesize NTALertCancelButton = m_CancelBt;
@synthesize NTALertEnterButton = m_EnterBt;
@synthesize NTAlertBodyMessage = m_bodyMessage;
@synthesize NTAlertImageView   = m_ImageView;
@synthesize NTALertTitle       = m_title ;
@synthesize NTAlertBodyView    = m_BodyView;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(id)createAlertView:(NTAlertViewStyle)Type
{
    return [[self alloc]initAlertView:Type];
}

+(id)createAlertView
{
    return [[self alloc]initAlertView:EN_NTAlertViewStyleNone];
}

-(id)initAlertView:(NTAlertViewStyle)Type
{
    if (self=[super init])
    {
        m_style = Type;
        [self initData];
        [self initView];
    }
    return self;
}
-(void)initData
{
    
}
-(void)initView
{

}
-(void)ShowView
{
    
}

-(void)createBodyView
{
    m_BodyView    = nil;
}

-(void)createbodyImageView
{
      m_ImageView   = nil;
}
-(void)createButton
{
    m_CancelBt     = nil;
    m_EnterBt     = nil;
}

-(void)createLable
{
    m_bodyMessage = nil;
    m_title       = nil;
    m_titleline   = nil;
}

-(void)createTitleView
{
    
}
-(void)createBodyMessageView
{
    
}

-(void)removeView{
    [self removeFromSuperview];
}
@end
/////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark----------- 基本类父类 NTBaseAlertView-------
/////////////////////////////////////////////////////////////////////////////
@implementation NTBaseAlertView

-(void)initData
{
    [super initData];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
    
}
-(void)initView
{
    [super initView];
    [self createBodyView];
    [self createbodyImageView];
    [self createButton];
    [self createLable];
  
}

-(void)createBodyView
{
    m_BodyView = [[UIView alloc]init];
    m_BodyView.backgroundColor = [UIColor whiteColor];
    if (m_style&EN_NTAlertViewStyleCorner)
    {
               [m_BodyView.layer setCornerRadius:6.0f];
    }
    if (m_style&EN_NTAlertViewStyleBorder)
    {
        [m_BodyView.layer setBorderColor:[UIColor redColor].CGColor];
        [m_BodyView.layer setBorderWidth:1.0f];

    }
    [self addSubview:m_BodyView];
}


-(void)createButton
{
    m_EnterBt = [UIButton buttonWithType:UIButtonTypeCustom];
    m_EnterBt.backgroundColor =[UIColor blackColor];
    [m_EnterBt addTarget:self action:@selector(CallbackFromEnterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    m_CancelBt= [UIButton buttonWithType:UIButtonTypeCustom];
    
    m_CancelBt.backgroundColor =[UIColor blackColor];
    [ m_CancelBt addTarget:self action:@selector(CallbackFromCannalButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [m_EnterBt setTitle:@"确定" forState:UIControlStateNormal];
    [m_CancelBt setTitle:@"取消" forState:UIControlStateNormal];
    m_EnterBt.tag = 0;
    m_CancelBt.tag = 1;
    [m_BodyView addSubview:m_EnterBt];
    [m_BodyView addSubview: m_CancelBt];
}

-(void)createLable
{
    [self createTitleView];
    [self createBodyMessageView];
    
}
-(void)createTitleView
{
    m_title = [[UILabel alloc]init];
    m_title.backgroundColor = [UIColor clearColor];
    m_title.textAlignment = NSTextAlignmentCenter;
    [m_BodyView addSubview:m_title];
    if (m_style&EN_NTAlertViewStyleTitleLine)
    {
        m_titleline = [[UILabel alloc]init];
        [m_BodyView addSubview:m_titleline];
    }

}

-(void)createBodyMessageView
{
    m_bodyMessage = [[UILabel alloc]init];
    m_bodyMessage.backgroundColor = [UIColor clearColor];
    [m_BodyView addSubview:m_bodyMessage];

}

-(void)createbodyImageView
{
    if (m_style&EN_NTAlertViewStyleBackGroundImage)
    {
        m_ImageView = [[UIImageView alloc]init];
        m_ImageView.frame = CGRectMake(0, 0, m_BodyView.frame.size.width, m_BodyView.frame.size.height);
        [m_BodyView addSubview:m_ImageView];
    }
}
-(void)CallbackFromEnterButton:(UIButton *)sender
{
    //NSLog(@"警告确定");
    if (self.NTAlertDelegate && [self.NTAlertDelegate respondsToSelector:@selector(NTAlertViewCallBack:)])
    {
        UIButton * bt = sender;
        [self.NTAlertDelegate NTAlertViewCallBack:bt.tag];
    }
     [self removeView];
}

-(void)CallbackFromCannalButton:(UIButton *)sender
{
    //NSLog(@"警告取消");
    if (self.NTAlertDelegate && [self.NTAlertDelegate respondsToSelector:@selector(NTAlertViewCallBack:)])
    {
        UIButton * bt = sender;
        [self.NTAlertDelegate NTAlertViewCallBack:bt.tag];
    }
    [self removeView];

}

-(void)removeView
{
    [self removeFromSuperview];
}
-(void)ShowView
{
   // UIApplication *lpApplication=[UIApplication sharedApplication];
    UIWindow *lpWindow=[[UIApplication sharedApplication]keyWindow];
    [lpWindow addSubview:self];

    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    [m_BodyView.layer addAnimation:animation forKey:nil];
    
}

//-(void)dealloc
//{
////    [m_title release];
////    [m_bodyMessage release];
////    [m_CancelBt release];
////    [m_EnterBt release];
////    [m_BodyView release];
////    [m_BodyView release];
//    [super dealloc];
//}
@end

#pragma mark
#pragma mark----------- 小视图 NTSmallAlertView ---------
@implementation  NTSmallAlertView

-(void)initView
{
    [super initView];
    float heiht = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    float lenght = width* 0.5;
    m_BodyView.frame = CGRectMake(lenght/2, heiht*0.35, lenght ,100);
    
    m_EnterBt.frame = CGRectMake(10, 70, lenght * 0.4, 20);
    m_CancelBt.frame = CGRectMake(10+m_EnterBt.frame.origin.x+ m_EnterBt.frame.size.width, 70, lenght *0.4, 20);
    
    m_EnterBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    m_CancelBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    m_title.frame = CGRectMake(10, 5, lenght-20, 20);
    m_bodyMessage.frame = CGRectMake(10, 30, lenght-20, 20);
  
    m_bodyMessage.textColor = m_title.textColor = [UIColor blackColor];
    m_title.font = [UIFont boldSystemFontOfSize:14];
    m_bodyMessage.font = [UIFont boldSystemFontOfSize:13];
    
    if (m_titleline&&m_style&EN_NTAlertViewStyleTitleLine)
    {
        m_titleline.frame = CGRectMake(0, 24, lenght, 1);
        m_titleline.backgroundColor = [UIColor redColor];
        
    }
    
//    m_title.text = @"title";
//    m_bodyMessage.text = @"message";
}


@end

#pragma mark
#pragma mark----------- 大视图 NTBigAlertView -----------
@implementation NTBigAlertView


-(void)initView
{
    [super initView];
    float heiht = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    float lenght = width* 0.7;
    m_BodyView.frame = CGRectMake(width/2 -lenght/2, heiht *0.35, lenght ,150);
    
    m_EnterBt.frame = CGRectMake(10, 150-30-10 ,lenght * 0.4, 30);
    m_CancelBt.frame = CGRectMake(lenght-10-lenght*0.4, 150-30-10, lenght *0.4, 30);
    
    m_EnterBt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    m_CancelBt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    m_title.frame = CGRectMake(10, 5, lenght-20, 20);
    m_bodyMessage.lineBreakMode =NSLineBreakByWordWrapping;
    m_bodyMessage.numberOfLines = 0;

    m_bodyMessage.frame = CGRectMake(10, 26, lenght-20, 150-25-30-10);
   
   
    m_bodyMessage.textColor = m_title.textColor = [UIColor blackColor];
    

    m_title.font = [UIFont boldSystemFontOfSize:16];
    m_bodyMessage.font = [UIFont boldSystemFontOfSize:15];
    if (m_titleline&&m_style&EN_NTAlertViewStyleTitleLine)
    {
        m_titleline.frame = CGRectMake(0, 24, lenght, 1);
        m_titleline.backgroundColor = [UIColor redColor];
        
    }
    
//    m_title.text = @"title";
//    m_bodyMessage.text = @"messagefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
}

@end

#pragma mark
#pragma mark----------- 自定义视图父类 NTCustomAlertView ----------
@interface NTCustomAlertView()

@end

@implementation NTCustomAlertView


-(void)initData
{
    [super initData];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
}

-(void)initView
{
    [super initView];
}

-(void)createBodyView
{
    m_BodyView = [[UIView alloc]init];
    m_BodyView.backgroundColor = [UIColor colorWithRed:0x24/255.f green:0x24/255.f blue:0x24/255.f alpha:1.0f];
    if (m_style&EN_NTAlertViewStyleCorner)
    {
        [m_BodyView.layer setCornerRadius:6.0f];
    }
    if (m_style&EN_NTAlertViewStyleBorder)
    {
        [m_BodyView.layer setBorderColor:[UIColor colorWithRed:0x44/255.f green:0x44/255.f blue:0x44/255.f alpha:1.0f].CGColor];
        [m_BodyView.layer setBorderWidth:1.0f];
        
    }
    [self addSubview:m_BodyView];
}

-(void)createButton
{
    m_EnterBt = [UIButton buttonWithType:UIButtonTypeCustom];
    //m_EnterBt.backgroundColor =[UIColor redColor];
    [m_EnterBt addTarget:self action:@selector(CallbackFromEnterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    m_CancelBt= [UIButton buttonWithType:UIButtonTypeCustom];
    
    //m_CancelBt.backgroundColor =[UIColor redColor];
    [ m_CancelBt addTarget:self action:@selector(CallbackFromCannalButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [m_EnterBt setTitle:@"确定" forState:UIControlStateNormal];
    [m_CancelBt setTitle:@"取消" forState:UIControlStateNormal];
    m_EnterBt.tag = 0;
    m_CancelBt.tag = 1;
    [m_BodyView addSubview:m_EnterBt];
    [m_BodyView addSubview: m_CancelBt];
}

-(void)createLable
{
    [super createLable];
    [self createTitleView];
    [self createBodyMessageView];
  
    
}

-(void)createTitleView
{
    m_title = [[UILabel alloc]init];
//    m_title.backgroundColor = [UIColor clearColor];
    m_title.textAlignment = NSTextAlignmentCenter;
    [m_BodyView addSubview:m_title];
    if (m_style&EN_NTAlertViewStyleTitleLine)
    {
        m_titleline = [[UILabel alloc]init];
        [m_BodyView addSubview:m_titleline];
    }

}

-(void)createBodyMessageView
{
    m_bodyMessage = [[UILabel alloc]init];
    m_bodyMessage.backgroundColor = [UIColor clearColor];
    if (m_style&EN_NTAlertViewStyleMessCenter)
    {
        m_bodyMessage.textAlignment = NSTextAlignmentCenter;
    }
    [m_BodyView addSubview:m_bodyMessage];
}
-(void)createbodyImageView
{
    if (m_style&EN_NTAlertViewStyleBackGroundImage)
    {
        m_ImageView = [[UIImageView alloc]init];
        m_ImageView.frame = CGRectMake(0, 0, m_BodyView.frame.size.width, m_BodyView.frame.size.height);
        [m_BodyView addSubview:m_ImageView];
    }
}
-(void)CallbackFromEnterButton:(UIButton *)sender
{
    //NSLog(@"警告确定");
    if (self.NTAlertDelegate && [self.NTAlertDelegate respondsToSelector:@selector(NTAlertViewCallBack:WithTag:)])
    {
        UIButton * bt = sender;
        [self.NTAlertDelegate NTAlertViewCallBack:self WithTag:bt.tag];
    }
    [self removeView];
}

-(void)CallbackFromCannalButton:(UIButton *)sender
{
    //NSLog(@"警告取消");
    if (self.NTAlertDelegate && [self.NTAlertDelegate respondsToSelector:@selector(NTAlertViewCallBack:WithTag:)])
    {
        UIButton * bt = sender;
        [self.NTAlertDelegate NTAlertViewCallBack:self WithTag:bt.tag];
    }
    [self removeView];
    
}

-(void)removeView
{
    [self removeFromSuperview];
}

-(void)ShowView
{
    UIApplication *lpApplication=[UIApplication sharedApplication];
    UIWindow *lpWindow= [lpApplication keyWindow];
    [lpWindow addSubview:self];
    
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    [m_BodyView.layer addAnimation:animation forKey:nil];
    
}


@end



