//
//  KGSearchView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@interface KGSearchView : UIView
@property (nonatomic,assign)CGFloat      KGSearchHeight;
-(id)initWithFrame:(CGRect)frame withtitle:(NSString *)buttonTitle withSearchArry:(NSArray *)arr withBlock:(KGButtonClickBlock)searchBlock withClean:(KGButtonClickBlock)cleanblock;
@end
