//
//  KGHomeHotCommodityListVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeHotCommodityListVCTR.h"
#import "KGHotProductDetailsVCTR.h"
@implementation KGHomeHotCommodityListVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"热门商品";
    self.KVHeadImageView.image = [UIImage imageNamed:@"hot-banner"];
}

-(void)pClickBuy:(id)object
{
    if (object)
    {
        KGHotProductDetailsVCTR * vctr = [[KGHotProductDetailsVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
}
@end
