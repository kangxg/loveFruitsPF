//
//  KGProductDetailsHeadView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsHeadView.h"
#import "KGProductDetailsModel.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "GlobelDefine.h"
@interface KGProductDetailsHeadView()
@property (nonatomic,retain)UILabel       * MVNameLabel;
@property (nonatomic,retain)UILabel       * MVSaleLabel;
@property (nonatomic,retain)UILabel       * MVOnsaleTypeLabel;
@property (nonatomic,retain)UILabel       * MVNewTypeLabel;
@property (nonatomic,retain)UILabel       * MVHotTypeLabel;

@property (nonatomic,retain)UIImageView   * MVOnsaleTypeImageView;
@property (nonatomic,retain)UIImageView   * MVNewTypeImageView;
@property (nonatomic,retain)UIImageView   * MVHotTypeImageView;

@property (nonatomic,weak)KGProductDetailsModel * MVModel;
@end

@implementation KGProductDetailsHeadView
@synthesize MVNameLabel       = _MVNameLabel;
@synthesize MVSaleLabel       = _MVSaleLabel;
@synthesize MVOnsaleTypeLabel       = _MVOnsaleTypeLabel;
@synthesize MVNewTypeLabel    = _MVNewTypeLabel;
@synthesize MVHotTypeLabel    = _MVHotTypeLabel;

@synthesize KVProductImageView= _KVProductImageView;
@synthesize MVOnsaleTypeImageView   = _MVOnsaleTypeImageView;
@synthesize MVNewTypeImageView = _MVNewTypeImageView;
@synthesize MVHotTypeImageView = _MVHotTypeImageView;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.KVProductImageView];
        [self addSubview:self.MVNameLabel];
        [self addSubview:self.MVSaleLabel];
        [self addSubview:self.MVOnsaleTypeImageView];
        [self addSubview:self.MVOnsaleTypeLabel];
        [self addSubview:self.MVNewTypeImageView];
        [self addSubview:self.MVNewTypeLabel];
        [self addSubview:self.MVHotTypeImageView];
        [self addSubview:self.MVHotTypeLabel];
    }
    return self;
}
-(void)updateView:(KGProductDetailsModel *)model
{
    if (model)
    {
        _MVModel = model;
        [_KVProductImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"v2_placeholder_left"]];
        _MVNameLabel.text = model.name;
        [_MVNameLabel sizeToFit];
        
        _MVSaleLabel.text = [NSString stringWithFormat:@"已售%@件",model.totalSale];
        
        [_MVSaleLabel sizeToFit];
        NSInteger type =model.type&7;
        switch (type) {
            case 7:
            {
                _MVOnsaleTypeImageView.image = [UIImage imageNamed:@"sales_p"];
                _MVOnsaleTypeLabel.text      = @"促销";
                [_MVOnsaleTypeLabel sizeToFit];
            }
            case 3:
            {
                _MVNewTypeImageView.image =[UIImage imageNamed:@"new"];
                _MVNewTypeLabel.text         = @"新品";
                [_MVNewTypeLabel sizeToFit];
            }
            case 1:
            {
                _MVHotTypeImageView.image =[UIImage imageNamed:@"hot_p"];
                _MVHotTypeLabel.text      = @"热门";
                [_MVHotTypeLabel sizeToFit];
            }
               
                break;
            case 2:
            {
                _MVNewTypeImageView.image =[UIImage imageNamed:@"new"];
                _MVNewTypeLabel.text         = @"新品";
                [_MVNewTypeLabel sizeToFit];
            }
           
                break;
            case 4:
            {
                _MVOnsaleTypeImageView.image = [UIImage imageNamed:@"sales_p"];
                _MVOnsaleTypeLabel.text      = @"促销";
                [_MVOnsaleTypeLabel sizeToFit];
            }
                
                break;
            default:
                break;
        }
  
        
    }
//    _KVProductImageView.image = [UIImage imageNamed:@"today-test"];
//    _MVTypeImageView.image = [UIImage imageNamed:@"new"];
//    _MVTypeLabel.text = @"新品";
//    [_MVTypeLabel sizeToFit];
}
-(UILabel *)MVNameLabel
{
    if (_MVNameLabel == nil)
    {
        _MVNameLabel = [[UILabel alloc]init];
        _MVNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _MVNameLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
        
    }
    return _MVNameLabel;
}

-(UILabel *)MVSaleLabel
{
    if (_MVSaleLabel == nil)
    {
        _MVSaleLabel = [[UILabel alloc]init];
        _MVSaleLabel.font = [UIFont systemFontOfSize:12.0f];
        _MVSaleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _MVSaleLabel;
}
-(UILabel *)MVOnsaleTypeLabel
{
    if (_MVOnsaleTypeLabel == nil)
    {
        _MVOnsaleTypeLabel = [[UILabel alloc]init];
        _MVOnsaleTypeLabel.font = [UIFont systemFontOfSize:11.0f];
        _MVOnsaleTypeLabel.textColor = CommonlyUsedBtnColor;
    }
    return _MVOnsaleTypeLabel;
}
-(UILabel *)MVNewTypeLabel
{
    if (_MVNewTypeLabel == nil)
    {
        _MVNewTypeLabel = [[UILabel alloc]init];
        _MVNewTypeLabel.font = [UIFont systemFontOfSize:11.0f];
        _MVNewTypeLabel.textColor = CommonlyUsedBtnColor;
    }
    return _MVNewTypeLabel;
}

-(UILabel *)MVHotTypeLabel
{
    if (_MVHotTypeLabel == nil)
    {
        _MVHotTypeLabel = [[UILabel alloc]init];
        _MVHotTypeLabel.font = [UIFont systemFontOfSize:11.0f];
        _MVHotTypeLabel.textColor = CommonlyUsedBtnColor;
    }
    return _MVHotTypeLabel;
}
-(UIImageView *)KVProductImageView
{
    if (_KVProductImageView == nil)
    {
        _KVProductImageView = [[UIImageView alloc]init];
    }
    return _KVProductImageView;
}

-(UIImageView *)MVOnsaleTypeImageView
{
    if (_MVOnsaleTypeImageView == nil)
    {
        _MVOnsaleTypeImageView = [[UIImageView alloc]init];
    }
    return _MVOnsaleTypeImageView;
}
-(UIImageView *)MVNewTypeImageView
{
    if (_MVNewTypeImageView == nil)
    {
        _MVNewTypeImageView = [[UIImageView alloc]init];
    }
    return _MVNewTypeImageView;
}
-(UIImageView *)MVHotTypeImageView
{
    if (_MVHotTypeImageView == nil)
    {
        _MVHotTypeImageView = [[UIImageView alloc]init];
    }
    return _MVHotTypeImageView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _KVProductImageView.frame = CGRectMake(0, 0, 187, self.v_height);
    _MVNameLabel.frame = CGRectMake(_KVProductImageView.v_right+20, 22.5, self.v_width-40-_KVProductImageView.v_width, _MVNameLabel.v_height);
    
    _MVSaleLabel.frame = CGRectMake(_KVProductImageView.v_right+20, _MVNameLabel.v_bottom+8, self.v_width-40-_KVProductImageView.v_width, _MVSaleLabel.v_height);
    NSInteger type = _MVModel.type&7;
    switch (type) {
        case 7:
        {
            _MVHotTypeImageView.frame =  CGRectMake(_KVProductImageView.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVHotTypeLabel.frame =  CGRectMake(_MVHotTypeImageView.v_right+5, _MVHotTypeImageView.v_y+1, _MVHotTypeLabel.v_width, 13);
            _MVOnsaleTypeImageView.frame =  CGRectMake(_MVHotTypeLabel.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVOnsaleTypeLabel.frame =  CGRectMake(_MVOnsaleTypeImageView.v_right+5, _MVOnsaleTypeImageView.v_y+1, _MVOnsaleTypeLabel.v_width, 13);
            
            _MVNewTypeImageView.frame =  CGRectMake(_MVOnsaleTypeLabel.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVNewTypeLabel.frame =  CGRectMake(_MVNewTypeImageView.v_right+5, _MVNewTypeImageView.v_y+1, _MVNewTypeLabel.v_width, 13);
        }
            break;
        case 3:
        {
            _MVHotTypeImageView.frame =  CGRectMake(_KVProductImageView.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVHotTypeLabel.frame =  CGRectMake(_MVHotTypeImageView.v_right+5, _MVHotTypeImageView.v_y+1, _MVHotTypeLabel.v_width, 13);
            _MVNewTypeImageView.frame =  CGRectMake(_MVHotTypeLabel.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVNewTypeLabel.frame =  CGRectMake(_MVNewTypeImageView.v_right+5, _MVNewTypeImageView.v_y+1, _MVNewTypeLabel.v_width, 13);
            break;
        }
        case 1:
        {
            _MVHotTypeImageView.frame =  CGRectMake(_KVProductImageView.v_right+20, self.v_height-22.5-13, 13, 13);
            
            _MVHotTypeLabel.frame =  CGRectMake(_MVHotTypeImageView.v_right+5, _MVHotTypeImageView.v_y+1, _MVHotTypeLabel.v_width, 13);
        }
            break;
        case 2:
        {
            _MVNewTypeImageView.frame = CGRectMake(_KVProductImageView.v_right+20, self.v_height-22.5-13, 13, 13);
            _MVNewTypeLabel.frame =CGRectMake(_MVNewTypeImageView.v_right+5, _MVNewTypeImageView.v_y+1, _MVNewTypeLabel.v_width, 13);
          
        }
            
            break;
        case 4:
        {
            _MVOnsaleTypeImageView.frame = CGRectMake(_KVProductImageView.v_right+20, self.v_height-22.5-13, 13, 13);
           _MVOnsaleTypeLabel.frame =  CGRectMake(_MVOnsaleTypeImageView.v_right+5, _MVOnsaleTypeImageView.v_y+1, _MVOnsaleTypeLabel.v_width, 13);
        }
            
            break;
            
        default:
            break;
    }
   



}
@end
///**
// *  Description
// */
//@implementation KGNewProductDetailsHeadView
//
//@end
///**
// *  Description
// */
//@implementation KGHotProductDetailsHeadView
//
//@end
///**
// *  Description
// */
//@implementation KGTodayProductDetailsHeadView
//
//@end

