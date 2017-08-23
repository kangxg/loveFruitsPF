//
//  YZNetworkRequestHelpEnum.h
//  YZJOB-2
//
//  Created by kangxg on 16/2/18.
//  Copyright © 2016年 lfh. All rights reserved.
//

/**
 *  Description  网络请求辅助管理 枚举文件
 */
#ifndef YZNetworkRequestHelpEnum_h
#define YZNetworkRequestHelpEnum_h
/**
 *  Description   数据model 处理数据状态
 */
typedef NS_ENUM(NSInteger, YZProcessingDataState)
{
    /**
     *  Description   未处理状态
     */
    YZPROCESSINGDATANONE = 0x00000,
    /**
     *  Description   处理错误
     */
    YZPROCESSINGDATAERROR,
    /**
     *  Description   处理失败
     */
    YZPROCESSINGDATAFAILT,
    /**
     *  Description   数据为空
     */
    YZPROCESSINGDATANULL,
    /**
     *  Description   处理成功
     */
    YZPROCESSINGDATASUCCESS,
    
};
typedef NS_ENUM(NSInteger,YZNetworkRequestType)
{


    YNETWORKREQUESTHELPENONE   = 0x00,
    //get
    YNETWORKHELPEGETREQUEST,
    //post
    YNETWORKHELPEPOSTREQUEST,
    //上传视频和封面
    YNETWORKHELPEUPLOADVIDEO,
    //上传单张图片
    YNETWORKHELPEUPLOADSIGLEIMAGE,
    //上传多张图片
    YNETWORKHELPEUPLOADMOREIMAGE,
    //上传文件
    YNETWORKHELPEUPLOADFILE,
    //上传最大值
    YNETWORKHELPEUPLOADMAX ,
    // This separator style is only supported for grouped style table views currently
};


typedef NS_ENUM(NSInteger,YZNetworkRequestVerification)
{
    
    
    YZNETWORKVERIFICATIONNONE   = 0x00,
    YZNETWORKVERIFICATIONFIR    = 1<<0,
    YZNETWORKVERIFICATIONSEC    = 1<<1,
    YZNETWORKVERIFICATIONTHI    ,
    YZNETWORKVERIFICATIONFOU    ,
    YZNETWORKVERIFICATIONFIF    ,
    YZNETWORKVERIFICATIONSIX    ,
    YZNETWORKVERIFICATIONSEV    ,
    YZNETWORKVERIFICATIONEIG    ,
    YZNETWORKVERIFICATIONMAX    ,
    // This separator style is only supported for grouped style table views currently
};


#define KG_INLINE static inline
/**
 *  Description
 */
typedef NS_ENUM(NSInteger,YZNetOperationType)
{
    /**
     *  Description
     */
    YZNETOPERATIONTYPENONE   = 0x00,
    /**
     *  Description 数据请求
     */
    YZNETOPERATIONTYPEREQUEST,
    /**
     *  Description  删除操作
     */
    YZNETOPERATIONTYPDELETE ,
    
    YZNETOPERATIONTYPADD,
    /**
     *  Description 其他操作
     */
    YZNETOPERATIONTYPOTHER ,
    // This separator style is only supported for grouped style table views currently
};
typedef struct YZRequestOptions
{
    //是否需要显示加载视图
    BOOL  hasLoad;
    //是否需要请求失败任务缓存
    BOOL  hasFailCache;
    //请求类型
    YZNetOperationType   requestType;
} YZRequestOptions;

KG_INLINE YZRequestOptions
YZRequestOptionMake(BOOL hasLoad,BOOL hasCache,YZNetOperationType type)
{
    YZRequestOptions option;
    option.hasLoad = hasLoad;
    option.requestType = type;
    option.hasFailCache = hasCache;
    return option;
}

#endif /* YZNetworkRequestHelpEnum_h */
