//
//  KGBaseView.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGBaseViewDelegate.h"
@interface KGBaseView : UIView
@property (nonatomic,weak)id<KGBaseViewDelegate> KVDelegate;
@end
