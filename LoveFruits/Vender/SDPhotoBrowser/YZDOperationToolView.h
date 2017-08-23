//
//  YZDOperationToolView.h
//  YZJOB-2
//
//  Created by kangxg on 15/9/29.
//  Copyright (c) 2015年 lfh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZDOperationToolView : UIView
/**
 *  Description 选择列表 视图初始化方法
 *
 *  @param title 视图title
 *  @param arr   列表显示的数据字符串数组
 *  @param frame 视图显示区域
 *  @param block 视图操作后的操作代码块 取消按钮tag 值为0 其他操作选项tag 从1开始
 *
 *  @return 视图类
 */
-(id)initWithTitle:(NSString *)title withBodyData:(NSArray *)arr withFrame:(CGRect)frame withBackBlock:(void (^)(NSInteger tag))block ;
/**
 *  Description 视图显现方法
 *
 *  @param view 将视图添加到的父视图
 */
-(void)showInView:(UIView *)view;
/**
 *  Description 视图显示方法 调用此方法会讲视图添加到UIApplication的keyWindow（UIWindow类型）中 ;
 */
-(void)show;
@end
