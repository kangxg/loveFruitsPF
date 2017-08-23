//
//  KGNoLogView.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGNoLogView.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
@interface  KGNoLogView()

@property(strong,nonatomic)UIView * backView;

@property (nonatomic,copy)KGCallbackBlock  MVBlock;
@end
@implementation KGNoLogView

@synthesize  MVBlock      = _MVBlock;
+(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block
{
    if (imageName == nil)
    {
        imageName = @"Load_Fail";
    }
    KGNoLogView * nv=[[KGNoLogView alloc]init];
    nv.frame=frame;
    [nv createWithSuperView:superView frame:frame imageName:imageName WithBlock:block];
    
    
    return nv;
    
}

-(void)createWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block{
    
    
    [superView addSubview:self];
    _MVBlock = block;
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview: self.backView];
    
    
    UIImage * image = [UIImage imageNamed:imageName];
    
    self.nvllDataImage=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-image.size.width/2, 155, image.size.width, image.size.height)];
    self.nvllDataImage.image=image;
    [ self.backView addSubview:self.nvllDataImage];
    
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame= CGRectMake(0, self.nvllDataImage.v_bottom+25,ScreenWidth , 15);
    _contentLabel.font = [UIFont systemFontOfSize:17.0f];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _contentLabel.text = @"您还没有登录账号";
    self.contentLabel.textAlignment=NSTextAlignmentCenter;
    [ self.backView addSubview:self.contentLabel];
    
    

    _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logButton.frame= CGRectMake((self.v_width -92.5)/2, _contentLabel.v_bottom+10, 92.5, 28);
    _logButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _logButton.backgroundColor = [UIColor colorWithHexString:@"#2ad580"];
    [_logButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logButton setTitle:@"登录" forState:UIControlStateNormal];
    _logButton.layer.masksToBounds = YES;
    _logButton.layer.cornerRadius  = 5.0f;
    [_logButton addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_logButton];
    
    
}

-(void)clickView
{
    if (_MVBlock)
    {
        _MVBlock(self);
    }
    //    [self.delegate loadAgainPlease];
    
}
-(void)dissmissMyself
{
    
    if (self.backView) {
        [self.backView removeFromSuperview];
        [self.nvllDataImage removeFromSuperview];
        [self.contentLabel removeFromSuperview];
        [self removeFromSuperview];
    }
    
    
    
    
    
}
-(void)setShowContent:(NSString * )content
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
