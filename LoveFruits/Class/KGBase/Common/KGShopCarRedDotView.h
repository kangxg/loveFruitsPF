//
//  KGShopCarRedDotView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGShopCarRedDotView : UIView
@property (nonatomic,assign)NSInteger  KGBuyNumber;
+(KGShopCarRedDotView *)sharedRedDotView;
-(void)addProductToRedDotView:(BOOL)animation;
-(void)reduceProductToRedDotView:(BOOL)animation;
-(void)operationProductToRedDotView:(NSInteger )count;
@end
