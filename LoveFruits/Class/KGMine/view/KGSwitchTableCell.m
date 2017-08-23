//
//  KGSwitchTableCell.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSwitchTableCell.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGSwitchTableCell()
{
    UISwitch  * _mSwitchView;
}
@end

@implementation KGSwitchTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.KVTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 150, cellSize.height)];
        self.KVTitleLabel.font= [UIFont systemFontOfSize:16.0f];
         self.KVTitleLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.KVTitleLabel];

        _mSwitchView = [[UISwitch alloc]init];
        _mSwitchView.frame = CGRectMake(ScreenWidth-_mSwitchView.v_width-14, self.v_height/2-_mSwitchView.v_height/2, 0, 0);
        _mSwitchView.onTintColor = [UIColor colorWithHexString:@"#69be40"];
        [_mSwitchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
               [self addSubview:_mSwitchView];

    }
    return self;
}

-(void)switchChange:(id)sender
{
//    UISwitch * mySwitch = sender;
//    if (mySwitch)
//    {
//        [_mSetting updateLocalVideoPromptSetting:!mySwitch.on];
//    }
    
}
@end
