//
//  KGSearchGoodsListView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchGoodsListView.h"
#import "KGHomeCommodityCellModel.h"
#import "KGHomeCommodityCell.h"
#import "KGTableCellDelegate.h"
#import "GlobelDefine.h"
#import "UIView+Extension.h"
#import "UIView+Extension.h"
#import "KGRefreshFooter.h"
@interface KGSearchGoodsListView()<UITableViewDelegate,UITableViewDataSource,KGTableCellDelegate>
@property (nonatomic,retain)UITableView                * KVTableView;
@property (nonatomic,copy)NSMutableArray             * MDataArr;
@end

@implementation KGSearchGoodsListView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}
-(void)setKVDelegate:(id<KGBaseViewDelegate>)KVDelegate
{
    [super setKVDelegate:KVDelegate];
    if (!self.KVTableView.superview)
    {
        [self addSubview:self.KVTableView];
    }
    [self.KVTableView  reloadData];
}
-(UITableView *)KVTableView
{
    if (_KVTableView == nil)
    {
        _KVTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.v_width, self.v_height)style:UITableViewStyleGrouped ];
        //        _KVTableView.backgroundColor=KColorCustom(@"#f3f2f0");
        _KVTableView.delegate = self;
        _KVTableView.dataSource = self;
        _KVTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _KVTableView.showsVerticalScrollIndicator = NO;
        KGRefreshFooter  * refresFootView = [KGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshListFooter)];
        _KVTableView.mj_footer    = refresFootView;
    }
    return _KVTableView;
}
-(void)beginRefreshListFooter
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pLoadMore:)]) {
        [self.KVDelegate pLoadMore:self];
    }
}
-(void)endRefreshFooter:(BOOL)noNext
{
    if (![self.KVTableView.mj_footer isRefreshing])
    {
        return;
    }
    if (!noNext)
    {
        [self.KVTableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [self.KVTableView.mj_footer endRefreshing];
    }
    
}
-(void)dissmissMyself
{
    self.hidden = YES;
    
}
-(void)refreshUIWithArr:(NSMutableArray *)arr
{
    if (arr)
    {
        self.hidden = false;
//        if (self.MDataArr)
//        {
//             [self.MDataArr removeAllObjects];
//        }
       
        self.MDataArr=[arr mutableCopy];
        [self.KVTableView reloadData];
    }
  
}
#pragma mark --- table view delegate  -------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //_KModel.KDCellModelArry.count+
    return self.MDataArr.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 33.0f;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView * view           = [[UIView alloc]init];
//    view.frame              = CGRectMake(0, 0, ScreenWidth, 33);
//    
//    UILabel * line          = [[UILabel alloc]init];
//    line.frame              = CGRectMake(33, 33/2, ScreenWidth-66,0.5 );
//    line.backgroundColor    = [UIColor colorWithHexString:@"#d8d8d8"];
//    UILabel * downLabel     = [[UILabel alloc]init];
//    downLabel.textAlignment = NSTextAlignmentCenter;
//    downLabel.text          = @"已经到底了";
//    downLabel.backgroundColor = self.backgroundColor;
//    downLabel.textColor     = [UIColor colorWithHexString:@"#999999"];
//    downLabel.font          = [UIFont systemFontOfSize:13.0f];
//    [downLabel sizeToFit];
//    downLabel.frame         = CGRectMake((ScreenWidth-downLabel.v_width)/2-16, (33-downLabel.v_height)/2, downLabel.v_width +32, downLabel.v_height);
//    
//    [view addSubview:line];
//    [view addSubview:downLabel];
//    return view;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 116;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGHomeCommodityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCommodityCell"];
    if (cell == nil)
    {
        cell = [[KGHomeCommodityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCommodityCell"];
        cell.KVDelegate = self.KVDelegate;
        [cell updateCell:_MDataArr[indexPath.row]];
        //        [cell updateCell:[_KModel.KDCellModelArry objectAtIndex:indexPath.row]];
    }
    //   KGHomeCommodityCell * cell = [[KGHomeCommodityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCommodityCell"];
    return cell;
    
}
@end
