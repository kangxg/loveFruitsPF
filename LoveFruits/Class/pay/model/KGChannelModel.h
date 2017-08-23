//
//  KGChannelModel.h
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGBaseModel.h"
#import "BCPayConstant.h"
@interface KGChannelModel : KGBaseModel
@property (nonatomic,assign)PayChannel         KDPayChannel;
@property (nonatomic,copy)NSString          *  KDImg;
@property (nonatomic,copy)NSString          *  KDTitle;
@property (nonatomic,copy)NSString          *  KDContent;
@end
