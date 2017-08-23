//
//  KGMoreMenuView.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMoreMenuView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGMoreMenuView()
@property (nonatomic,retain)NSMutableArray<NSString *> *  MVTitleArr;

@property (nonatomic,retain)UIButton                   *  MVButtonMore;
@property (nonatomic,weak)UIButton                     *  MVSelectedBtn;
@property (nonatomic,retain)UILabel         * MVLineView;
@end

@implementation KGMoreMenuView
-(instancetype)initWithFrame:(CGRect)frame withMenuTitle:(NSArray *)titleArr
{
    if (self = [super initWithFrame:frame])
    {
        if (titleArr) {
            _MVTitleArr = [[NSMutableArray alloc]initWithArray:titleArr];
            _MVSelectedBtn = nil;
            [self createView];
        }
        
    }
    return self;
}
-(void)changeView:(NSInteger )index
{
    
}

-(NSInteger )YVSelectIndex
{
    if (_MVSelectedBtn)
    {
        return _MVSelectedBtn.tag;
    }
    return -1;
}
-(void)createView
{
    if (_MVTitleArr.count<6)
    {
        float w = self.v_width/_MVTitleArr.count;
        for (int i = 0; i<_MVTitleArr.count; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_MVTitleArr[i] forState:UIControlStateNormal];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            
            btn.frame = CGRectMake(i* w, 0, w, self.v_height-2);
            
            [btn addTarget:self action:@selector(changeTopBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag  =i;
            if (i == 0)
            {
                _MVSelectedBtn = btn;
            }
            [self addSubview:btn];
            
           [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];

        }
        [self createMenuLineView];
        [self setSelectedView];
    }
}
-(void)createMenuLineView
{
    if (_MVLineView == nil)
    {
        
        _MVLineView=[[UILabel alloc]init];
        _MVLineView.backgroundColor= CommonlyUsedBtnColor;
               [self addSubview:self.MVLineView];
        _MVLineView.frame=  CGRectMake(10, self.v_height-2,self.v_width/_MVTitleArr.count-20, 2);

        
    }
    
}
-(void)changeTopBtn:(UIButton*)btn
{
    if (_MVSelectedBtn == btn)
    {
        return;
    }
    [_MVSelectedBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    _MVSelectedBtn = btn;

    
     [self setSelectedView];
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pSelectedView:)])
    {
        [self.KVDelegate pSelectedView:self];
    }
    
   

}

-(void)setSelectedView
{
      [_MVSelectedBtn setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
    
      [self setTopLineAction:_MVSelectedBtn.center.x];
}
-(void)setTopLineAction:(float)orginX
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.MVLineView.center = CGPointMake(orginX, self.MVLineView.center.y);
    } completion:^(BOOL finished)
     {
         CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
         CGPoint p1 = self.MVLineView.layer .position;
         
         CGMutablePathRef path  = CGPathCreateMutable();
         CGPathMoveToPoint(path, nil, p1.x, p1.y);
         
         CGPathAddCurveToPoint(path, nil, p1.x-10, p1.y, p1.x+20, p1.y, p1.x, p1.y);
         keyFrame.path = path;
         
         keyFrame.duration = 0.3;
         
         
         [self.MVLineView.layer addAnimation:keyFrame forKey:@"shake"];
         CFRelease(path);
     }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
