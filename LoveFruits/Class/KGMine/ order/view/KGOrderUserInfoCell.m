//
//  KGOrderUserInfoCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGOrderUserInfoCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"

#import "KGOrderDetailViewModel.h"
@interface KGOrderUserInfoCell()
@property (nonatomic,retain)UILabel * MVNameLabel;
@property (nonatomic,retain)UILabel * MVTelLabel;
@property (nonatomic,retain)UILabel * MVAdLabel;

@property (nonatomic,retain)UILabel * MVNameValueLabel;
@property (nonatomic,retain)UILabel * MVTelValueLabel;
@property (nonatomic,retain)UILabel * MVAdValueLabel;


@end
@implementation KGOrderUserInfoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self createNameView];
        [self createTelView];
        [self createAdView];
 
    }
    return self;
}

-(void)createNameView
{
    [self addSubview:self.MVNameLabel];
    [self addSubview:self.MVNameValueLabel];
}
-(void)createTelView
{
    [self addSubview:self.MVTelLabel];
    [self addSubview:self.MVTelValueLabel];
    
}

-(void)createAdView
{
    [self addSubview:self.MVAdLabel];
    [self addSubview:self.MVAdValueLabel];
}
-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel = [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:18];
        _MVNameLabel.text = @"收货人 ：";
        _MVNameLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVNameLabel;
}

-(UILabel *)MVNameValueLabel
{
    if (_MVNameValueLabel == nil)
    {
        _MVNameValueLabel = [[UILabel alloc]init];
        _MVNameValueLabel.font = [UIFont systemFontOfSize:15];
        //        _MVNameValueLabel.text = @"收货人：";
        _MVNameValueLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _MVNameValueLabel;
}
-(UILabel *)MVTelLabel
{
    if (_MVTelLabel == nil)
    {
        _MVTelLabel = [[UILabel alloc]init];
        _MVTelLabel.font = [UIFont systemFontOfSize:14];
        _MVTelLabel.text = @"联系电话：";
        _MVTelLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVTelLabel;
}
-(UILabel *)MVTelValueLabel
{
    if (_MVTelValueLabel == nil)
    {
        _MVTelValueLabel = [[UILabel alloc]init];
        _MVTelValueLabel.font = [UIFont systemFontOfSize:14];
        _MVTelValueLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVTelValueLabel;
}
-(UILabel *)MVAdLabel
{
    if (_MVAdLabel == nil)
    {
        _MVAdLabel = [[UILabel alloc]init];
        _MVAdLabel.font = [UIFont systemFontOfSize:14];
        _MVAdLabel.text = @"收货地址：";
        _MVAdLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVAdLabel;
}

-(UILabel *)MVAdValueLabel
{
    if (_MVAdValueLabel == nil)
    {
        _MVAdValueLabel = [[UILabel alloc]init];
        _MVAdValueLabel.font = [UIFont systemFontOfSize:14];
        
        _MVAdValueLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MVAdValueLabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    float w = 80;
    _MVNameLabel.frame = CGRectMake(10, 15, w, 20);
    _MVNameValueLabel.frame = CGRectMake(_MVNameLabel.v_right+5, 15, ScreenWidth-20-_MVNameLabel.v_width-5, 20);
    
    _MVTelLabel.frame = CGRectMake(10, _MVNameLabel.v_bottom+15, w, 15);
    _MVTelValueLabel.frame = CGRectMake(_MVTelLabel.v_right+5, _MVNameLabel.v_bottom+15, ScreenWidth-20-_MVTelLabel.v_width-5, 15);
    
    _MVAdLabel.frame = CGRectMake(10, _MVTelLabel.v_bottom+15, w, 15);
    _MVAdValueLabel.frame = CGRectMake(_MVAdLabel.v_right+5, _MVTelLabel.v_bottom+15, ScreenWidth-20-_MVAdLabel.v_width-5, 15);
    
}
-(void)updateCell:(id)model
{
    if (model)
    {
        KGOrderDetailModel * omodel = model;
        _MVNameValueLabel.text= omodel.KDOrderUserName;
        
        _MVTelValueLabel.text = omodel.KDPhone;
        
        _MVAdValueLabel.text  = omodel.KDOrderAdress;

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
