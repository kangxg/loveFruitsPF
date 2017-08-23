//
//  KGHomeHeadResources.m
//  LoveFruits
//
//  Created by kangxg on 16/5/6.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHomeHeadResources.h"


@implementation KGHomeHeadResources

+(void)loadHomeHeadData:(void (^)(KGHomeHeadResources *, NSError *))completion
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType:nil];
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
    return @{@"data":NSStringFromClass([HeadData class])};
}
@end


@implementation Activities

-(BOOL)putInDataFordic:(id)data
{
    if (data ==nil)
    {
        return false;
    }
    NSDictionary * dic = data;
    _img   = [dic valueForKey:@"imgUrl"];
    _pid   = [dic valueForKey:@"id"];
    _name  = [dic valueForKey:@"name"];
    _detailUrl  = [dic valueForKey:@"detailUrl"];
    _desc = [dic valueForKey:@"description"];
    return YES;
}

@end

@implementation HeadData
@synthesize icons = _icons;
@synthesize focus = _focus;
-(id)init
{
    if (self = [super init])
    {
        _icons = [[NSMutableArray alloc]init];
        _focus = [[NSMutableArray alloc]init];
    }
    return self;
}

-(BOOL)putInDataForArr:(id)data
{
    if (!data)
    {
        return false;
    }
    NSArray * arr = data;
    for (NSDictionary * dic in arr)
    {
        Activities * ac = [[Activities alloc]init];
        if ([ac putInDataFordic:dic])
        {
            [_focus addObject:ac];
        }
    }
    return YES;
}
+(NSDictionary *)customClassMapping
{
    return @{@"focus":NSStringFromClass([Activities class]),@"icons":NSStringFromClass([Activities class]),@"activities":NSStringFromClass([Activities class])};
}

@end