//
//  KGPaymentMethodVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/25.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGPaymentMethodVCTR.h"
#import "KGPaymentMethodModel.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGPayMethodTableCell.h"
#import "KGChannelModel.h"
#import "BeeCloud.h"
#import "BCPayConstant.h"
#import "BCPayReq.h"
#import "KGPayOverVCTR.h"
@interface KGPaymentMethodVCTR ()<UITableViewDataSource,UITableViewDelegate,KGTableCellDelegate,KGTableCellDelegate,BeeCloudDelegate>
@property (nonatomic,retain)KGPaymentMethodModel        * MVModel;
@property (nonatomic,retain)UITableView                 * MVTableView;
@property (nonatomic,retain)UIView                      * MVBottomView;
@property (nonatomic,retain)UIButton                    * MVSubmitBtn;
@property (nonatomic,retain)UILabel                     * MVSumtileLabel;
@property (nonatomic,retain)UILabel                     * MVSumLabel;
@end

@implementation KGPaymentMethodVCTR
-(id)init
{
    if (self = [super init])
    {
         [self initData];
    }
    return self;
}

-(void)setKDOrderId:(NSString *)KDOrderId
{
    _MVModel.KDOrderId = KDOrderId;
    
}

-(void)setKDOrderAmount:(NSString *)KDOrderAmount
{
    _MVModel.KDOrderAmount  = KDOrderAmount;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.KVTitleLabel.text = @"请选择在线支付方式";
    [self.view addSubview:self.MVTableView];
    [self createBottomView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
#pragma mark - 设置delegate
    [BeeCloud setBeeCloudDelegate:self];
}

-(void)initData
{
    _MVModel = [[KGPaymentMethodModel alloc]init];
}

-(void)createBottomView
{
    [self.view addSubview:self.MVBottomView];
    [_MVBottomView addSubview:self.MVSubmitBtn];
    [_MVBottomView addSubview:self.MVSumLabel];
    [_MVBottomView addSubview:self.MVSumtileLabel];
    
    _MVSumLabel.text = [NSString stringWithFormat:@"￥%@",_MVModel.KDOrderAmount];
    [_MVSumLabel sizeToFit];
    _MVSumLabel.frame = CGRectMake(_MVBottomView.v_width-_MVSubmitBtn.v_width-15-_MVSumLabel.v_width, 0, _MVSumLabel.v_width, 48);
    
    [_MVSumtileLabel sizeToFit];
    _MVSumtileLabel.frame =CGRectMake(_MVBottomView.v_width-_MVSubmitBtn.v_width-9-_MVSumLabel.v_width-_MVSumtileLabel.v_width, 0, _MVSumtileLabel.v_width, 48);
}

-(UIView *)MVBottomView
{
    if (_MVBottomView == nil)
    {
        _MVBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _MVTableView.v_height, self.view.v_width, 48)];
        _MVBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _MVBottomView;
}
- (NSString *)genBillNo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}
-(void)enterPay
{
//    NSString *billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    /**
     按住键盘上的option键，点击参数名称，可以查看参数说明
     **/
    BCPayReq *payReq = [[BCPayReq alloc] init];
    /**
     *  支付渠道，PayChannelWxApp,PayChannelAliApp,PayChannelUnApp,PayChannelBaiduApp
     */
    payReq.channel = _MVModel.KDPayChannel; //支付渠道
    payReq.title = @"支付";//订单标题
    
    float count =_MVModel.KDOrderAmount.floatValue *100;
    NSString * totalFree =  [NSString stringWithFormat:@"%.0lf",count];
    
    payReq.totalFee = totalFree;
    //_MVModel.KDPayChannel==PayChannelBCApp?@"1":@"1";//订单价格; channel为BC_APP的时候最小值为100，即1元
    payReq.billNo = _MVModel.KDOrderId;//商户自定义订单号
    payReq.scheme = @"alipfzwhl";//URL Scheme,在Info.plist中配置; 支付宝必有参数
    payReq.billTimeOut = 300;//订单超时时间
//    payReq.viewController = self; //银联支付和Sandbox环境必填
    payReq.cardType = 0; //0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
    [BeeCloud sendBCReq:payReq];

}


#pragma mark - BCPay回调

- (void)onBeeCloudResp:(BCBaseResp *)resp {
    
    switch (resp.type) {
        case BCObjsTypePayResp:
        {
            // 支付请求响应
            BCPayResp *tempResp = (BCPayResp *)resp;
            if (tempResp.resultCode == 0) {
//                BCPayReq * payReq = (BCPayReq *)resp.request;
                //微信、支付宝、银联支付成功
                KGPayOverVCTR * vctr = [[KGPayOverVCTR alloc]init];
                vctr.KDOrderId = _MVModel.KDOrderId;
                [self.navigationController pushViewController:vctr animated:YES];
//                [self showAlertView:resp.resultMsg];
            } else {
                //支付取消或者支付失败
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
        case BCObjsTypeQueryBillsResp:
        {
            BCQueryBillsResp *tempResp = (BCQueryBillsResp *)resp;
            if (resp.resultCode == 0) {
                if (tempResp.count == 0) {
                    [self showAlertView:@"未找到相关订单信息"];
                } else {
//                    self.orderList = tempResp;
                    [self performSegueWithIdentifier:@"queryResult" sender:self];
                }
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
        case BCObjsTypeQueryRefundsResp:
        {
            BCQueryRefundsResp *tempResp = (BCQueryRefundsResp *)resp;
            if (resp.resultCode == 0) {
                if (tempResp.count == 0) {
                    [self showAlertView:@"未找到相关订单信息"];
                } else {
//                    self.orderList = tempResp;
                    [self performSegueWithIdentifier:@"queryResult" sender:self];
                }
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
            
        default:
        {
            if (resp.resultCode == 0) {
                [self showAlertView:resp.resultMsg];
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",resp.resultMsg, resp.errDetail]];
            }
        }
            break;
    }
}
- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
-(UIButton *)MVSubmitBtn
{
    if (_MVSubmitBtn == nil)
    {
        _MVSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVSubmitBtn.frame = CGRectMake(ScreenWidth- 113, 0, 113, 48);
        [_MVSubmitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _MVSubmitBtn.backgroundColor = CommonlyUsedBtnColor;
        _MVSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_MVSubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_MVSubmitBtn addTarget:self action:@selector(enterPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVSubmitBtn;
}
-(UILabel *)MVSumLabel
{
    if (_MVSumLabel == nil)
    {
        _MVSumLabel = [[UILabel alloc]init];
        _MVSumLabel.font = [UIFont systemFontOfSize:12];
        //        _MVSumLabel.text = @"在线支付：";
        _MVSumLabel.textColor = CommonlyUsedBtnColor;
    }
    return _MVSumLabel;
}
-(UILabel *)MVSumtileLabel
{
    if (_MVSumtileLabel == nil)
    {
        _MVSumtileLabel = [[UILabel alloc]init];
        _MVSumtileLabel.font = [UIFont systemFontOfSize:12];
        _MVSumtileLabel.text = @"应付款：";
        [_MVSumtileLabel sizeToFit];
        _MVSumtileLabel.textColor = CommonlyUsedBtnColor;
    }
    return _MVSumtileLabel;
}
-(UITableView *)MVTableView
{
    if (_MVTableView == nil)
    {
        _MVTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0 ,ScreenWidth,  ScreenHeight-NavigationH-48) style:UITableViewStylePlain];
        _MVTableView.backgroundColor=LFBNavigationHomeSearchColor;
        _MVTableView.delegate=self;
        _MVTableView.dataSource=self;
        _MVTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //        _MVTableView.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
        
        
        
    }
    return _MVTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MVModel.KDChannelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return 54;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView * view = [[UIView alloc]init];
    view.frame =  CGRectMake(0, 0, ScreenWidth, 54);
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
   
    toplab.backgroundColor = self.MVTableView.backgroundColor;
    
    [view addSubview:toplab];

    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth-30, 43.5)];
    lab.font = [UIFont systemFontOfSize:14.0f];
    lab.textColor = [UIColor colorWithHexString:@"#333333"];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = _MVModel.KDChannelName;
    [view addSubview:lab];
        
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(10, 53.5, ScreenWidth-30, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    [view addSubview:line];
    return view;
        
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    KGPayMethodTableCell  * paycell = [tableView dequeueReusableCellWithIdentifier:@"paycell"];
    if (paycell == nil)
    {
        paycell = [[KGPayMethodTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"adCell"];
        
    }
    if (indexPath.row == (_MVModel.KDChannelList.count-1)) {
        paycell.KVLineLabel.hidden = YES;
    }
    else
    {
         paycell.KVLineLabel.hidden = false;
    }
    [paycell updateCell:_MVModel.KDChannelList[indexPath.row]];
    return paycell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _MVModel.KDPayChannel = _MVModel.KDChannelList[indexPath.row].KDPayChannel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pSelectedView:(id)sender withInfo:(NSDictionary *)info
{
    if (sender)
    {
//        if (_MVModel.KDSelectView )
//        {
//            [_MVModel.KDSelectView  unSelected];
//        }
//        _MVModel.KDSelectView = sender;
//        
//        _MVModel.KDPayChannel = _MVModel.KDSelectView.KVModel.KDPayChannel;
     
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
