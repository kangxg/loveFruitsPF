//
//  KGGoodsModelInterface.h
//  LoveFruits
//
//  Created by kangxg on 16/9/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KGGoodsModelInterface <NSObject>
@optional

// 商品ID
@property (nonatomic,copy)NSString * pid;

/// 当前价格
@property (nonatomic,copy)NSString * price;


// 商品姓名
@property (nonatomic,copy)NSString * name;


/// urlStr
@property (nonatomic,copy)NSString * img;

/// 瓶 单位
@property (nonatomic,copy)NSString * spec;

@property (nonatomic,assign)BOOL  isSelected;
//---------------------------------------------
// 商品ID
@property (nonatomic,copy)NSString * mid;
@property (nonatomic,copy)NSString * brand_id;
// 超市价格
@property (nonatomic,copy)NSString * market_price;
@property (nonatomic,copy)NSString * cid;
@property (nonatomic,copy)NSString * category_id;
/// 当前价格
@property (nonatomic,copy)NSString * partner_price;
@property (nonatomic,copy)NSString * brand_name;
@property (nonatomic,copy)NSString * pre_img;
@property (nonatomic,copy)NSString * pre_imgs;

/// 参数
@property (nonatomic,copy)NSString * specifics;

@property (nonatomic,copy)NSString * product_id;

@property (nonatomic,copy)NSString * dealer_id;

/// 库存
@property (nonatomic,copy)NSNumber * number;
/// 买一赠一
@property (nonatomic,copy)NSString * pm_desc;
@property (nonatomic,copy)NSNumber * had_pm;

/// 是不是精选 0 : 不是, 1 : 是
@property (nonatomic,copy)NSNumber * is_xf;
//*************************商品模型辅助属性**********************************
// 记录用户对商品添加次数

@property (nonatomic,copy)NSNumber * userBuyNumber;
@end
