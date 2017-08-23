//
//  KGMyOrderTableCell.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseTableViewCell.h"
#import "KGOrderModel.h"
@interface KGMyOrderTableCell : KGBaseTableViewCell
@property (nonatomic,retain)UILabel   * KVOrderNumLabel;
@property (nonatomic,retain)UILabel   * KVOrderTypeLabel;
@property (nonatomic,retain)UILabel   * KVOrderPayCountLabel;
@property (nonatomic,retain)UIScrollView   * KVOrderWareView;
@property (nonatomic,weak)KGOrderModel     * KVModel;

-(void)createLabelView;

-(void)createImageView;

-(void)createButtonView;

-(void)createOtherView;


@end


@interface KGWillPayOrderTableCell : KGMyOrderTableCell

@end

@interface KGWillSendOrderTableCell : KGMyOrderTableCell

@end


@interface KGWillReciveOrderTableCell : KGMyOrderTableCell

@end


@interface KGOverOrderTableCell : KGMyOrderTableCell

@end


@interface KGCancelOrderTableCell : KGOverOrderTableCell

@end


@interface KGInvalidOrderTableCell : KGOverOrderTableCell

@end


