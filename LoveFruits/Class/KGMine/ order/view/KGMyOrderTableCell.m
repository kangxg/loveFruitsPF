//
//  KGMyOrderTableCell.m
//  LoveFruits
//
//  Created by kangxg on 2016/12/31.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMyOrderTableCell.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "GlobelDefine.h"
#import "UIImageView+WebCache.h"

@interface KGMyOrderTableCell()
@property (nonatomic,retain)UILabel    * MVTopLine;
@property (nonatomic,retain)UILabel    * MVDownLine;
@end
@implementation KGMyOrderTableCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle   = UITableViewCellSelectionStyleNone;
        [self createLabelView];
        [self createImageView];
        [self createButtonView];
        [self createOtherView];
    }
    return self;
}

-(void)createLabelView
{
    [self addSubview:self.KVOrderNumLabel];
    [self addSubview:self.MVTopLine];
    [self addSubview:self.MVDownLine];
    [self addSubview:self.KVOrderTypeLabel];
    [self addSubview:self.KVOrderPayCountLabel];
    
}

-(void)createImageView
{
    
}

-(void)createButtonView
{
    
}
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    _KVModel = model;
    
    _KVOrderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",_KVModel.orderId];
    [_KVOrderNumLabel sizeToFit];
    
    
    _KVOrderPayCountLabel.text = [NSString stringWithFormat:@"实付金额：%@",_KVModel.orderAmount];
    [_KVOrderPayCountLabel sizeToFit];
    for (UIView * view in  _KVOrderWareView.subviews)
    {
        [view removeFromSuperview];
    }
    for ( int  i = 0; i<_KVModel.OrderWaresArr.count; i++)
    {
        KGOrderWaresModel * wareModel = _KVModel.OrderWaresArr[i];
        UIImageView * productImageView = [[UIImageView alloc]init];
        [productImageView sd_setImageWithURL:[NSURL URLWithString:wareModel.wareImg] placeholderImage:[UIImage imageNamed:@"v2_placeholder_one"]];
        productImageView.frame = CGRectMake(i*10 +92*i, 10, 92, 92);
        [_KVOrderWareView addSubview:productImageView];
    }
    
    _KVOrderWareView.contentSize = CGSizeMake((_KVModel.OrderWaresArr.count-1) * 10 +92 * _KVModel.OrderWaresArr.count, 112);

  

    
}
-(void)createOtherView
{
    [self addSubview:self.KVOrderWareView];
}
-(UILabel *)KVOrderNumLabel
{
    if (_KVOrderNumLabel == nil)
    {
        _KVOrderNumLabel = [[UILabel alloc]init];
        _KVOrderNumLabel.font = [UIFont systemFontOfSize:11];
        _KVOrderNumLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _KVOrderNumLabel;
}

-(UILabel *)KVOrderTypeLabel
{
    if (_KVOrderTypeLabel == nil)
    {
        _KVOrderTypeLabel = [[UILabel alloc]init];
        _KVOrderTypeLabel.font = [UIFont systemFontOfSize:11];
        _KVOrderTypeLabel.textColor = [UIColor colorWithHexString:@"#2bd481"];
    }
    return _KVOrderTypeLabel;
}

-(UILabel *)KVOrderPayCountLabel
{
    if (_KVOrderPayCountLabel == nil)
    {
        _KVOrderPayCountLabel       = [[UILabel alloc]init];
        _KVOrderPayCountLabel.font  = [UIFont systemFontOfSize:11];
        _KVOrderPayCountLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
    }
    return _KVOrderPayCountLabel;
}

-(UILabel *)MVTopLine
{
    if (_MVTopLine == nil)
    {
        _MVTopLine                 = [[UILabel alloc]init];
        _MVTopLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _MVTopLine;
}

-(UILabel *)MVDownLine
{
    if (_MVDownLine == nil)
    {
        _MVDownLine                 = [[UILabel alloc]init];
        _MVDownLine.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
    }
    return _MVDownLine;
}
-(UIScrollView *)KVOrderWareView
{
    if (_KVOrderWareView == nil)
    {
        _KVOrderWareView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, ScreenHeight-NavigationH)];
        _KVOrderWareView.showsHorizontalScrollIndicator=NO;
        //        _MVScrollView.bounces = false;
        _KVOrderWareView.backgroundColor = [UIColor whiteColor];

    }
    return _KVOrderWareView;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _KVOrderNumLabel.frame = CGRectMake(10, 0, _KVOrderNumLabel.v_width, 40);
    _KVOrderTypeLabel.frame =CGRectMake(ScreenWidth-10-_KVOrderTypeLabel.v_width, 0, _KVOrderTypeLabel.v_width, 40);
    _MVTopLine.frame = CGRectMake(10, 39.5, ScreenWidth-20, 0.5);
    
    _KVOrderWareView.frame = CGRectMake(10, 40, ScreenWidth-20, 112);
    
    _MVDownLine.frame = CGRectMake(10, _KVOrderWareView.v_bottom, ScreenWidth-20, 0.5);
    _KVOrderPayCountLabel.frame =  CGRectMake(10, _MVDownLine.v_bottom, _KVOrderPayCountLabel.v_width, 39.5);
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
#pragma mark  待支付
@interface KGWillPayOrderTableCell()
@property (nonatomic,retain)UIButton * MVEnterPayBtn;
@property (nonatomic,retain)UIButton * MVCanelPayBtn;
@end
@implementation KGWillPayOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"等待支付";
    [self.KVOrderTypeLabel sizeToFit];
    
}

-(void)createLabelView
{
    [super createLabelView];
    self.KVOrderTypeLabel.textColor = CommonlyUsedBtnColor;
}

-(void)createButtonView
{
    [super createButtonView];
    [self addSubview:self.MVEnterPayBtn];
     [self addSubview:self.MVCanelPayBtn];
}

-(UIButton *)MVEnterPayBtn
{
    if (_MVEnterPayBtn == nil)
    {
        _MVEnterPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVEnterPayBtn.layer.masksToBounds = YES;
        _MVEnterPayBtn.layer.cornerRadius  = 2.0f;
        _MVEnterPayBtn.backgroundColor = CommonlyUsedBtnColor;
        _MVEnterPayBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [_MVEnterPayBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [_MVEnterPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_MVEnterPayBtn addTarget:self action:@selector(enterPayCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVEnterPayBtn;
}
-(UIButton *)MVCanelPayBtn
{
    if (_MVCanelPayBtn == nil)
    {
        _MVCanelPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVCanelPayBtn.layer.masksToBounds = YES;
        _MVCanelPayBtn.layer.cornerRadius  = 2.0f;
        _MVCanelPayBtn.layer.borderWidth   = 0.5f;
        _MVCanelPayBtn.layer.borderColor   = [UIColor colorWithHexString:@"#d8d8d8"].CGColor;
//        _MVCanelPayBtn.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        _MVCanelPayBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [_MVCanelPayBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_MVCanelPayBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        [_MVCanelPayBtn addTarget:self action:@selector(cannelPayCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVCanelPayBtn;
}
-(void)enterPayCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickViewOperation:operation:withInfo:)])
    {
        [self.KVDelegate pClickViewOperation:self operation:KGOPERATIONPAY withInfo:@{@"orderId":self.KVModel.orderId,@"orderAmount":self.KVModel.orderAmount}];
    }
}
-(void)cannelPayCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickViewOperation:operation:withInfo:)])
    {
       [self.KVDelegate pClickViewOperation:self operation:KGOPERATIONCANNEL withInfo:@{@"orderId":self.KVModel.orderId}];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVEnterPayBtn.frame = CGRectMake(ScreenWidth-10-70, self.v_height-7.5-25, 70, 25);
    _MVCanelPayBtn.frame = CGRectMake(ScreenWidth-10-70*2-15, self.v_height-7.5-25, 70, 25);
}

@end
#pragma mark  等待发货
@interface KGWillSendOrderTableCell()

@end
@implementation KGWillSendOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"支付成功";
    [self.KVOrderTypeLabel sizeToFit];
    
}
@end

#pragma mark  已发货
@interface KGWillReciveOrderTableCell()
@property (nonatomic,retain)UIButton * MVEnterBtn;
@end

@implementation KGWillReciveOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"已发货";
    [self.KVOrderTypeLabel sizeToFit];
    
}
-(void)createButtonView
{
    [super createButtonView];
    [self addSubview:self.MVEnterBtn];
}

-(UIButton *)MVEnterBtn
{
    if (_MVEnterBtn == nil)
    {
        _MVEnterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVEnterBtn.layer.masksToBounds = YES;
        _MVEnterBtn.layer.cornerRadius  = 2.0f;
        _MVEnterBtn.backgroundColor = CommonlyUsedBtnColor;
        _MVEnterBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [_MVEnterBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [_MVEnterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_MVEnterBtn addTarget:self action:@selector(enterCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVEnterBtn;
}

-(void)enterCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickViewOperation:operation:withInfo:)])
    {
        [self.KVDelegate pClickViewOperation:self operation:KGOPERATIONENTER withInfo:@{@"orderId":self.KVModel.orderId}];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVEnterBtn.frame = CGRectMake(ScreenWidth-10-80, self.v_height-7.5-25, 80, 25);
}
@end

#pragma mark  已完成
@interface KGOverOrderTableCell()
@property (nonatomic,retain)UIButton * MVDelBtn;
@end
@implementation KGOverOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"已完成";
    [self.KVOrderTypeLabel sizeToFit];
    
}


-(void)createButtonView
{
    [super createButtonView];
    [self addSubview:self.MVDelBtn];
}

-(UIButton *)MVDelBtn
{
    if (_MVDelBtn == nil)
    {
        _MVDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MVDelBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_MVDelBtn addTarget:self action:@selector(deleteCallBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVDelBtn;
}

-(void)deleteCallBack
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pClickViewOperation:operation:withInfo:)])
    {
        [self.KVDelegate pClickViewOperation:self operation:KGOPRERATIODELETE withInfo:@{@"orderId":self.KVModel.orderId}];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _MVDelBtn.frame = CGRectMake(ScreenWidth-10-16, self.v_height-10-20, 16, 20);
}
@end


@implementation KGCancelOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"支付失败";
    [self.KVOrderTypeLabel sizeToFit];
    
}
-(void)createLabelView
{
    [super createLabelView];
    self.KVOrderTypeLabel.textColor = CommonlyUsedBtnColor;
}

@end


@implementation KGInvalidOrderTableCell
-(void)updateCell:(id)model
{
    if (model == nil)
    {
        return;
    }
    [super updateCell:model];
    self.KVOrderTypeLabel.text = @"无此订单";
    [self.KVOrderTypeLabel sizeToFit];
    
}

-(void)createLabelView
{
    [super createLabelView];
    self.KVOrderTypeLabel.textColor = CommonlyUsedBtnColor;
}
@end
