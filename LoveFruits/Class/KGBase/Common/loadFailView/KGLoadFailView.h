//
//  KGLoadFailView.h
//  LoveFruits
//
//  Created by kangxg on 2016/10/22.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGNoLogView.h"

@interface KGLoadFailView : KGNoLogView
-(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block;
@end
