//
//  KGPersonalCenterVCTR.h
//  LoveFruits
//
//  Created by kangxg on 2016/10/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"

@interface KGPersonalCenterVCTR : KGHaveNavViewVCTR
@property (nonatomic,retain)UITextField                * MVHeadNameTf;
@property (nonatomic,retain)UIImageView                * MVHeadImage;
-(void)createBgView;
-(void)createPersonalIconView;
-(void)createPersonalNameView;
@end


@interface KGPersonalCenterSettingVCTR : KGPersonalCenterVCTR

@end



@interface KGPersonalCenterEditVCTR : KGPersonalCenterVCTR

@end
