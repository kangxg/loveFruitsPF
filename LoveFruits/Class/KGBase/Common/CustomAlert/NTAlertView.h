//
//  NTBaseAlertView.h
//  test
//
//  Created by kangxiaoguang on 14/11/3.
//  Copyright (c) 2014年 kangxiaoguang. All rights reserved.
//

/////////////////////////////////////////////////////////////////////////////
//1.提示框视图
//2.分为三大类，基本提示框 和 自定义提示框
//3.基本提示框包括：小的提示框和大的提示框 ，大小提示框只做视图内的坐标、大小、颜色等操作，
//  对枚举值进行样式判断在父类进行操作
//4.自定义提示框：子类继承后刻按照自己的实际需求进行操作，值有业务逻辑和动画在此类实现
/////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NTAlertType)
{
    EN_NTAlertViewTypeBase = 0x00000,
    EN_NTAlertViewTypeSmallBase = 1<<0,
    EN_NTAlertViewTypeChangeBankCard= 0<<1,
    EN_NTAlertViewTypeCustom,
};

typedef NS_ENUM(NSInteger, NTAlertViewStyle)
{
    EN_NTAlertViewStyleNone = 0,
    EN_NTAlertViewStyleTitleLine       = 1 << 0,
    EN_NTAlertViewStyleBorder          = 1 << 1,
    EN_NTAlertViewStyleCorner          = 1 << 2,
    EN_NTAlertViewStyleBackGroundImage = 1 << 3,
    EN_NTAlertViewStyleMessLeft        = 1 << 4,
    EN_NTAlertViewStyleMessCenter      = 1 << 5,
    EN_NTAlertViewStyleMessRight       = 1 << 6,
};

typedef struct
{
    NTAlertType EN_NTAlertViewType;
    NTAlertViewStyle EN_NTAlertViewStyle;
}NTALERT_STRUCT;


/////////////////////////////////////////////////////////////////////////////
//提示框按钮回调协议
/////////////////////////////////////////////////////////////////////////////

@protocol NTAlertViewDelegate <NSObject>
@optional

-(void)NTAlertViewCallBack:(NSInteger)tag;
-(void)NTAlertViewCallBackWithText:(NSString *)text WithTag:(NSInteger)tag;

-(void)NTAlertViewCallBack:(id)sender   WithTag:(NSInteger)tag;
@end


/////////////////////////////////////////////////////////////////////////////
//1.提示框总父类
//2.只在init中赋值样式枚举值 和 调用 initdata、initView两个函数
//3.其他函数不实现任何功能
/////////////////////////////////////////////////////////////////////////////

@interface NTAlertView : UIView
{
      //提示框背景图
      UIImageView * m_ImageView;
      //确定按钮
      UIButton    * m_EnterBt;
      //取消按钮
      UIButton    * m_CancelBt;
      //头部说明文字
      UILabel     * m_title;
      //提示框  说明文字
      UILabel     * m_bodyMessage;
      //提示框主体视图
      UIView      * m_BodyView;
      //title 下划线
      UILabel     * m_titleline;
      //视图样式
      NTAlertViewStyle m_style;
}

@property(nonatomic,retain)UIButton * NTALertEnterButton;
@property(nonatomic,retain)UIButton * NTALertCancelButton;
@property(nonatomic,assign)id<NTAlertViewDelegate>NTAlertDelegate;
@property(nonatomic,retain)UIImageView* NTAlertImageView;
@property(nonatomic,retain)UIView   * NTAlertBodyView;
@property(nonatomic,retain)UILabel  * NTALertTitle;
@property(nonatomic,retain)UILabel  * NTAlertBodyMessage;


+(id)createAlertView:(NTAlertViewStyle)Type;
+(id)createAlertView;
-(id)initAlertView:(NTAlertViewStyle)Type;
-(void)initData;
-(void)initView;
//显示视图
-(void)ShowView;
//创建提示框主体视图
-(void)createBodyView;
//创建提示框主体背景图
-(void)createbodyImageView;
//创建按钮
-(void)createButton;
//创建文字
-(void)createLable;
//创建头部说明文字
-(void)createTitleView;
//创建主体视图提示文字
-(void)createBodyMessageView;

-(void)removeView;
@end
/////////////////////////////////////////////////////////////////////////////
//基本视图
/////////////////////////////////////////////////////////////////////////////

@interface NTBaseAlertView : NTAlertView

@end

//-------------------------------小视图-------------------------------------------//
@interface NTSmallAlertView :NTBaseAlertView

@end

//--------------------------------大视图------------------------------------------//
@interface NTBigAlertView : NTBaseAlertView

@end

/////////////////////////////////////////////////////////////////////////////
//自定义视图父类
/////////////////////////////////////////////////////////////////////////////
@interface NTCustomAlertView : NTAlertView
-(void)CallbackFromEnterButton:(UIButton *)sender;
-(void)CallbackFromCannalButton:(UIButton *)sender;
@end





