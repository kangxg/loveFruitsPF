//
//  KGCategoryCell.m
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCategoryCell.h"
#import "KGSupermarket.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "KGClassificationModel.h"
static NSString * identifier = @"CategoryCell";
@interface KGCategoryCell()
@property (nonatomic,retain)UILabel        *   MNameLabel;
@property (nonatomic,retain)UIImageView    *   MBackImageView;
@property (nonatomic,retain)UIView         *   MYellowView;
@property (nonatomic,retain)UIView         *   MLineView;
@end
@implementation KGCategoryCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        //[self addSubview:self.MBackImageView];
//        [self addSubview:self.MYellowView];
       
        [self addSubview:self.MLineView];
        [self addSubview:self.MNameLabel];
    }
    return self;
}

-(UILabel *)MNameLabel
{
    if (_MNameLabel == nil)
    {
        _MNameLabel                      =  [[UILabel alloc]init];
        _MNameLabel.textColor            =  [UIColor colorWithHexString:@"#2c2c2c"];
        _MNameLabel.highlightedTextColor =  [UIColor whiteColor];
        _MNameLabel.textAlignment        =  NSTextAlignmentCenter;
        _MNameLabel.font                 =  [UIFont systemFontOfSize:14.0f];
       //_MNameLabel.backgroundColor = [UIColor redColor];

    }
    return _MNameLabel;
}

-(UIImageView *)MBackImageView
{
    if (_MBackImageView == nil)
    {
        _MBackImageView = [[UIImageView alloc]init];
        
//        _MBackImageView.image = [UIImage imageNamed:@"llll"];
//        _MBackImageView.highlightedImage = [UIImage imageNamed:@"kkkkkkk"];
    }
    return _MBackImageView;
}

-(UIView *)MYellowView
{
    if (_MYellowView == nil)
    {
        _MYellowView                  = [[UIView alloc]init];
        _MYellowView.backgroundColor  = LFBNavigationYellowColor;
      
    }
    return _MYellowView;
}

-(UIView *)MLineView
{
    if (_MLineView == nil)
    {
        _MLineView   =   [[UIView alloc]init];
        _MLineView.backgroundColor = [UIColor colorWithCustom:225 withGreen:225 withBlue:225];
    }
    return _MLineView;
}
-(void)setKCateorie:(KGCategorie *)KCateorie
{
    if (KCateorie)
    {
        _KCateorie = KCateorie;
        self.MNameLabel.text = _KCateorie.name;
    }
}

-(void)setKVModel:(KGClassificationModel *)KVModel
{
    if (KVModel)
    {
        _KVModel = KVModel;
        if (!_KVModel.isleafnode)
        {
            self.MNameLabel.text = @"全部";
        }
        else
        {
            self.MNameLabel.text = _KVModel.name;
        }
        
    }
}

+(KGCategoryCell *)cellWithTableView:(UITableView *)tableview
{
    KGCategoryCell * cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[KGCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        self.backgroundColor= CommonlyUsedBtnColor;
        if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickGoodClass:)])
        {
            if (self.KVModel.isleafnode)
            {
                 [self.KVDelegate pClickGoodClass:self.KVModel.cid];
            }
            else
            {
                 [self.KVDelegate pClickGoodClass:self.KVModel.cid];
            }
           
        }
    
    }
    else
    {
         self.backgroundColor= [UIColor colorWithHexString:@"#f0f0f0"];
    }
    
    self.MNameLabel.highlighted      = selected;
//    self.MBackImageView.highlighted  = selected;
//    self.MYellowView.hidden          = !selected;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.MNameLabel.frame     = self.bounds;
    self.MBackImageView.frame = CGRectMake(0, 0, self.v_width, self.v_height);
    self.MYellowView.frame    = CGRectMake(0, self.v_height * 0.1, 5, self.v_height * 0.8);
    self.MLineView.frame      = CGRectMake(0, self.v_height - 1, self.v_width, 1);
}
@end
