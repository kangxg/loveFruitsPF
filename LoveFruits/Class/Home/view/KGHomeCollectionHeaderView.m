//
//  KGHomeCollectionHeaderView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCollectionHeaderView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGHomeCollectionHeaderView()
@property (nonatomic,retain)UIView      * MBackView;
@property (nonatomic,retain)UIImageView * MVImageView;
@property (nonatomic,retain)UILabel     * MVDownLine;
@property (nonatomic,retain)UIButton    * MVButton;
@property (nonatomic,copy)KGCallbackBlock  MVBlock;
@property (nonatomic,retain)NSString    * MVDetailString;

@end

@implementation KGHomeCollectionHeaderView
@synthesize KMTitleLabel  = _KMTitleLabel;

@synthesize KMTltleString = _KMTltleString;
@synthesize MVImageView   = _MVImageView;
@synthesize MVButton      = _MVButton;
@synthesize  MVBlock      = _MVBlock;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.MBackView];
        [self addSubview:self.KMTitleLabel];
        [self addSubview:self.MVImageView];
        [self addSubview:self.MVButton];
//        [self addSubview:self.MVDownLine];
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setHeadViewMessage:(NSString *)title withTitleColor:(NSString *)colorString withImage:(NSString *)imageName withDetail:(NSString *)detail  withClick:(KGCallbackBlock)block
{
  
    _MVBlock = block;
    _MVDetailString = detail;
    self.KMTitleLabel.text = title;
    [self.KMTitleLabel sizeToFit];
    self.KMTitleLabel.textColor = [UIColor colorWithHexString:colorString];
    
    
    UIImage * image = [UIImage imageNamed:imageName];
    self.MVImageView.image = image;
    
    float with = image.size.width + _KMTitleLabel.v_width+6;
    
    self.MVImageView.frame = CGRectMake((self.v_width-with)/2, (self.v_height-image.size.height)/2+5, image.size.width, image.size.height);
    self.KMTitleLabel.frame =  CGRectMake(_MVImageView.v_right +6, 10, self.KMTitleLabel.v_width, self.v_height-10);
//    _KMTitleLabel.backgroundColor = [UIColor redColor];
    //&&[title isEqualToString:@"新品推荐"]
    if (_MVBlock )
    {
        _MVButton.frame = CGRectMake(self.v_width-11-40, 10, 40, 38);
    }
    else
    {
        _MVButton.hidden = YES;
    }
    
}
-(UIView *)MBackView
{
    if (_MBackView == nil)
    {
        _MBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height-11)];
        _MBackView.backgroundColor = [UIColor whiteColor];
    
    }
   return  _MBackView;
}

-(UILabel *)KMTitleLabel
{
    if (_KMTitleLabel == nil)
    {
        _KMTitleLabel = [[UILabel alloc]init];
        
        _KMTitleLabel.textAlignment = NSTextAlignmentLeft;
        _KMTitleLabel.font  = [UIFont systemFontOfSize:14.0f];
        _KMTitleLabel.frame = CGRectMake(10, 10, 200, 38);
//        _KMTitleLabel.textColor = [UIColor colorWithCustom:150 withGreen:150 withBlue:150];
      
    }
    return _KMTitleLabel;
}

-(UILabel *)MVDownLine
{
    if (_MVDownLine == nil)
    {
        _MVDownLine = [[UILabel alloc]init];
        
        
        _MVDownLine.frame = CGRectMake(0,self.frame.size.height-0.5 , self.frame.size.width, 0.5);
        _MVDownLine.textColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
    
    return _MVDownLine;
}

-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
    }
    return _MVImageView;
}

-(UIButton *)MVButton
{
    if (_MVButton == nil)
    {
        _MVButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _MVButton.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [_MVButton setTitle:@"更多" forState:UIControlStateNormal];
        [_MVButton.titleLabel sizeToFit];
        [_MVButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        UIImage * image = [UIImage imageNamed:@"more"];
        [_MVButton setImage:image forState:UIControlStateNormal];
        [_MVButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width+6)];
        [_MVButton setImageEdgeInsets:UIEdgeInsetsMake(0,_MVButton.titleLabel.bounds.size.width+6, 0, -_MVButton.titleLabel.bounds.size.width)];
        [_MVButton addTarget:self action:@selector(moreBtnCallBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVButton ;
}

-(void)moreBtnCallBack:(UIButton *)button
{
    if (_MVBlock)
    {
        _MVBlock(_MVDetailString);
    }
}


@end
