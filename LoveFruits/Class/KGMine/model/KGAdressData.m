//
//  KGAdressData.m
//  LoveFruits
//
//  Created by kangxg on 16/5/12.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGAdressData.h"
#import "KGDicModelManager.h"
@interface KGAdressData()<KGDictModelProtocol>
@property (nonatomic,assign)NSInteger   code;
@property (nonatomic,copy)  NSString  * msg;

@end

@implementation KGAdressData
-(id)init
{
    if (self = [super init])
    {
        _code = -1;
        
    }
    return self;
}

+(NSDictionary *)customClassMapping
{
    return @{@"data":NSStringFromClass([Address class])};
}

+(void)loadData:(void (^)(id<KGModelInterface> data, NSError * error))completion
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"MyAdress" ofType:nil];
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
@end


@implementation Address


@end