//
//  KGLoginVCTR.h
//  LoveFruits
//
//  Created by kangxg on 16/9/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHaveNavViewVCTR.h"

@interface KGLoginVCTR : KGHaveNavViewVCTR
-(void)pressReginBtnCallback;
-(void)gotoHomePage;
-(void)enterLogSuccess;
@end

@interface KGStartSceneLoginVCTR : KGLoginVCTR

@end


@interface KGPresentLoginVCTR : KGLoginVCTR

@end



