//
//  KGGuideCell.h
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGGuideCell : UICollectionViewCell
@property(nonatomic,retain)UIImageView * KGImageView;
-(void)setNextButtonHidden:(BOOL)hidden;
@end
