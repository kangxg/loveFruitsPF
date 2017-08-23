//
//  KGShopCartCellDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KGShopCartCellDelegate <NSObject>

-(void)pAddGoods:(id)sender;
-(void)pSubGoods:(id)sender;
-(void)pSelectedView:(id)sender;
@end
