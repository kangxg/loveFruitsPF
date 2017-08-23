//
//  KGDicModelManager.m
//  LoveFruits
//
//  Created by kangxg on 16/4/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGDicModelManager.h"
#import <objc/runtime.h>
#import "GlobelDefine.h"
#import <UIKit/UIKit.h>
#import "NSDictionary+merge.h"
@interface KGDicModelManager()
{
    NSMutableDictionary *  _mModelCache;
}
@end

@implementation KGDicModelManager

+(KGDicModelManager *)shareManager
{
    static KGDicModelManager * instace = nil;
    static dispatch_once_t onceManager;
    dispatch_once(&onceManager, ^{
        instace = [[KGDicModelManager alloc]init];
    });
    
    return instace;
    
}
-(id)init
{
    if (self = [super init])
    {
        _mModelCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(id)objectWithDictionary:(NSDictionary *)dic withcls:(Class )anyclass
{
//    {
//        code = 0;
//        data =     {
//            endtime = 1454255999;
//            "img_big_name" = "http://img01.bqstatic.com/upload/activity/2016011111271981.jpg";
//            "img_name" = "http://img01.bqstatic.com/upload/activity/2016011111271995.jpg";
//            "img_url" = "";
//            starttime = 1450409894;
//            title = "";
//        };
//        msg = success;
//    }
//    NSString * ns = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    //LoveFruits
    NSDictionary * infoDict = [self fullModelInfo:anyclass];
//       {
//    code = "";
//    data = AD;
//    debugDescription = "";
//    description = "";
//    hash = "";
//    msg = "";
//    superclass = "";
//}
    NSObject * obj = [[anyclass alloc]init];
    @autoreleasepool
    {
        [infoDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull k, id  _Nonnull v, BOOL * _Nonnull stop) {
            if ([k isEqualToString:@"desc"])
            {
                NSString * newValue = dic[@"description"];
                [obj setValue:newValue forKey:@"desc"];
            }
            
            id value = dic[k];
            if (value)
            {
                
                if (v == [NSNull null])
                {
                    if ([k isEqualToString:@"number"] && ScreenWidth <375)
                    {
                        [obj setValue:value forKey:k];
                    }
                    else
                    {
                        [obj setValue:value forKey:k];
                    }
                }
                else
                {
//                    Class type = [value classForCoder];
                    if ([value isKindOfClass:[NSDictionary class]])
                    {
//                        NSClassFromString([ns stringByAppendingFormat:@"%@.%@",ns,v]
                        id subObj = [self objectWithDictionary:(NSDictionary *)value withcls:NSClassFromString(v)];
                        if (subObj)
                        {
                            [obj setValue:subObj forKey:k];
                        }
                    }
                    else if([value isKindOfClass:[NSArray class]])
                    {
                        id subObj = [self objectsWithArray:(NSArray *)value withcls:NSClassFromString(v)];
                       
                        if (subObj)
                        {
                            [obj setValue:subObj forKey:k];
                        }

                    }
                }
            }
        }];
    }
    return obj;
}

-(NSArray *)objectsWithArray:(NSArray * )array withcls:(Class )anyclass
{
    NSMutableArray * list = [NSMutableArray new];
    @autoreleasepool
    {
        for (id value in array)
        {
//            id type = [value classForCoder];
            if ([value isKindOfClass:[NSDictionary class]])
            {
                id subObje = [self objectWithDictionary:(NSDictionary *)value withcls:anyclass];
                if (subObje)
                {
                    [list  addObject:subObje];
                }
                
            }else if ([value isKindOfClass:[NSArray class]])
            {
                id subObje = [self objectsWithArray:(NSArray *)value withcls:anyclass];
                if (subObje)
                {
                    [list  addObject:subObje];
                }
            }
        }
    }
    if (list.count>0)
    {
        return list;
    }
    else
    {
        return nil;
    }
    return list;
}
-(NSDictionary *)fullModelInfo:(Class)anyClass
{

    NSDictionary * cache = [_mModelCache objectForKey:NSStringFromClass(anyClass)];
    if (cache)
    {
        return cache;
    }
    
    Class currentCls = anyClass;//KGMainAD
    NSMutableDictionary * infoDict = [NSMutableDictionary new];
     [infoDict addEntriesFromDictionary:[self modelInfo:currentCls]];
    Class parent  = [currentCls superclass];
    while (parent)
    {
        [infoDict merge:[self modelInfo:currentCls]];
      
         currentCls = parent;
        parent =[currentCls superclass];
    }

    [_mModelCache setObject:infoDict forKey:NSStringFromClass(anyClass)];
    return infoDict;
}

-(NSDictionary *)modelInfo:(Class)cls
{
     //KGMainAD
      NSDictionary * cache = [_mModelCache objectForKey:NSStringFromClass(cls)];
      if (cache)
      {
        return cache;
      }
      UInt32 count = 0;//5
      objc_property_t  * properties= class_copyPropertyList(cls, &count);
    NSLog(@"count = %d",count);
    NSDictionary * mappingDict;
    if ([cls respondsToSelector:@selector(customClassMapping)])
    {
       mappingDict = [cls customClassMapping];
    }
    //{data = AD};

    NSMutableDictionary * infoDict = [NSMutableDictionary new];
    for (int i = 0; i<count; i++)
    {
        objc_property_t property = properties[i];
        NSString * name = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding ];//KGData
        NSLog(@"name = %@",name);
        
         NSString * type = [mappingDict objectForKey:name]?:[NSNull null];
         NSLog(@"type = %@",type);
       
        [infoDict setValue:type forKey:name];
        //
   
    }
    
    free(properties);
    [_mModelCache setObject:infoDict forKey:NSStringFromClass(cls)];
    return infoDict;
}
@end
