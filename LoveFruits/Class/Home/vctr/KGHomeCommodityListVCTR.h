//
//  KGHomeCommodityListVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//
/**
 *  Description 首页商品展示列表控制器
 */
#import "KGHaveNavViewVCTR.h"
#import "KGHomeCommodityCellModel.h"
#import "KGHomeCommodityViewModel.h"
#import "KGTableCellDelegate.h"
@interface KGHomeCommodityListVCTR : KGHaveNavViewVCTR<UITableViewDelegate,UITableViewDataSource,KGTableCellDelegate>
@property (nonatomic,retain)KGHomeCommodityViewModel   * KModel;
@property (nonatomic,retain)UIImageView                * KVHeadImageView;
@property (nonatomic,retain)UITableView                * KVTableView;
@property (nonatomic,retain)UIButton                   * KVShopCarBtn;
@end
