//
//  KGMineViewGroup.h
//  LoveFruits
//
//  Created by kangxg on 16/9/19.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KGMineViewDeletate <NSObject>

-(void)selectedMyViewControllerIndex:(NSString *)titleName;


@optional

//C端
-(void)clickBtnIndex:(NSInteger)index;




@end


@interface KGMineViewGroup : NSObject
+(instancetype)initWithSuperView:(UIView*)superview frame:(CGRect)frame dataArr:(NSMutableArray*)dataArr delegate:(id<KGMineViewDeletate>)delegate;
//设置头部四个按钮名称和显示的数量
-(void)setTopNameArr:(NSArray*)nameArr countArr:(NSArray*)countArr;

-(void)setHeadView:(UIView*)headView;

-(void)dissMissMyHeadView;

-(void)resetCouponView:(NSInteger)count;
@end
