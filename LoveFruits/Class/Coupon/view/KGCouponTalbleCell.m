//
//  KGCouponTalbleCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCouponTalbleCell.h"
#import "KGCouponModel.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@implementation KGCouponTalbleCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor=LFBNavigationHomeSearchColor;
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}

-(void)createSubView
{
    [self createBackgroundView];
    [self createImageView];
    [self createUnitLabel];
    [self createCoinLabel];
    [self createNameLabel];
    [self createDateLabel];
    [self createLineLabel];
    [self createUseStateLabel];
    [self createRestrictionLabel];
}
-(void)createBackgroundView
{
    [self addSubview:self.MVBgView];
}
-(void)createImageView
{
    [self addSubview:self.MVLeftImage];
    [self addSubview:self.MVRightImage];
}
-(void)createCoinLabel
{
    [self addSubview:self.MVCoinLabel];
}
-(void)createNameLabel
{
    [self addSubview:self.MVNameLabel];
}
-(void)createUseStateLabel
{
    [self addSubview:self.MVUselabel];
}
-(void)createDateLabel
{
    [self addSubview:self.MVDateLabel];
}
-(void)createRestrictionLabel
{
    [self addSubview:self.MVRestrictionLabel];
}
-(void)createLineLabel
{
    [self addSubview:self.MVLineLabel];
}
-(void)createUnitLabel
{
    [self addSubview:self.MVUnitLabel];
}

-(UIView *)MVBgView
{
    if (_MVBgView == nil)
    {
        _MVBgView = [[UIView alloc]init];
        _MVBgView.backgroundColor = [UIColor whiteColor];
    }
    return _MVBgView;
}
-(UIImageView *)MVLeftImage
{
    if (_MVLeftImage == nil)
    {
        _MVLeftImage = [[UIImageView alloc]init];
    }
    return _MVLeftImage;
}

-(UIImageView *)MVRightImage
{
    if (_MVRightImage == nil)
    {
        _MVRightImage = [[UIImageView alloc]init];
    }
    return _MVRightImage;
}

-(UILabel *)MVCoinLabel
{
    if (_MVCoinLabel == nil)
    {
        _MVCoinLabel = [[UILabel alloc]init];
        _MVCoinLabel.font = [UIFont systemFontOfSize:20.0f];
        
    }
    return _MVCoinLabel;
}

-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel= [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:15.0f];
        
    }
    return _MVNameLabel;
}

-(UILabel *)MVRestrictionLabel
{
    if (_MVRestrictionLabel == nil)
    {
        _MVRestrictionLabel= [[UILabel alloc]init];
        _MVRestrictionLabel.font = [UIFont systemFontOfSize:12.0f];
        
    }
    return _MVRestrictionLabel;
}

-(UILabel *)MVDateLabel
{
    if (_MVDateLabel == nil)
    {
        _MVDateLabel= [[UILabel alloc]init];
        _MVDateLabel.font = [UIFont systemFontOfSize:12.0f];
        _MVDateLabel.adjustsFontSizeToFitWidth = YES;
        _MVDateLabel.minimumScaleFactor=0.5;
        
    }
    return _MVDateLabel;
}
-(UILabel *)MVUnitLabel
{
    if (_MVUnitLabel == nil)
    {
        _MVUnitLabel= [[UILabel alloc]init];
        _MVUnitLabel.font = [UIFont systemFontOfSize:14.0f];
        
    }
    return _MVUnitLabel;
}
-(UILabel *)MVUselabel
{
    if (_MVUselabel == nil)
    {
        _MVUselabel= [[UILabel alloc]init];
        _MVUselabel.font = [UIFont systemFontOfSize:15.0f];
        _MVUselabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _MVUselabel;
}
-(UILabel *)MVLineLabel
{
    if (_MVLineLabel == nil)
    {
        _MVLineLabel= [[UILabel alloc]init];
        _MVLineLabel.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        
        
    }
    return _MVLineLabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVBgView.frame    = CGRectMake(11, 0, ScreenWidth-22, self.v_height);
    _MVLeftImage.frame = CGRectMake(11, 0, 10, self.v_height);
    _MVUnitLabel.frame = CGRectMake(_MVLeftImage.v_right+14, 22, _MVUnitLabel.v_width, _MVUnitLabel.v_height);
    
    _MVCoinLabel.frame  =CGRectMake(_MVUnitLabel.v_right, 22, _MVCoinLabel.v_width, _MVCoinLabel.v_height);
    float dis = _MVCoinLabel.v_height - _MVUnitLabel.v_height-2;
    _MVUnitLabel.frame = CGRectMake(_MVUnitLabel.v_x,_MVCoinLabel.v_y +dis , _MVUnitLabel.v_width, _MVUnitLabel.v_height);
    _MVRestrictionLabel.frame = CGRectMake(_MVLeftImage.v_right+14, _MVCoinLabel.v_bottom+17, _MVRestrictionLabel.v_width, _MVRestrictionLabel.v_height);
    float nx = _MVCoinLabel.v_width>_MVRestrictionLabel.v_width?_MVCoinLabel.v_right:_MVRestrictionLabel.v_right;
    _MVNameLabel.frame = CGRectMake(nx+24, 20, self.v_width -nx-24-80-21-5, _MVNameLabel.v_height);
    _MVDateLabel.frame = CGRectMake(nx+24, _MVNameLabel.v_bottom+17, _MVNameLabel.v_width, _MVDateLabel.v_height);
    _MVLineLabel.frame = CGRectMake(self.v_width-11-10-79.5, 0, 0.5, self.v_height);
     _MVUselabel.frame = CGRectMake(_MVLineLabel.v_right, 0, 80, self.v_height);
    _MVRightImage.frame = CGRectMake(self.v_width-21, 0, 10, self.v_height);
    _MVDateLabel.center = CGPointMake(_MVDateLabel.center.x, _MVRestrictionLabel.center.y);
}

//-(void)updateCell:(id)model
//{
//    
//    if (model == nil)
//    {
//        return;
//    }
//    
//    self.YVModel = model;
//    self.MVNameLabel.text = self.YVModel.couponName;
//    
//    self.MVDateLabel.text  = self.YVModel.couponDate;
//    
//    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
//    
//    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
//    self.MVUselabel.text        = self.YVModel.couponType;
//    [self.MVCoinLabel sizeToFit];
//    [self.MVNameLabel sizeToFit];
//    [self.MVDateLabel sizeToFit];
//    [self.MVUselabel sizeToFit];
//    [self.MVRestrictionLabel sizeToFit];
//    
//    [self.MVUselabel  sizeToFit];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation KGUnUseCouponTalbleCell 
-(void)updateCell:(id)model
{
    
    if (model == nil)
    {
        return;
    }
    
    self.YVModel = model;
    self.MVUnitLabel.text = @"¥";
    self.MVNameLabel.text = self.YVModel.couponName;
    
    self.MVDateLabel.text  = [NSString stringWithFormat:@"%@到期",self.YVModel.couponDate];
    
    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
    
    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
    self.MVUselabel.text        = @"未使用";
    [self.MVUnitLabel sizeToFit];
    [self.MVCoinLabel sizeToFit];
    [self.MVNameLabel sizeToFit];
    [self.MVDateLabel sizeToFit];
    [self.MVUselabel sizeToFit];
    [self.MVRestrictionLabel sizeToFit];
    
    [self.MVUselabel  sizeToFit];
}

-(void)createImageView
{
    [super createImageView];
    self.MVLeftImage.image = [UIImage imageNamed:@"left_unuse"];
    self.MVRightImage.image = [UIImage imageNamed:@"right_unuse"];
//    self.MVLeftImage.backgroundColor =CommonlyUsedBtnColor;
//    self.MVRightImage.backgroundColor = CommonlyUsedBtnColor;
}
-(void)createUnitLabel
{
    [super createUnitLabel];
    self.MVUnitLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createCoinLabel
{
    [super createCoinLabel];
    self.MVCoinLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createNameLabel
{
    [super createNameLabel];
    self.MVNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    
}
-(void)createUseStateLabel
{
    [super createUseStateLabel];
    self.MVUselabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createDateLabel
{
    [super createDateLabel];
    self.MVDateLabel.textColor = [UIColor colorWithHexString:@"#000000"];
}
-(void)createRestrictionLabel
{
    [super createRestrictionLabel];
    self.MVRestrictionLabel.textColor = [UIColor colorWithHexString:@"#000000"];
}
-(void)createLineLabel
{
    [super createLineLabel];
}



@end

@implementation KGUseCouponTalbleCell
-(void)updateCell:(id)model
{
    
    if (model == nil)
    {
        return;
    }
    
    self.YVModel = model;
     self.MVUnitLabel.text = @"¥";
    self.MVNameLabel.text = self.YVModel.couponName;
    
    self.MVDateLabel.text  = [NSString stringWithFormat:@"%@到期",self.YVModel.couponDate];
    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
    
    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
    self.MVUselabel.text        = @"已使用";
    [self.MVUnitLabel sizeToFit];
    [self.MVCoinLabel sizeToFit];
    [self.MVNameLabel sizeToFit];
    [self.MVDateLabel sizeToFit];
    [self.MVUselabel sizeToFit];
    [self.MVRestrictionLabel sizeToFit];
    
    [self.MVUselabel  sizeToFit];
}

-(void)createImageView
{
    [super createImageView];
    self.MVLeftImage.image = [UIImage imageNamed:@"left_used"];
    self.MVRightImage.image = [UIImage imageNamed:@"right_used"];
//    self.MVLeftImage.backgroundColor =[UIColor colorWithHexString:@"#999999"];
//    self.MVRightImage.backgroundColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createUnitLabel
{
    [super createUnitLabel];
    self.MVUnitLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createCoinLabel
{
    [super createCoinLabel];
    self.MVCoinLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createNameLabel
{
    [super createNameLabel];
    self.MVNameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
}
-(void)createUseStateLabel
{
    [super createUseStateLabel];
    self.MVUselabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createDateLabel
{
    [super createDateLabel];
    self.MVDateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createRestrictionLabel
{
    [super createRestrictionLabel];
    self.MVRestrictionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

@end


@implementation KGExpiredCouponTalbleCell
-(void)updateCell:(id)model
{
    
    if (model == nil)
    {
        return;
    }
    
    self.YVModel = model;
     self.MVUnitLabel.text = @"¥";
    self.MVNameLabel.text = self.YVModel.couponName;
    
    self.MVDateLabel.text  = [NSString stringWithFormat:@"%@到期",self.YVModel.couponDate];
    
    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
    
    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
    self.MVUselabel.text        = @"已过期";
    [self.MVUnitLabel sizeToFit];
    [self.MVCoinLabel sizeToFit];
    [self.MVNameLabel sizeToFit];
    [self.MVDateLabel sizeToFit];
    [self.MVUselabel sizeToFit];
    [self.MVRestrictionLabel sizeToFit];
    
    [self.MVUselabel  sizeToFit];
}

-(void)createImageView
{
    [super createImageView];
    self.MVLeftImage.image = [UIImage imageNamed:@"left_used"];
    self.MVRightImage.image = [UIImage imageNamed:@"right_used"];
//    self.MVLeftImage.backgroundColor =[UIColor colorWithHexString:@"#999999"];
//    self.MVRightImage.backgroundColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createUnitLabel
{
    [super createUnitLabel];
    self.MVUnitLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createCoinLabel
{
    [super createCoinLabel];
    self.MVCoinLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createNameLabel
{
    [super createNameLabel];
    self.MVNameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
}
-(void)createUseStateLabel
{
    [super createUseStateLabel];
    self.MVUselabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createDateLabel
{
    [super createDateLabel];
    self.MVDateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createRestrictionLabel
{
    [super createRestrictionLabel];
    self.MVRestrictionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

@end


@implementation KGCouponCenterTalbleCell
-(void)updateCell:(id)model
{
    
    if (model == nil)
    {
        return;
    }
    
    self.YVModel = model;
    self.MVUnitLabel.text = @"¥";
    self.MVNameLabel.text = self.YVModel.couponName;
    
    self.MVDateLabel.text  = [NSString stringWithFormat:@"%@到期",self.YVModel.couponDate];
    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
    
    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
    self.MVUselabel.text        = @"立即\n兑换";
    [self.MVUnitLabel sizeToFit];
    [self.MVCoinLabel sizeToFit];
    [self.MVNameLabel sizeToFit];
    [self.MVDateLabel sizeToFit];
    [self.MVUselabel sizeToFit];
    [self.MVRestrictionLabel sizeToFit];
    
    [self.MVUselabel  sizeToFit];
}

-(void)createImageView
{
    [super createImageView];
    self.MVLeftImage.image = [UIImage imageNamed:@"left_unuse"];
    self.MVRightImage.image = [UIImage imageNamed:@"right_unuse"];
    //    self.MVLeftImage.backgroundColor =[UIColor colorWithHexString:@"#999999"];
    //    self.MVRightImage.backgroundColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createUnitLabel
{
    [super createUnitLabel];
    self.MVUnitLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createCoinLabel
{
    [super createCoinLabel];
    self.MVCoinLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createNameLabel
{
    [super createNameLabel];
    
    self.MVNameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
}
-(void)createUseStateLabel
{
    [super createUseStateLabel];
    self.MVUselabel.numberOfLines = 0;
    self.MVUselabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.MVUselabel.backgroundColor = [UIColor colorWithHexString:@"#ffae02"];
    self.MVUselabel.font = [UIFont boldSystemFontOfSize:24.0f];
    self.MVUselabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    
}
-(void)createDateLabel
{
    [super createDateLabel];
    self.MVDateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createRestrictionLabel
{
    [super createRestrictionLabel];
    self.MVRestrictionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
     self.MVUselabel.frame = CGRectMake(ScreenWidth-96-21, 0, 96, self.v_height);
}
@end

@interface KGCouponSelectTalbleCell()
@property (nonatomic,retain)UIImageView    *  MVSelectImageView;
@end
@implementation KGCouponSelectTalbleCell
-(void)updateCell:(id)model
{
    
    if (model == nil)
    {
        return;
    }
    
    self.YVModel = model;
    self.MVUnitLabel.text = @"¥";
    self.MVNameLabel.text = self.YVModel.couponName;
    
    self.MVDateLabel.text  = [NSString stringWithFormat:@"%@到期",self.YVModel.couponDate];
    self.MVRestrictionLabel.text   = [NSString stringWithFormat:@"满%@可用",self.YVModel.couponLimit];
    
    self.MVCoinLabel.text   =   self.YVModel.coupondenom;
  
    [self.MVUnitLabel sizeToFit];
    [self.MVCoinLabel sizeToFit];
    [self.MVNameLabel sizeToFit];
    [self.MVDateLabel sizeToFit];
    [self.MVUselabel sizeToFit];
    [self.MVRestrictionLabel sizeToFit];
    
    [self.MVUselabel  sizeToFit];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _MVSelectImageView.highlighted = selected;
    // Configure the view for the selected state
}

-(void)createImageView
{
    [super createImageView];
    self.MVLeftImage.image = [UIImage imageNamed:@"left_unuse"];
    self.MVRightImage.image = [UIImage imageNamed:@"right_unuse"];
    [self addSubview:self.MVSelectImageView];

}

-(UIImageView *)MVSelectImageView
{
    if (_MVSelectImageView == nil)
    {
        _MVSelectImageView = [[UIImageView alloc]init];
        _MVSelectImageView.image  = [UIImage imageNamed:@"shopping"];
        _MVSelectImageView.highlightedImage = [UIImage imageNamed:@"shopping-press"];
    }
    return _MVSelectImageView;
}
-(void)createUnitLabel
{
    [super createUnitLabel];
    self.MVUnitLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createCoinLabel
{
    [super createCoinLabel];
    self.MVCoinLabel.textColor = [UIColor colorWithHexString:@"#ec4646"];
}
-(void)createNameLabel
{
    [super createNameLabel];
    
    self.MVNameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
}
-(void)createUseStateLabel
{
   
  
    
}
-(void)createDateLabel
{
    [super createDateLabel];
    self.MVDateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}
-(void)createRestrictionLabel
{
    [super createRestrictionLabel];
    self.MVRestrictionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVSelectImageView.frame =CGRectMake(ScreenWidth-48-21, (self.v_height-22)/2, 22, 22);
    self.MVDateLabel.frame = CGRectMake(self.MVDateLabel.v_x, self.MVDateLabel.v_y, ScreenWidth-40-22-self.MVRestrictionLabel.v_width-24-12, self.MVDateLabel.v_height);
}

@end
