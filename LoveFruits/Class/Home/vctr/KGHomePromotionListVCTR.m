//
//  KGHomePromotionListVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/9/9.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomePromotionListVCTR.h"
#import "KGTodyProductDetailsVCTR.h"
@implementation KGHomePromotionListVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"近日促销";
    self.KVHeadImageView.image = [UIImage imageNamed:@"today-banner"];
}

-(void)pClickBuy:(id)object
{
    if (object)
    {
        KGTodyProductDetailsVCTR * vctr = [[KGTodyProductDetailsVCTR alloc]init];
        [self.navigationController pushViewController:vctr animated:YES];
    }
}
@end
