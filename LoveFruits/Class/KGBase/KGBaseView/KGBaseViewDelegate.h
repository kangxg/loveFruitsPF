//
//  KGBaseViewDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGEnum.h"
#import "KGTableCellDelegate.h"
@protocol KGBaseViewDelegate <NSObject,KGTableCellDelegate>
@optional
-(void)pOperitionViewEvent:(id)sender  withState:(KGFunctionOperation)state;

-(void)pSelectWithIndex:(NSInteger )index;

-(void)pSearchGoods:(NSString *)goodsName;
/**
 *  Description  添加操作
 *
 *  @param sender 操作的视图本身
 */
-(void)pAddOperation:(id)sender;
/**
 *  Description  去往购物车
 *
 *  @param sender 操作的视图本身
 */
-(void)pGotoShoppingCar:(id)sender;

-(void)pSelectedAll:(BOOL)seleted;

-(void)pClickSettlement:(id)sender;

-(void)pLoadMore:(id)sender;


-(void)pSelectedView:(id)sender;

-(void)pUnSelectedView:(id)sender;
@end
