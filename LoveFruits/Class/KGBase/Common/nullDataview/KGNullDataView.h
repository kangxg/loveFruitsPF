//
//  KGNullDataView.h
//  LoveFruits
//
//  Created by kangxg on 2016/10/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGNullDataView : KGBaseView
@property(strong,nonatomic)UIImageView * nvllDataImage;
@property(strong,nonatomic)UILabel * contentLabel;

+(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString*)imageName Click:(BOOL)click;

-(void)setShowContent:(NSString * )content;

-(void)dissmissMyself;
@end
