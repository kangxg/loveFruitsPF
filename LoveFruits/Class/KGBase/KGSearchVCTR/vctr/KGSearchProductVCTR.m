//
//  KGSearchProductVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchProductVCTR.h"
#import "GlobelDefine.h"
#import "KGSearchView.h"
#import "KGCollectionView.h"
#import "KGHomeFreshHot.h"
#import "KGNotSearchProductsView.h"
#import "KGYellowShopCarView.h"
#import "KGBaseNavigationController.h"
#import "UIImage+Extension.h"
#import "YDConfigurationHelper.h"
#import "KGSearchProductModel.h"
#import "KGSearchScanfGroup.h"
#import "KGBaseViewDelegate.h"
#import "KGSearchGoodsListView.h"
#import "KGSearchNoneView.h"
#import "KGProgressHUDManager.h"
#import "YZNetworkRequestHelper.h"
#import "KGRefreshFooter.h"
#import "iToast.h"
#import "YZRequestItem.h"
#import "KGProductDetailsVCTR.h"
#import "KGHomeCommodityCell.h"
#import "KGHomeCommodityCellModel.h"
#import "KGHotProductDetailsVCTR.h"
@interface KGSearchProductVCTR()<UIScrollViewDelegate,UISearchBarDelegate,UITextFieldDelegate,KGBaseViewDelegate,YZNetworkRequestHelpDelegate>
@property (nonatomic,retain)UIScrollView                 *      MContentScrollView;
@property (nonatomic,retain)UISearchBar                  *      MSearchBar;
@property (nonatomic,retain)KGSearchView                 *      MHotSearchView;
@property (nonatomic,retain)KGSearchView                 *      MHistorySearchView;
@property (nonatomic,retain)UIButton                     *      MCleanHistoryButton;
@property (nonatomic,retain)KGCollectionView             *      MSearchCollectionView;

@property (nonatomic,retain)KGNotSearchProductsView      *      MCollectionHeadView;
@property (nonatomic,retain)KGSearchProductModel         *      MModel;
@property(strong,nonatomic)KGSearchScanfGroup            *      MVSearchScanfView;
@property (nonatomic,retain)KGSearchGoodsListView        *      MVSearchGoodsView;
@property (strong,nonatomic)UITextField                  *      MTextField;
@property (nonatomic,retain)KGSearchNoneView             *      MVSearchNoneView;
@property (nonatomic,retain)YZNetworkRequestHelper      * MRequestHelper;
@end

@implementation KGSearchProductVCTR
@synthesize MContentScrollView     = _MContentScrollView;
@synthesize MSearchBar             = _MSearchBar;
@synthesize MHotSearchView         = _MHotSearchView;
@synthesize MHistorySearchView     = _MHistorySearchView;
@synthesize MCleanHistoryButton    = _MCleanHistoryButton;
@synthesize MSearchCollectionView  = _MSearchCollectionView;

@synthesize MCollectionHeadView    = _MCollectionHeadView;
@synthesize MTextField             = _MTextField;
@synthesize MVSearchScanfView      = _MVSearchScanfView;
@synthesize MVSearchNoneView       = _MVSearchNoneView;
@synthesize MRequestHelper = _MRequestHelper;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _MModel = [[KGSearchProductModel alloc]init];
    [self createContentScrollView];
    [self buildSearchBar];
    [self loadHistorySearchButtonData];

    
}

-(void)createContentScrollView
{
    if (_MContentScrollView == nil)
    
    {
        _MContentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight-NavigationH)];
        _MContentScrollView.backgroundColor = self.view.backgroundColor;
        _MContentScrollView.alwaysBounceVertical = true;
        _MContentScrollView.delegate = self;
        [self.view addSubview:_MContentScrollView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = LFBNavigationHomeSearchColor;
    self.navigationController.navigationBar.hidden=YES;
//    if (_MSearchCollectionView != nil && _MGoodses.count>0)
//    {
//        [_MSearchCollectionView reloadData];
//    }
}

-(void)buildSearchBar
{
        KGBaseNavigationController * nav = (KGBaseNavigationController *)self.navigationController;
        nav.KGNavBackButton.frame        = CGRectMake(0, 0, 10, 40);

    
        nav.KGIsAnimation = false;
    
    //设置titleView
    CGRect rect=CGRectMake(0, 0, ScreenWidth, NavigationH);
    UIView * titleview=[[UIView alloc]initWithFrame:rect];
    titleview.backgroundColor=[UIColor colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:titleview];
    
    
    //取消按钮
    UIButton * cancleBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(ScreenWidth-10-40, 20+7, 40, NavigationH-34);
    [cancleBtn setTitle:@"搜索" forState:UIControlStateNormal];
    cancleBtn.backgroundColor = CommonlyUsedBtnColor;
    cancleBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.layer.cornerRadius = 5.0f;
    [cancleBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleview addSubview:cancleBtn];
    
    
    UIButton * leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,20+7,20, 30)];
    
    [leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [leftBtn setTintColor:[UIColor whiteColor]];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
    [titleview addSubview:leftBtn];
    //输入框和背景
    UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(14+10+20,20+7, ScreenWidth-14*2 -20-20-40,NavigationH-34)];
    backView.layer.masksToBounds=YES;
    backView.layer.cornerRadius=5;
    backView.backgroundColor=LFBNavigationHomeSearchColor;
    backView.layer.borderColor = [UIColor colorWithHexString:@"#a6aaae"].CGColor;
    backView.layer.borderWidth = 0.5;
    [titleview addSubview:backView];
    CGFloat bH=NavigationH-34;
    
    //搜索图标
    UIImageView * searchIcon=[[UIImageView alloc]initWithFrame:CGRectMake(9, 10, bH-16, bH-16)];
    searchIcon.image=[UIImage imageNamed:@"icon_search"];
    [backView addSubview:searchIcon];
    CGFloat bw=backView.frame.size.width-bH;
    _MTextField=[[UITextField alloc]initWithFrame:CGRectMake(bH, 2, bw, bH)];
    self.MTextField.backgroundColor=[UIColor clearColor];
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    _MTextField.font=font;
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[UIColor colorWithHexString:@"#535353"],NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"请在此输入您想购买的商品" attributes:attrsDictionary];
    self.MTextField.attributedPlaceholder=attrString;
    
    
    self.MTextField.returnKeyType=UIReturnKeyGo;
    self.MTextField.delegate = self;
    self.MTextField.clearButtonMode=UITextFieldViewModeAlways;
    [self.MTextField addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:self.MTextField];
    
}

/**
*  Description  创建根据数据查询条件显示的列表
*/
-(void)createSearchScanfView
{
    if (_MVSearchScanfView == nil)
    {
        _MVSearchScanfView=[[KGSearchScanfGroup alloc] initWithSuperview:self.view andFrame:CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight) ];
        _MVSearchScanfView.KVDelegate = self;
//        _MVSearchScanfView.tableview.backgroundColor = KColorCustom(@"#f0f3f2");
        [self.view addSubview:_MVSearchScanfView];
    }
}

-(void)createGoosListView
{
    if (_MVSearchGoodsView == nil)
    {
        _MVSearchGoodsView = [[KGSearchGoodsListView alloc]initWithFrame:CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight-NavigationH) ];
        _MVSearchGoodsView.KVDelegate = self;
        [self.view addSubview:_MVSearchGoodsView];
    }
    [_MVSearchGoodsView refreshUIWithArr:_MModel.KDGoodsModelArr];
    _MVSearchGoodsView.hidden = false;
}

-(void)createSearchNoneview
{
    if (_MVSearchNoneView == nil)
    {
        _MVSearchNoneView = [[KGSearchNoneView alloc]initWithFrame:CGRectMake(0, NavigationH, ScreenWidth, ScreenHeight-NavigationH) ];
        [self.view addSubview:_MVSearchNoneView];
    }
}
-(void)dissmissSearchScanfView
{
    if (_MVSearchScanfView)
    {
        [_MVSearchScanfView dissmissMyself];
//        [_MVSearchScanfView removeFromSuperview];
//        _MVSearchScanfView = nil;
    }
    
    if (_MVSearchGoodsView)
    {
        [_MVSearchGoodsView dissmissMyself];
    }
    
    if (_MVSearchNoneView)
    {
        [_MVSearchNoneView removeFromSuperview];
        _MVSearchNoneView = nil;
    }
}
-(void)clickSearchBtn
{
     [self.MTextField resignFirstResponder];
    if(self.MTextField.text.length)
    {
        [self writeHistorySearchToUserDefault:self.MTextField.text];
        [self initloadRequestStart];
       
        //[self createSearchNoneview];
    }
   
//    [self dissmissSearchScanfView];
    
}
-(void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   
    
    
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldChanged
{
    
    if (self.MTextField.text.length==0||self.MTextField.text==nil)
    {
        [self dissmissSearchScanfView];
        return;
    }
    
    NSArray * arr = [_MModel getHistorySearchArr];
    NSMutableArray * resultArr = [[NSMutableArray alloc]init];
    if (arr.count)
    {
        for (NSString * str in arr)
        {
            if([str rangeOfString:self.MTextField.text].location !=NSNotFound)//_roaldSearchText
            {
                NSLog(@"yes");
                [resultArr addObject:str];
            }
           
        }
        if (resultArr.count)
        {
              [self createSearchScanfView];
             [self.MVSearchScanfView refreshUIWithArr:resultArr];
        }
    }
    
}
-(void)pSearchGoods:(NSString *)goodsName
{
    if (goodsName.length)
    {
        [self.view endEditing:YES];
        [self createGoosListView];
    }
}

-(void)pClickBuy:(id)object
{
    if (object)
    {
        KGHomeCommodityCell * cell = (KGHomeCommodityCell *)object;
        KGHomeCommodityCellModel * model = cell.KModel;
        KGProductDetailsVCTR * vctr = [[KGProductDetailsVCTR  alloc]init];
       
        vctr.YMProductId = model.pid;
       [self.navigationController pushViewController:vctr animated:YES];

        
       
    }
   
}
-(UISearchBar *)MSearchBar
{
    if (_MSearchBar == nil)
    {
        _MSearchBar = [[UISearchBar alloc]init];
        _MSearchBar.frame = CGRectMake(0, 0, ScreenWidth * 0.8-60, 30);
        _MSearchBar.placeholder = @"请输入商品名称";
        _MSearchBar.barTintColor = [UIColor whiteColor];
        _MSearchBar.keyboardType = UIKeyboardTypeDefault;
         _MSearchBar.delegate = self;
    }
    
    return _MSearchBar;
}

-(UIButton *)MCleanHistoryButton
{
    if (_MCleanHistoryButton == nil)
    {
        _MCleanHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MCleanHistoryButton setTitle:@"清 空 历 史" forState:UIControlStateNormal];
        [_MCleanHistoryButton setTitleColor:[UIColor colorWithCustom:163 withGreen:163 withBlue:163] forState:UIControlStateNormal];
        _MCleanHistoryButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _MCleanHistoryButton.backgroundColor = self.view.backgroundColor;
        
        _MCleanHistoryButton.layer.cornerRadius = 5;
        _MCleanHistoryButton.layer.borderColor = [UIColor colorWithCustom:200  withGreen:200 withBlue:200].CGColor;
        
        _MCleanHistoryButton.layer.borderWidth  = 0.5;
        _MCleanHistoryButton.hidden             = true;
        [_MCleanHistoryButton addTarget:self action:@selector(cleanSearchHistorySearch) forControlEvents: UIControlEventTouchUpInside];
       
        
        
    }
    
    return _MCleanHistoryButton;

}
-(void) buildCleanHistorySearchButton
{
     [self.MContentScrollView addSubview:self.MCleanHistoryButton];
}


#pragma mark --------cleanHistory Button call back------------
-(void)cleanSearchHistorySearch
{

    [_MModel cleanHistorySearch];
    [self loadHistorySearchButtonData];

    
}
-(void)loadHistorySearchButtonData
{
    if (_MHistorySearchView != nil)
    {
        [_MHistorySearchView removeFromSuperview];
        _MHistorySearchView = nil;

    }
    
    __weak KGSearchProductVCTR  * tmpSelf = self;
    
   
    NSArray * arr = [_MModel getHistorySearchArr];
    //[YDConfigurationHelper getArrayValueforConfigurationKey:LFBSearchViewControllerHistorySearchArray];
  
    if (arr.count>0)
    {
        KGWEAKOBJECT(weakSelf);
       _MHistorySearchView = [[KGSearchView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 0) withtitle:@"搜索历史" withSearchArry:arr withBlock:^(UIButton *button)
        {
        
            tmpSelf.MTextField.text = button.titleLabel.text;
            [weakSelf clickSearchBtn];
            [tmpSelf loadProductsWithKeyword:button.titleLabel.text];
            
       } withClean:^(UIButton *button) {
           [tmpSelf cleanSearchHistorySearch];
       }];
        
        _MHistorySearchView.frame = CGRectMake(10, 0, ScreenWidth - 20, _MHistorySearchView.KGSearchHeight);
        [self.MContentScrollView addSubview:_MHistorySearchView];

    }


}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark ----------- textField delegate -----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.text.length==0)
    {
        
//        [ReminderView showReminderViewWithWindowAndFrame:CGRectMake(0, kScreenHeight/2-32/2, kScreenWith, 32) DisappearTime:3 WithTitle:@"请输入搜索关键词"];
        
        return NO ;
    }
    [textField resignFirstResponder];
//    [self selectConditionFinish:textField.text];
    [self loadProductsWithKeyword:textField.text];
    return YES;
}




-(void)writeHistorySearchToUserDefault:(NSString *)string

{


    [_MModel saveHistorySearchValue:string];
    
    [self loadHistorySearchButtonData];
  
  
}

-(void)loadProductsWithKeyword:(NSString *)string
{
    [self.MTextField resignFirstResponder];

    [self writeHistorySearchToUserDefault:string];
    
}

#pragma mark
#pragma mark ----  请求 ---
-(void)initloadRequestStart
{
    [self requestRegin];
}
-(void)requestRegin
{
    [self.MModel.KDSearchRequestItem.YRequestDic setValue:self.MTextField.text forKey:@"keyword"];
    [self.MRequestHelper beginRequestWithItem:self.MModel.KDSearchRequestItem];
}
-(YZNetworkRequestHelper *)MRequestHelper
{
    if (_MRequestHelper == nil)
    {
        _MRequestHelper =   [YZNetworkRequestHelper InstanceNetworkWithRequestType:YNETWORKHELPEPOSTREQUEST];
        _MRequestHelper.YNetworkRequestDelegate = self;
    }
    
    return _MRequestHelper;
}

#pragma mark   --------------------- 网络请求delegate---------------------------

/**
 *  Description  网络请求开始
 *
 *  @param requestTag 请求model 的tag
 */
-(void)pRequestWillBegin:(YZRequestItem *)requestItem
{
    if (!requestItem || requestItem.YRequestOption.hasLoad == false)
    {
        return;
    }
    
    
    [self  startLoadingView];
    
    
}

/**
 *  Description 网络请求 完成
 */
-(void)pRequestFinished
{
    
    if (self.MRequestHelper.YNetworkRequestCount== 0)
    {
        [self stopLoadingView];
    }
    
}

/**
 *  Description 开始 加载 网络请求指示视图
 */
-(void)startLoadingView
{
    
    if (![KGProgressHUDManager isVisible])
    {
        [KGProgressHUDManager show];
    }
    
    //    [KGProgressHUDManager setBackgroundColor:[UIColor colorWithCustom:230 withGreen:230 withBlue:230]];
    //
    //    if (![KGProgressHUDManager isVisible])
    //    {
    //        [KGProgressHUDManager showWithStatus:@"正在加载中"];
    //    }
    
    //    [YZLoadingVew showLoadingViewWithSuperView:self frame:CGRectMake(0,kDHeight , kScreenWith, kScreenHeight-kDHeight)];
    
}
/**
 *  Description 停止 加载 网络请求指示视图
 */
-(void)stopLoadingView
{
    
    if (self.MRequestHelper.YNetworkRequestCount == 0)
    {
        [KGProgressHUDManager dismiss];
        
    }
    
    
}
-(void)stopRefrsh
{
    if (_MVSearchGoodsView )
    {
        [_MVSearchGoodsView endRefreshFooter:_MModel.KDHasNext];
    }
    
}
/**
 *  Description   请求成功
 *
 *  @param requestTag 请求 tag
 *  @param jsonDic
 */
-(void)pRequestSuccess:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            KGWEAKOBJECT(weakSelf);
            [self.MModel putJsonData:jsonDic WithType:requestItem.YRequestTag withBlock:^(YZProcessingDataState state, NSInteger type) {
                [weakSelf ProcessingNetworkBack:state];
            }];
        }
            
            break;
            
            
            break;
        default:
            break;
    }
    
    
    
    
}

-(void)pRequestFailure:(YZRequestItem *)requestItem withCode:(NSString *)failureCode
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            [self createSearchNoneview];
        }
            break;
            
        default:
            break;
    }
    [self stopRefrsh];
    
}

-(void)pRequestError:(YZRequestItem *)requestItem withDic:(NSDictionary *)jsonDic
{
    switch (requestItem.YRequestTag)
    {
        case YZNETWORKVERIFICATIONFIR:
        {
            
            [[iToast makeText:[jsonDic valueForKey:@"message"]] show];
            
        }
            break;
            
        default:
            break;
    }
    [self stopRefrsh];
}
//用于列表
-(void)ProcessingNetworkBack:(YZProcessingDataState )state
{
    switch (state) {
        case YZPROCESSINGDATASUCCESS:
        {
            [self createGoosListView];
//            [self.KGTableView reloadData];
            
        }
            break;
        case YZPROCESSINGDATAFAILT:
        {
            
            
        }
        case YZPROCESSINGDATANONE:
        {
            
        }
        case YZPROCESSINGDATAERROR:
        {
            [self createSearchNoneview];

        }
            break;
        case YZPROCESSINGDATANULL:
        {
            
            [self createSearchNoneview];
        }
            break;
            
            
            
        default:
            break;
    }
    [self stopRefrsh];
    
}

@end
