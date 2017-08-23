//
//  DefineBlock.h
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#ifndef DefineBlock_h
#define DefineBlock_h
#import <UIKit/UIKit.h>
#import "YZNetworkRequestHelpEnum.h"
//#import "KGModelInterface.h"
typedef void (^ KGImageClick)(NSInteger index);

typedef void (^ KGNomolBlock)();

typedef void (^ KGAddButtonClick) (UIImageView * imageView);
//

typedef void (^ KGRequestSuccessBlock)(id  object);

typedef void (^ KGRequestFaildBlock)(id  object);

typedef void (^ KGCallbackBlock)(id  object);

typedef void (^ KGButtonClickBlock)(UIButton  * button);

typedef void (^ KGPutDataBlock)(YZProcessingDataState state);

typedef void (^ KGPutDataTypeBlock)(YZProcessingDataState state,NSInteger type);


typedef void (^ KGPutDataMessageBlock)(YZProcessingDataState state,NSString  * message);

typedef void (^ KGSelectCouponBlock)(NSDictionary * dic);
#endif /* DefineBlock_h */
