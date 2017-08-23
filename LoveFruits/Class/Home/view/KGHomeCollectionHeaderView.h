//
//  KGHomeCollectionHeaderView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineBlock.h"
@interface KGHomeCollectionHeaderView : UICollectionReusableView
@property (nonatomic,retain)UILabel * KMTitleLabel;
@property (nonatomic,copy)NSString  * KMTltleString;

-(void)setHeadViewMessage:(NSString *)title  withTitleColor:(NSString *)colorString withImage:(NSString *)imageName withDetail:(NSString *)detail withClick:(KGCallbackBlock)block ;
@end
