//
//  KGHomeCollectionFooterView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGHomeCollectionFooterView : UICollectionReusableView
-(void)hideLabel;
-(void)showLabel;
-(void)setFooterTitle:(NSString *)text withColor:(UIColor *)color;
-(void)setFooterImage:(NSString *)imageUrl;
@end
