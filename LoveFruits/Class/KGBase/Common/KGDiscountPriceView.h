//
//  KGDiscountPriceView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGDiscountPriceView : UIView
@property (nonatomic,retain)UIColor * KGPriceColor;
@property (nonatomic,retain)UIColor * KGMarketPriceColor;

-(id)initWithPriceView:(NSString *) price markPrice:(NSString *)markPrice;
@end
