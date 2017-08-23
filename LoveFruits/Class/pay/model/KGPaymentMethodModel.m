//
//  KGPaymentMethodModel.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPaymentMethodModel.h"
#import "BCNetworking.h"
#import "BCPayConstant.h"
#import "KGChannelModel.h"
@implementation KGPaymentMethodModel
@synthesize KDChannelList = _KDChannelList;
-(id)init
{
    if (self = [super init])
    {
        [self initChannel];
    }
    return self;
}

-(void)initChannel
{
    _KDChannelList = [[NSMutableArray alloc]init];
    _KDChannelName  = @"支付方式";
    NSArray *live = @[@{@"sub":@(PayChannelWxApp), @"img":@"wx", @"title":@"微信支付",@"content":@"用微信支付，安全便捷"},
                      
                      @{@"sub":@(PayChannelAliApp), @"img":@"ali", @"title":@"支付宝",@"content":@"支持有支付宝，网银用户使用"},
                      
                      ];
    
    for (int i = 0; i< live.count; i++)
    {
        KGChannelModel * model = [[KGChannelModel alloc]init];
        [model putInDataFordic:live[i]];
        [_KDChannelList addObject:model];
    }
   
}


@end
