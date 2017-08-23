//
//  KGMainAD.m
//  LoveFruits
//
//  Created by kangxg on 16/4/28.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMainAD.h"
#import "KGDicModelManager.h"
#import "GlobelDefine.h"
#import "KGBaseNetworkService.h"

@interface KGMainAD()<KGDictModelProtocol>

@end
@implementation KGMainAD
@synthesize code = _code;

@synthesize msg  = _msg;


+(void)loadADData:(void (^)(NSArray * data, NSError * error))completion
{
 

    NSDictionary  * dic = @{@"splash_type":@"zwsjapp"};
    [KGBaseNetworkService POST:URL(KGBaseUrl, @"/course_api/splash")
                        params:dic
                       success:^(id object)
     {
         NSMutableDictionary * jsonDic = nil;
         if ([object isKindOfClass:[NSDictionary class]]) {
             jsonDic = object;
         }
         else
         {
             jsonDic=[NSJSONSerialization JSONObjectWithData:object options:0 error:nil];
         }
         
         
         float sucess = [[jsonDic objectForKey:@"status"] boolValue];
         
         if (sucess)
         {
             
             NSArray  * arr  =    [jsonDic valueForKey:@"data"];
             NSArray  * resultArr = [KGMainAD loadADModelData:arr];
             completion(resultArr,nil);
         }
         else
         {
             
         }
         
     }
     
       failed:^(id object)
     {
         
         
     }];
    

}
+(NSArray<AD *> *)loadADModelData:(NSArray *)arr
{
    NSMutableArray * modelArr = [[NSMutableArray alloc]init];
    for (NSDictionary  * dic  in arr)
    {
        AD * ad = [[AD alloc]init];
        [ad putInDataFordic:dic];
        [modelArr addObject:ad];
    }
    
    return modelArr;
}

-(id)init
{
    if (self == [super init])
    {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return self;
}
+(NSDictionary *)customClassMapping
{
    //@[@{@"data":NSStringFromClass([AD class])}]
    return @{@"data":NSStringFromClass([AD class])};
}
@end

@implementation AD
@synthesize title      = _title;
@synthesize img_name   = _img_name;
@synthesize starttime  = _starttime;
@synthesize endtime    = _endtime;
@synthesize picOrder   = _picOrder;

-(BOOL)putInDataFordic:(id)data
{
    if (data)
    {
        NSDictionary * dic = data;
        _title             = [dic valueForKey:@"pic_title"];
        _img_name          = [dic valueForKey:@"pic_url"];
        _picOrder          = [[dic valueForKey:@"pic_order"] integerValue];
        return YES;

    }
    return false;
}
@end
