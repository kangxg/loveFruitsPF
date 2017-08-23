//
//  KGAnimationView.m
//  LoveFruits
//
//  Created by kangxg on 2017/1/9.
//  Copyright © 2017年 kangxg. All rights reserved.
//

#import "KGAnimationView.h"
#import "UIView+Extension.h"
@interface KGAnimationView ()
{
    CGFloat angle;
    
}

@property (strong, nonatomic) UIImageView * MVImageView;

@end
@implementation KGAnimationView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createView];
    }
    
    return self;
}

-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(200, 160, 80, 80);
    imageView.image = [UIImage imageNamed:@"loading"];
    imageView.centerX = self.centerX;
    imageView.centerY = self.centerY - 60;
    [self addSubview:imageView];
    _MVImageView = imageView;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    basicAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.beginTime = CACurrentMediaTime();
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.duration = 3.0;
    [imageView.layer addAnimation:basicAnimation forKey:@"imageViewRotation"];
    
    
    //[self transformRotationAnimation];
    
    
 
}


- (void)transformRotationAnimation {
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0));
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _MVImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 5;
        [self transformRotationAnimation];
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
