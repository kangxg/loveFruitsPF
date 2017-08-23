//
//  KGSupermarketHeadView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSupermarketHeadView.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
@interface KGSupermarketHeadView()

@end
@implementation KGSupermarketHeadView
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.backgroundView = [[UIView alloc]init];
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.8];
              
        [self addSubview:self.KGTitleLabel];
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.KGTitleLabel.frame = CGRectMake(HotViewMargin, 0, self.v_width - HotViewMargin, self.v_height);
    
}
-(UILabel *)KGTitleLabel
{
    if (_KGTitleLabel == nil)
    {
        _KGTitleLabel  = [[UILabel alloc]init];
        //_KGTitleLabel.backgroundColor = [UIColor redColor];
        _KGTitleLabel.font  = [UIFont systemFontOfSize:13.0f];
        _KGTitleLabel.textColor = [UIColor colorWithCustom:100 withGreen:100 withBlue:100];
        
        _KGTitleLabel.textAlignment = NSTextAlignmentLeft;
        

    }
    return _KGTitleLabel;
}
@end
