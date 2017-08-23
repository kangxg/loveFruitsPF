//
//  KGNullDataView.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGNullDataView.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
@interface KGNullDataView()

@property(strong,nonatomic)UIView * backView;


@end
@implementation KGNullDataView
+(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName Click:(BOOL)click
{
    KGNullDataView * nv=[[KGNullDataView alloc]init];
    nv.frame=frame;
    [nv createWithSuperView:superView frame:frame imageName:imageName Click:click];
    
    
    return nv;
    
}

-(void)createWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName Click:(BOOL)click
{
    
    
    [superView addSubview:self];
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview: self.backView];
    
    
    UIImage * image = [UIImage imageNamed:imageName];
    
    self.nvllDataImage=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-image.size.width/2, 54, image.size.width, image.size.height)];
    self.nvllDataImage.image=image;
    [ self.backView addSubview:self.nvllDataImage];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame= CGRectMake(0, self.nvllDataImage.v_bottom+54,ScreenWidth , 15);
    _contentLabel.font = [UIFont systemFontOfSize:17.0f];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#999999"];
     _contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment=NSTextAlignmentCenter;
    [ self.backView addSubview:self.contentLabel];
    
    
    if (click) {
        self.nvllDataImage.userInteractionEnabled=YES;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
        [self.nvllDataImage addGestureRecognizer:tap];
    }
    
    
    
}

-(void)clickView
{
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

-(void)setShowContent:(NSString *)content
{
    self.contentLabel.text=content;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
