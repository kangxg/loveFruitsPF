//
//  YZSearchNoneView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/19.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchNoneView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGSearchNoneView()
@property (nonatomic,retain)UIImageView * MVImageView;
@property (nonatomic,retain)UILabel     * MVLabel;
@end
@implementation KGSearchNoneView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = LFBNavigationHomeSearchColor;
        [self addSubview:self.MVImageView];
        [self addSubview:self.MVLabel];
    }
    return self;
}

-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
        UIImage * image = [UIImage imageNamed:@"search-none"];
        _MVImageView.image = image;
        _MVImageView.frame = CGRectMake((self.v_width-image.size.width)/2, 100, image.size.width, image.size.height);
    }
    return _MVImageView;
}

-(UILabel *)MVLabel
{
    if (_MVLabel == nil)
    {
        _MVLabel = [[UILabel alloc]init];
        _MVLabel.textColor = [UIColor colorWithHexString:@"#585858"];
        _MVLabel.font = [UIFont systemFontOfSize:17.0f];
        _MVLabel.text = @"抱歉，没有找到该产品";
        _MVLabel.frame = CGRectMake(0, self.MVImageView.v_bottom+25, self.v_width, 20);
        _MVLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _MVLabel;
}
@end
