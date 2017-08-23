//
//  KGProductsViewController.h
//  LoveFruits
//
//  Created by kangxg on 16/5/16.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAnimationViewController.h"
#import "DefineBlock.h"
@class KGSupermarket;
@class KGGoods;
@class LFBTableView;
@protocol  ProductsViewControllerDelegate<NSObject>
@optional
-(void)didEndDisplayingHeaderView:(NSInteger )section;
-(void)willDisplayHeaderView:(NSInteger )section;
@end

@interface KGProductsViewController : KGAnimationViewController
@property (nonatomic,weak)id<ProductsViewControllerDelegate> KGDelegate;
@property (nonatomic,retain)NSArray<NSArray <KGGoods *>*> * KGGoodsArr;
@property (nonatomic,retain)KGSupermarket      *   KGSupermarketData;
@property (nonatomic,assign)NSIndexPath        *   KGCategortsSelectedIndexPath;
@property (nonatomic,retain)LFBTableView       *   KGTableView;
@property (nonatomic,copy)KGNomolBlock KGBlock;

-(void)reloadViews:(NSString *)pid;
@end
