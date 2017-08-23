//
//  KGProductDetailsHeadView.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"
@class KGProductDetailsModel;
@interface KGProductDetailsHeadView : KGBaseView
@property (nonatomic,retain)UIImageView   * KVProductImageView;
-(void)updateView:(KGProductDetailsModel *)model;
@end
///**
// *  Description
// */
//@interface KGNewProductDetailsHeadView : KGProductDetailsHeadView
//
//@end
///**
// *  Description
// */
//@interface KGHotProductDetailsHeadView : KGProductDetailsHeadView
//
//@end
///**
// *  Description
// */
//@interface KGTodayProductDetailsHeadView : KGProductDetailsHeadView
//
//@end
