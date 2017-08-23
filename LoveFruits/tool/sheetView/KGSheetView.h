//
//  KGSheetView.h
//  LoveFruits
//
//  Created by kangxg on 16/9/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGSheetView : KGBaseView
+(id)initWithSuperView:(UIView*)superView frame:(CGRect)frame titleContent:(NSString*)title cancleBtnName:(NSString *)cancleName otherBtnArr:(NSArray*)btnArr;
+(id)initWithSuperView:(UIView*)superView frame:(CGRect)frame BtnArr:(NSArray*)btnArr;
@end
