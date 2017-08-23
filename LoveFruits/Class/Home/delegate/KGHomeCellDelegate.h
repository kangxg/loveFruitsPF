//
//  KGHomeCellDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/10/5.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KGHomeCellDelegate <NSObject>
@optional
-(void)pGotoActivty:(NSString *)detailSting withTitle:(NSString *)title;
@end
