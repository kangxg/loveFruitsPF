//
//  KGHomeNewCommodityListVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeNewCommodityListVCTR.h"
#import "KGNewProductDetailsVCTR.h"
@implementation KGHomeNewCommodityListVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"新品推荐";
    self.KVHeadImageView.image = [UIImage imageNamed:@"new-0banner"];
    
}

-(void)pClickBuy:(id)object
{
    if (object)
    {
        KGNewProductDetailsVCTR * vctr = [[KGNewProductDetailsVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
}
@end
