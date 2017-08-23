//
//  KGAdressTitleView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAdressTitleView.h"
#import "UIView+Extension.h"
#import "KGUserInfo.h"
#import "KGAdressData.h"
#import "GlobelDefine.h"
#import "KGTheme.h"
@interface KGAdressTitleView()
@property(nonatomic,retain)UILabel * MPlayLabel;
@property(nonatomic,retain)UILabel * MTitleLabel;
@property(nonatomic,retain)UIImageView  * MArrowImageView;

@end

@implementation KGAdressTitleView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.MPlayLabel];
        [self addSubview:self.MTitleLabel];
        [self addSubview:self.MArrowImageView];
    }
    return self;
}
-(UILabel *)MPlayLabel
{
    if (_MPlayLabel == nil)
    {
       _MPlayLabel = [[UILabel alloc]init];
       _MPlayLabel.text = @"配送至";
        _MPlayLabel.textColor = [UIColor blackColor];
        _MPlayLabel.layer.borderColor =[UIColor blackColor].CGColor;
        _MPlayLabel.layer.borderWidth = 0.5;
        _MPlayLabel.font = [UIFont systemFontOfSize:10.0f];
        [_MPlayLabel sizeToFit];
        _MPlayLabel.textAlignment = NSTextAlignmentCenter;
        _MPlayLabel.frame = CGRectMake(0, (self.v_height - _MPlayLabel.v_height - 2) * 0.5, _MPlayLabel.frame.size.width + 6, _MPlayLabel.frame.size.height + 2);
        
    }
    return _MPlayLabel;
}

-(UILabel *)MTitleLabel
{
    if (_MTitleLabel == nil)
    {
         _MTitleLabel =   [[UILabel alloc]init];
         _MTitleLabel.textColor = [UIColor blackColor];
         _MTitleLabel.font = [UIFont systemFontOfSize:15.0f];
       Address * adress = [KGUserInfo sharedUserInfo].defaultAdress;
        if (adress.address)
        {
            if (adress.address.length)
            {
                NSString * adressStr = adress.address;
                if ([adressStr componentsSeparatedByString:@" "].count>1)
                {
                    _MTitleLabel .text = [adressStr componentsSeparatedByString:@" "][0];
                    
                }
                else
                {
                    _MTitleLabel.text = adressStr;
                }
            }
            else
            {
                _MTitleLabel.text = @"你在哪里呀";
            }
        }
        else
        {
            _MTitleLabel.text = @"你在哪里呀";

        }
        
        [_MTitleLabel sizeToFit];
        _MTitleLabel.frame = CGRectMake(CGRectGetMaxX(_MPlayLabel.frame) + 4, 0, _MTitleLabel.v_width, self.v_height);

     }
  
    return _MTitleLabel;
}

-(UIImageView *)MArrowImageView
{
    if (_MArrowImageView == nil)
    {
        _MArrowImageView = [[UIImageView alloc]init];
        _MArrowImageView.image = [UIImage imageNamed:@"allowBlack"];
        _MArrowImageView.frame = CGRectMake(CGRectGetMaxX(_MTitleLabel.frame) + 4, (self.frame.size.height - 6) * 0.5, 10, 6);
        _KGAdressWidth = CGRectGetMaxX(_MArrowImageView.frame);

    }
    return _MArrowImageView;
}
-(void)setTitle:(NSString *)text
{
    NSString * adressStr = text;
    if ([adressStr componentsSeparatedByString:@" "].count>1)
    {
        _MTitleLabel .text = [adressStr componentsSeparatedByString:@" "][0];
        
    }
    else
    {
        _MTitleLabel.text = adressStr;
    }
    [_MTitleLabel sizeToFit];
    _MTitleLabel.frame = CGRectMake(CGRectGetMaxX(_MPlayLabel.frame) + 4, 0, _MTitleLabel.v_width, self.v_height);
     _MArrowImageView.frame = CGRectMake(CGRectGetMaxX(_MTitleLabel.frame) + 4, (self.frame.size.height - _MArrowImageView.v_height)*0.5, _MArrowImageView.v_width, _MArrowImageView.v_height);
     _KGAdressWidth = CGRectGetMaxX(_MArrowImageView.frame);
}
@end


@interface KGSelectBuyView()

@end
@implementation KGSelectBuyView : UIView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _YMSelectWith = self.v_width;
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.v_width, self.v_height)];
        topView.backgroundColor=[UIColor redColor];
        [self addSubview:topView];
        
//        //输入框和背景
//        UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(14,20+7, kScreenWith-14-22.5-14-14,kDHeight-34)];
//        backView.layer.masksToBounds=YES;
//        backView.layer.cornerRadius=5.0f;
//        backView.backgroundColor=[UIColor whiteColor];
//        //    backView.alpha=0.85;
//        [topView addSubview:backView];

    }
    return self;
}
@end
