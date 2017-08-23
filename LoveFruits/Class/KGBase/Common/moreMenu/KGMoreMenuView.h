//
//  KGMoreMenuView.h
//  LoveFruits
//
//  Created by kangxg on 2016/11/13.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGMoreMenuView : KGBaseView
@property (nonatomic,assign,readonly)NSInteger  YVSelectIndex;
-(instancetype)initWithFrame:(CGRect)frame withMenuTitle:(NSArray *)titleArr;
-(void)changeView:(NSInteger )index;
@end
