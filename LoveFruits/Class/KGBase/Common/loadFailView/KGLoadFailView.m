//
//  KGLoadFailView.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/22.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGLoadFailView.h"

@implementation KGLoadFailView
-(instancetype)initWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        [self createWithSuperView:superView frame:frame imageName:imageName WithBlock:block];
    }
    return self;
}
-(void)createWithSuperView:(UIView *)superView frame:(CGRect)frame imageName:(NSString *)imageName WithBlock:(KGCallbackBlock)block
{

    if (!imageName.length)
    {
        imageName = @"Load_Fail";
    }
    [super createWithSuperView:superView frame:frame imageName:imageName WithBlock:block];
    self.contentLabel.text = @"加载失败，请重新加载～";
  
    [self.logButton setTitle:@"刷新加载" forState:UIControlStateNormal];

}

@end
