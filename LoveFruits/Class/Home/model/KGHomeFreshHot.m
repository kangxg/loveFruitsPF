//
//  KGHomeFreshHot.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeFreshHot.h"
@interface KGHomeFreshHot()
@property (nonatomic,assign)NSInteger     page;
@property (nonatomic,assign)NSInteger     code;
@property (nonatomic,copy)NSString    *   msg;

@end

@implementation KGHomeFreshHot
+(void)loadData:(void (^)(id<KGModelInterface> data, NSError * error))completion
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"首页新鲜热卖" ofType:nil];
    if (path)
    {
        id data =  [NSData dataWithContentsOfFile:path];
        
        if (data != nil)
        {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            KGDicModelManager * modelTool = [KGDicModelManager shareManager];
            id  da = [modelTool objectWithDictionary:dict withcls:[self class]];
            completion(da,nil);
        }
    }

}

+(NSDictionary *)customClassMapping
{
    return @{@"data":NSStringFromClass([KGGoods class])};
}

@end

@implementation KGGoods

-(id)init
{
    if (self = [super init])
    {
        _number = [NSNumber numberWithInteger:-1];
        _had_pm = [NSNumber numberWithInteger:-1];
        _is_xf  = [NSNumber numberWithInteger:0];
        _userBuyNumber = [NSNumber numberWithInteger:0];
    }
    return self;
}
@end