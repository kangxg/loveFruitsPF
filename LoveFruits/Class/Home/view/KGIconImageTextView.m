//
//  KGIconImageTextView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGIconImageTextView.h"
#import "UIView+Extension.h"
#import "KGHomeHeadResources.h"
#import "UIImageView+WebCache.h"
@interface KGIconImageTextView()
@property (nonatomic,retain)UIImageView * MImageView;
@property (nonatomic,retain)UILabel     * MTextLabel;
@property (nonatomic,retain)UIImage     * MplaceholderImage;
@end

@implementation KGIconImageTextView
@synthesize KGActivity = _KGActivity;
@synthesize MImageView = _MImageView;
@synthesize MplaceholderImage= _MplaceholderImage;
@synthesize MTextLabel  = _MTextLabel;
-(void)setKGActivity:(Activities *)KGActivity
{
    if (KGActivity == nil)
    {
        return;
    }
    if (_MTextLabel)
    {
        _MTextLabel.text = KGActivity.name;
    }
    if (_MImageView)
    {
        _MImageView.image = [UIImage imageNamed:KGActivity.img];
        
//        [_MImageView sd_setImageWithURL:[NSURL URLWithString:KGActivity.img] placeholderImage:_MplaceholderImage];
    }
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _MImageView = [[UIImageView alloc]init];
        _MImageView.userInteractionEnabled = YES;
        _MImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_MImageView];
        
        _MTextLabel = [[UILabel alloc]init];
        
        _MTextLabel.textAlignment = NSTextAlignmentCenter;
        _MTextLabel.font          = [UIFont systemFontOfSize:12.0f];
        _MTextLabel.textColor     = [UIColor blackColor];
        _MTextLabel.userInteractionEnabled = false;
        [self addSubview:_MTextLabel];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withPlaceholderImage:(UIImage *)placeholderImage
{
    if (self = [self initWithFrame:frame])
    {
        _MplaceholderImage= placeholderImage;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_MImageView)
    {
        _MImageView.frame =  CGRectMake(5, 5, self.v_width - 15, self.v_height - 30);
        _MTextLabel.frame =  CGRectMake(5, self.v_height - 30, _MImageView.v_width, 20);
    }
}
@end
