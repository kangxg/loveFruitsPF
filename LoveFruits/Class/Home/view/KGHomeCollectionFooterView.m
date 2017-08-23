//
//  KGHomeCollectionFooterView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeCollectionFooterView.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@interface KGHomeCollectionFooterView()
@property (nonatomic,retain)UILabel * MTitleLabel;
@property (nonatomic,retain)UIImageView * MVImageView;
@end

@implementation KGHomeCollectionFooterView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        _MTitleLabel = [[UILabel alloc]init];
//        _MTitleLabel.text = @"点击查看更多商品 >";
//        _MTitleLabel.textAlignment = NSTextAlignmentCenter;
//        _MTitleLabel.font  = [UIFont systemFontOfSize:16.0f];
//        _MTitleLabel.frame = CGRectMake(0, 0, ScreenWidth, 60)
//;
//        _MTitleLabel.textColor = [UIColor colorWithCustom:150 withGreen:150 withBlue:150];
//        [self addSubview:_MTitleLabel];
//        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.MVImageView];
     
    }
    return self;
}

-(UIImageView *)MVImageView
{
    if (_MVImageView == nil)
    {
        _MVImageView = [[UIImageView alloc]init];
        _MVImageView.frame = CGRectMake(0, 10, self.v_width, self.v_height-10);
        _MVImageView.backgroundColor = [UIColor greenColor];
    }
    return _MVImageView;
}

-(void)setFooterImage:(NSString *)imageUrl
{
    if (imageUrl )
    {
        
        _MVImageView.frame = CGRectMake(0, 10, self.v_width, self.v_height-10);
       
        [_MVImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]  placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
//         KGWEAKOBJECT(weakSelf);
//        [_MVImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            weakSelf.frame = CGRectMake(self.v_x, self.v_y, self.v_width, image.size.height);
//
//        }];
    }
}
-(void)hideLabel
{

    self.MVImageView.hidden = true;
//    self.MTitleLabel.hidden = true;

}

-(void)showLabel
{
    self.MVImageView.hidden = false;
//    self.MTitleLabel.hidden = false;
}

-(void)setFooterTitle:(NSString *)text withColor:(UIColor *)color
{
    if (_MTitleLabel)
    {
        _MTitleLabel.textColor = color;
        _MTitleLabel.text = text;
    }
}
@end
