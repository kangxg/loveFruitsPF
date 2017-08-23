//
//  KGHomeTableHeadView.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGHomeTableHeadViewDelegate.h"
@class KGHomeHeadResources;
@class HeadData;
@interface KGHomeTableHeadView : UIView
@property (nonatomic,assign)id<KGHomeTableHeadViewDelegate>  KGDelegate;
@property (nonatomic,assign)CGFloat  KGTableHeadViewHeight;
@property (nonatomic,retain)KGHomeHeadResources  * KGHeadData;
-(void)resetHotViews:(HeadData *)data;
-(void)resetPageViews:(HeadData *)data;

@end
