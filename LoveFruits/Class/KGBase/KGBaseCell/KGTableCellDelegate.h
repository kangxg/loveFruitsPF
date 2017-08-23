//
//  KGTableCellDelegate.h
//  LoveFruits
//
//  Created by kangxg on 16/9/10.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGEnum.h"
@protocol KGTableCellDelegate <NSObject>
@optional
-(void)pClickBuy:(id)object;

-(void)pClickGoodClass:(NSString *)pid;

-(void)pSelectedView:(id)sender withInfo:(NSDictionary * )info ;


-(void)pClickViewOperation:(KGFunctionOperation) operation withInfo:(NSDictionary * )info;


-(void)pClickViewOperation:(id)sender operation:(KGFunctionOperation) operation withInfo:(NSDictionary * )info;
@end
