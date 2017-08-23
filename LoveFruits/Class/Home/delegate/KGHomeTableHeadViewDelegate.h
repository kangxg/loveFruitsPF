//
//  KGHomeTableHeadViewDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KGHomeTableHeadView;
@protocol KGHomeTableHeadViewDelegate <NSObject>
@optional
-(void)tableHeadView:(KGHomeTableHeadView *)headView focusImageViewClick:(NSInteger)index;
-(void)tableHeadView:(KGHomeTableHeadView *)headView iconClick:(NSInteger)index;
@end
