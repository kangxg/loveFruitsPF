//
//  KGRefreshHeader.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGRefreshHeader.h"

@implementation KGRefreshHeader
-(void)prepare
{
    [super prepare];
    self.stateLabel.hidden = false;
    self.lastUpdatedTimeLabel.hidden = true;
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh2"]] forState:MJRefreshStatePulling];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"],[UIImage imageNamed:@"v2_pullRefresh2"],[UIImage imageNamed:@"v2_pullRefresh3"],[UIImage imageNamed:@"v2_pullRefresh4"]] forState:MJRefreshStateRefreshing];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松手开始刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
}
@end
