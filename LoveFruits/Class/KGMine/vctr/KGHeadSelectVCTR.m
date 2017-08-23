//
//  KGHeadSelectVCTR.m
//  LoveFruits
//
//  Created by kangxg on 2016/10/23.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGHeadSelectVCTR.h"
#import "KGHeadIconView.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface KGHeadSelectVCTR ()<KGBaseViewDelegate>
@property (nonatomic,weak)KGHeadIconView           *  MVSelectIconView;
@property (nonatomic,retain)UIButton               *  MVEditButton;
@end

@implementation KGHeadSelectVCTR

- (void)viewDidLoad {
    [super viewDidLoad];
    self.KVTitleLabel.text = @"选择头像";
    [self createTopView];

    [self createImageViews];
    // Do any additional setup after loading the view.
}
-(void)createTopView
{
    if (_MVEditButton== nil)
    {
        _MVEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _MVEditButton.frame = CGRectMake(0, 0, 40, 44);
        [_MVEditButton setTitle:@"保存" forState:UIControlStateNormal];
        _MVEditButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_MVEditButton setTitleColor:CommonlyUsedBtnColor forState:UIControlStateNormal];
        _MVEditButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_MVEditButton addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -12;
        UIBarButtonItem * rightItem=[[UIBarButtonItem alloc]initWithCustomView:_MVEditButton];
        rightItem.width= -15;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
        //        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
}
-(void)clickSave
{
    if (_MVSelectIconView == nil)
    {
        return;
    }
    if (_YVViewBacBlock)
    {
        _YVViewBacBlock([_MVSelectIconView selectedImage]);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(void)createImageViews
{
    float with = (self.view.v_width-50)/4;
    for ( int i = 0; i<4; i++)
    {
        KGHeadIconView  * view = [[KGHeadIconView alloc]initWithFrame:CGRectMake(10+i*10 + i * with, 18.5, with, with) withImageName:[NSString stringWithFormat:@"user_icon_%d",i]];
        view.KVDelegate = self;
        [self.view addSubview:view];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pSelectedView:(id)sender
{
    KGHeadIconView * giftBtnView  = sender;
    if (_MVSelectIconView == nil)
    {
        _MVSelectIconView = giftBtnView;
        
        
    }
    else if(_MVSelectIconView == giftBtnView)
    {
        [giftBtnView setSelectButtonNomal];
    }
    else
    {
        [_MVSelectIconView setSelectButtonNomal];
        
        _MVSelectIconView = giftBtnView;
    }
    
}

-(void)pUnSelectedView:(id)sender
{
    KGHeadIconView * giftBtnView  = sender;
    if (_MVSelectIconView == giftBtnView)
    {
        _MVSelectIconView = nil;
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
