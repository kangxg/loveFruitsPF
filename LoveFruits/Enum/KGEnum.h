//
//  KGEnum.h
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#ifndef KGEnum_h
#define KGEnum_h

typedef NS_ENUM(NSInteger, KGGoodsAdsType)
{
  
    KGGOODSADSTYPENORMAL = 0x000,
    KGGOODSADSTYPEFIRST,
    KGGOODSADSTYPESECOND,
    KGGOODSADSTYPETHIRD,
    KGGOODSADSTYPEFOURCH,
    
    
};
typedef NS_ENUM(NSInteger, KGShopCarEditType)
{
    //未开始拉流
    KGSHOPCARTYPENORMAL = 0x000,
    KGSHOPCARTYPEDELETE,
   
    
};


typedef NS_ENUM(NSInteger, KGUserAuditState)
{
    //未开始拉流
    KGUSERAUDITSTATEUNINFO= -1,
    KGUSERAUDITSTATENONE = 0x000,
    //验证成功已完善资料
    KGUSERAUDITSTATESUCCESS,
    //验证成功已完善资料未审核
    KGUSERAUDITSTATEINTHEREVIEW,
    //验证成功未完善资料
    KGUSERAUDITSTATENOTPERFECT,
    
};
typedef NS_ENUM(NSInteger, KGNavItemButtonType)
{
    //未开始拉流
    KGNAVITEMBUTTONTYPENONE = 0x000,
    KGNAVITEMBUTTONTYPELEFT,
    KGNAVITEMBUTTONTYPERIGHT
    
};


typedef NS_ENUM(NSInteger,KGFunctionOperation)
{
    KGOPRERATIONNONE      = 0,
    /**
     *  Description  添加操作
     */
    KGOPRERATIOAADD, //1
    /**
     *  Description  删除操作
     */
    KGOPRERATIODELETE, //2
    /**
     *  Description  OpenImage
    */
    KGOPRERATIOOPENIMAGE,
    /**
     *  Description  Hidden
     */
    KGOPRERATIOOPENHIDDEN ,
    /**
     *  Description  确认操作
     */
    KGOPERATIONENTER,
    
    /**
     *  Description  取消
     */
    KGOPERATIONCANNEL,
    
    /**
     *  Description  支付操作
     */
    KGOPERATIONPAY,
    
    
//    KGOperationScroll,
    // This separator style is only supported for grouped style table views currently
};
#endif /* KGEnum_h */
