//
//  KGSuperOneLevelView.h
//  LoveFruits
//
//  Created by kangxg on 16/9/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"
#import "KGOneLeveViewDelegate.h"
#import "KGOneLeveSourceDelegate.h"
@interface KGSuperOneLevelView : KGBaseView
@property (nonatomic,weak)id<KGOneLeveSourceDelegate>  KGSourceDelegate;
@property (nonatomic,weak)id<KGOneLeveViewDelegate>    KGViewDelegate;

-(void)reloadData;
@end
