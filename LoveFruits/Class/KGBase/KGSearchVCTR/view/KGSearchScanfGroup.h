//
//  KGSearchScanfGroup.h
//  LoveFruits
//
//  Created by kangxg on 16/9/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGSearchScanfGroup : KGBaseView
-(instancetype)initWithSuperview:(UIView *)superview andFrame:(CGRect)frame;
-(void)refreshUIWithArr:(NSMutableArray*)arr;

-(void)dissmissMyself;
@end
