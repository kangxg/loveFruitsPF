//
//  YCMCreditImageView.m
//  YZJOB-2
//
//  Created by kangxg on 15/12/2.
//  Copyright (c) 2015年 lfh. All rights reserved.
//

#import "YCMCreditImageView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "UIButton+WebCache.h"
#import "GlobelDefine.h"
#import "KGCreditImageModel.h"
@interface YCMCreditImageView()
{
    UIButton      * _mAddBtn;
    UIButton      * _mBackGroundBtn;
    UIButton      * _mDeleteBtn;
}
@end

@implementation YCMCreditImageView

@synthesize MBackGroundBtn = _mBackGroundBtn;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       ;
        [self createBackgroundBtn];
        [self createAddBtn];
//        [self createDelBtn];
    }
    
    return self;
}

-(void)createBackgroundBtn
{
    _mBackGroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mBackGroundBtn.frame = self.bounds;
    _mBackGroundBtn.hidden = YES;
    [_mBackGroundBtn addTarget:self action:@selector(backGroundBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mBackGroundBtn];
    
}

-(void)createAddBtn
{
    if (_mAddBtn== nil)
    {
        _mAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mAddBtn.frame = self.bounds;
        [_mAddBtn setTitle:@"十" forState:UIControlStateNormal];
        _mAddBtn.layer.masksToBounds = YES;
        _mAddBtn.layer.cornerRadius  = 5.0f;
        [_mAddBtn setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
        _mAddBtn.backgroundColor= [UIColor colorWithHexString:@"#efeff4"];
        [_mAddBtn addTarget:self action:@selector(addBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mAddBtn];
    }
    else
    {
        _mAddBtn.hidden  = false;
    }

}

-(void)createDelBtn
{
    _mDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mDeleteBtn.frame = CGRectMake(self.frame.size.width-22, 0, 22, 22);
    _mDeleteBtn.hidden = YES;
    [_mDeleteBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [_mDeleteBtn addTarget:self action:@selector(deleteBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mDeleteBtn];

}
-(void)putinImage:(UIImage *)image
{
    if (image)
    {
        _mAddBtn.hidden               = YES;
        _mBackGroundBtn.hidden        = false;
        [_mBackGroundBtn setImage:image forState:UIControlStateNormal];
    }
}
-(void)putinModel:(KGCreditImageModel *)model
{
    if (model== nil)
    {
        return;
    }
    
//    MModel = model;
//
//    BOOL isOk = MModel.MCreditSate;
//    if (!isOk)
//    {
//        _mAddBtn.hidden               = YES;
//        __weak UIButton  *btn         = _mDeleteBtn;
//        _mBackGroundBtn.hidden        = false;
//     
//        [_mBackGroundBtn sd_setImageWithURL:[NSURL URLWithString:MModel.MImageDefault] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cellIcon_defalut"]  options:SDWebImageRetryFailed|SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            btn.hidden        = false;
//            
//        }];
//
//    }
//    else
//    {
//        _mBackGroundBtn.hidden        = false;
//        _mDeleteBtn.hidden            = YES;
//        _mAddBtn.hidden               = YES;
//        _mBackGroundBtn.hidden        = false;
//        [_mBackGroundBtn sd_setImageWithURL:[NSURL URLWithString:MModel.MImageDefault] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cellIcon_defalut"]  options:SDWebImageRetryFailed|SDWebImageProgressiveDownload];
//    }
//    
//    switch (MModel.MCreditSate) {
//        case EN_CreditNone:
//        {
//            _mDeleteBtn.hidden        =  true;
//            _mBackGroundBtn.hidden    =  true;
//            _mAddBtn.hidden           =  false;
//            self.backgroundColor      =  KColorCustom(@"#efeff4");
//
//        }
//            break;
//        case EN_CreditPreparation:
//        {
//            
//        }
//        
//        case EN_CreditFail:
//        {
////            _mDeleteBtn.hidden        =  false;
////            _mBackGroundBtn.hidden    =  false;
////            _mAddBtn.hidden           =  true;
////             __weak UIButton  *btn      = _mDeleteBtn;
////            [_mBackGroundBtn sd_setImageWithURL:[NSURL URLWithString:MModel.MImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cellIcon_defalut"]  options:SDWebImageRetryFailed|SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////                btn.hidden        = false;
////            }];
//        }
//            //break;
//        case EN_CreditCarriesOn:
//        {
//            _mAddBtn.hidden           = YES;
//           __weak UIButton  *btn      = _mDeleteBtn;
//            _mBackGroundBtn.hidden    = false;
//            [_mBackGroundBtn sd_setImageWithURL:[NSURL URLWithString:MModel.MImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cellIcon_defalut"]  options:SDWebImageRetryFailed|SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                 btn.hidden        = false;
//            }];
//
//           
//        }
//            break;
//        case EN_CreditCompletion:
//        {
//            _mBackGroundBtn.hidden    = false;
//            _mDeleteBtn.hidden        = YES;
//            _mAddBtn.hidden           = YES;
//            _mBackGroundBtn.hidden    = false;
//            [_mBackGroundBtn sd_setImageWithURL:[NSURL URLWithString:MModel.MImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cellIcon_defalut"] options:SDWebImageRetryFailed|SDWebImageProgressiveDownload];
//
//            
//        }
//            break;
//        
//        default:
//            break;
//    }
    
}

-(void)backGroundBtnCallBack
{

//    if (MModel.MCreditSate == EN_CreditNone)
//    {
//        return;
//    }
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pOperitionViewEvent:withState:)])
    {
        [self.KVDelegate pOperitionViewEvent:self withState:KGOPRERATIOOPENIMAGE];
    }
    
}

-(void)addBtnCallBack
{
//    if (MModel.MCreditSate == EN_CreditFail || MModel.MCreditSate == EN_CreditNone )
//    {
//        if (MDelegate && [MDelegate respondsToSelector:@selector(pOperitionViewEvent:withState:)]) {
//            [MDelegate pOperitionViewEvent:self withState:EN_FOperationADD];
//        }
//    }
    
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pOperitionViewEvent:withState:)])
    {
        [self.KVDelegate pOperitionViewEvent:self withState:KGOPRERATIOAADD];
    }
}

-(void)deleteBtnCallBack
{
   
//    if (MModel.MCreditSate == EN_CreditCompletion)
//    {
//        return;
//    }
//    
//    if (MDelegate && [MDelegate respondsToSelector:@selector(pOperitionViewEvent:withState:)])
//    {
//        [MDelegate  pOperitionViewEvent:self withState:EN_FOperationDelete];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface YCMAddCreditImageView()
{
     UIButton      * _mAddBtn;
}
@end

@implementation YCMAddCreditImageView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createAddBtn];
    }
    
    return self;
}
-(void)createAddBtn
{

    _mAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mAddBtn.frame = self.bounds;
    [_mAddBtn setTitle:@"十" forState:UIControlStateNormal];
    _mAddBtn.layer.masksToBounds = YES;
    _mAddBtn.layer.cornerRadius  = 5.0f;
    [_mAddBtn setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
    _mAddBtn.backgroundColor= [UIColor colorWithHexString:@"#efeff4"];
    [_mAddBtn addTarget:self action:@selector(addBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mAddBtn];
}


-(void)addBtnCallBack
{
 
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pOperitionViewEvent:withState:)])
    {
            [self.KVDelegate pOperitionViewEvent:self withState:KGOPRERATIOAADD];
    }
    
}
@end
