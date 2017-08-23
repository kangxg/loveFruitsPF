//
//  KGSearchGoodsListView.h
//  LoveFruits
//
//  Created by kangxg on 16/9/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseView.h"

@interface KGSearchGoodsListView : KGBaseView
-(void)refreshUIWithArr:(NSMutableArray*)arr;
-(void)dissmissMyself;
-(void)endRefreshFooter:(BOOL)noNext;
@end
