//
//  KGNoLogView.h
//  LoveFruits
//
//  Created by kangxg on 2016/10/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"
#import "DefineBlock.h"
@interface KGNoLogView : KGBaseView
@property(strong,nonatomic)UIImageView * nvllDataImage;
@property(strong,nonatomic)UILabel * contentLabel;
@property(strong,nonatomic)UIButton    * logButton;

+(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString*)imageName WithBlock:(KGCallbackBlock )block;
-(void)createWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block;


-(void)setShowContent:(NSString * )content;

-(void)dissmissMyself;
@end
