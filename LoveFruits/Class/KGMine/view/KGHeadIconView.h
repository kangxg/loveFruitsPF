//
//  KGHeadIconView.h
//  LoveFruits
//
//  Created by kangxg on 2016/10/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGHeadIconView : KGBaseView
-(id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName;
-(void)setSelectButtonNomal;
-(UIImage *)selectedImage;
@end
