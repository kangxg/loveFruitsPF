//
//  KGMineViewGroup.m
//  LoveFruits
//
//  Created by kangxg on 16/9/19.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGMineViewGroup.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGMineViewModel.h"
#import "KGMineViewTableCell.h"
@interface KGMineViewGroup()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel * celllabel;
    UIButton * recordBtn;
    UIButton * editBtn;
    UIImageView * cerImageView;
    
    UIImageView * redImageView;
    
    UIView * headbackView;
    
    UIView * btnBackView;
}
@property(strong,nonatomic)UIView * backView;
@property(strong,nonatomic)UITableView * myTableview;
@property(copy,nonatomic)NSMutableArray * dataArr;
@property(assign,nonatomic)id<KGMineViewDeletate>delegate;
@property(strong,nonatomic)UIImageView * myheadView;
@property(strong,nonatomic)NSArray * countArr;
@property(strong,nonatomic)NSArray * nameArr;
@end

@implementation KGMineViewGroup
+(instancetype)initWithSuperView:(UIView *)superview frame:(CGRect)frame dataArr:(NSMutableArray *)dataArr delegate:(id<KGMineViewDeletate>)delegate
{
    KGMineViewGroup * myvc=[[KGMineViewGroup alloc]init];
    [myvc initWithSuperView:superview frame:frame dataArr:dataArr delegate:delegate];
    
    return myvc;

}

-(void)initWithSuperView:(UIView *)superview frame:(CGRect)frame dataArr:(NSMutableArray *)dataArr delegate:(id<KGMineViewDeletate>)delegate
{
    self.delegate=delegate;
    self.dataArr=dataArr;
    self.backView=[[UIView alloc]initWithFrame:frame];
    [superview addSubview:self.backView];
    self.delegate=delegate;
    self.dataArr=dataArr;
    self.backView=[[UIView alloc]initWithFrame:frame];
    [superview addSubview:self.backView];
    
    self.myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
    self.myTableview.delegate=self;
    self.myTableview.dataSource=self;
    self.myTableview.showsVerticalScrollIndicator=NO;
//    self.myTableview.contentInset=UIEdgeInsetsMake(MyHeadViewH, 0, 0, 0);
    self.myTableview.backgroundColor= LFBNavigationHomeSearchColor;
    self.myTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableview.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
    [self.backView addSubview:self.myTableview];
    UIView * bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    bottomView.backgroundColor=self.myTableview.backgroundColor;
    self.myTableview.tableFooterView=bottomView;

}
-(void)dissMissMyHeadView
{
    [self.myheadView removeFromSuperview];
}
-(void)setTopNameArr:(NSArray *)nameArr countArr:(NSArray *)countArr
{
    self.nameArr=nameArr;
    self.countArr=countArr;
    [self.myTableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
    
}

-(void)setHeadView:(UIView*)headView
{
    self.myheadView=(UIImageView*)headView;
    self.myTableview.tableHeaderView = headView;
//    [self.myTableview addSubview: headView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray * array=[self.dataArr objectAtIndex:section];
    return array.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array=[self.dataArr objectAtIndex:indexPath.section];
    KGMineViewModel * model=[array objectAtIndex:indexPath.row];
    
        KGMineViewTableCell * cell=[ KGMineViewTableCell cellWithTableview:tableView cellSize:CGSizeMake(ScreenWidth, 50)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setMyViewModel:model];
        
        if (indexPath.row>=1) {
            UIView * line=[[UIView alloc]initWithFrame:CGRectMake(14, 0, ScreenWidth-14, 0.5)];
            line.backgroundColor= [UIColor colorWithHexString:@"#d8d8d8"];
         
            [cell addSubview:line];
        }
        return cell;
        
        
 
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 86;
    }
    
    return 15.0;
}
-(void)resetCouponView:(NSInteger)count
{
    UIView *  view=[btnBackView viewWithTag:1];
    UILabel * titleLabel=[view viewWithTag:102];
    titleLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        if (headbackView==nil) {
            
            headbackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 86)];
            headbackView.backgroundColor= LFBNavigationHomeSearchColor;
         
            
            btnBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 76)];
            btnBackView.backgroundColor= [UIColor whiteColor];
            [headbackView addSubview:btnBackView];
            
            UILabel * topLabel = [[UILabel alloc]init];
            topLabel.frame = CGRectMake(11, 10, btnBackView.v_width-22, 15);
            topLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            topLabel.text = @"我的钱包";
            topLabel.font = [UIFont systemFontOfSize:13.0f];
            [btnBackView addSubview:topLabel];
            for (int i=0; i<self.nameArr.count; i++) {
                
                UIView *  view=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/self.nameArr.count*i, topLabel.v_bottom+5, ScreenWidth/self.nameArr.count, 47)];
//                view.backgroundColor = [UIColor redColor];
                [btnBackView addSubview:view];
                
                UILabel * titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(0,5 , ScreenWidth/self.nameArr.count, 15) ];
                
                titleLabel.textAlignment=NSTextAlignmentCenter;
                titleLabel.font=[UIFont boldSystemFontOfSize:11];
                titleLabel.tag=101+i;
                titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
               
//                titleLabel.backgroundColor = [UIColor greenColor];
                [view addSubview:titleLabel];
                
                UILabel * nameLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 41/2, ScreenWidth/self.nameArr.count, 52/2) ];
                nameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
                nameLabel.font=[UIFont boldSystemFontOfSize:11];

                nameLabel.textAlignment=NSTextAlignmentCenter;
                nameLabel.text = @"0";
                nameLabel.tag=201+i;
                [view addSubview:nameLabel];
                [btnBackView addSubview:view];
                
                view.tag=i;
                view.userInteractionEnabled=YES;
                UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTopBtn:)];
                [view addGestureRecognizer:tap];
                
                
            }
            
            for (int j=0; j<self.nameArr.count-1; j++) {
                UIView * VerLine=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/self.nameArr.count+ScreenWidth/self.nameArr.count*j, topLabel.v_bottom+20, 0.5, 20)];
                VerLine.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
                [btnBackView addSubview:VerLine];
                
            }
        }else
        {
            
            
            for (int i=0; i<self.nameArr.count; i++)
            {
                
                UIView *  view=[btnBackView viewWithTag:i];
                UILabel * titleLabel=[view viewWithTag:101+i];
                UILabel * nameLabel=[view viewWithTag:201+i];
                titleLabel.text=[self.countArr objectAtIndex:i];
                titleLabel.text = @"0";
                nameLabel.text=[self.nameArr objectAtIndex:i];
                
            }
            
            
        }
        
        return headbackView;
        
    }
    
    return nil;
}
-(void)tapTopBtn:(UITapGestureRecognizer *)ges
{
    if (ges.view.tag ==1)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnIndex:)])
        {
            [self.delegate clickBtnIndex:1];
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
 
    
    UIButton * logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(15, 20, ScreenWidth-30, 40);
    [logoutBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    logoutBtn.backgroundColor = CommonlyUsedBtnColor;
    logoutBtn.layer.masksToBounds = YES;
    logoutBtn.layer.cornerRadius  = 5.0f;
    [view addSubview:logoutBtn];
    [logoutBtn addTarget:self action:@selector(outAmount) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame     = CGRectMake(15, 80, ScreenWidth-30, 20);
    lab1.textAlignment  = NSTextAlignmentCenter;
    lab1.font           = [UIFont systemFontOfSize:16.0f];
    lab1.textColor      = CommonlyUsedBtnColor;
//    [UIColor colorWithHexString:@"#ec4746"];
    lab1.text           = @"客服电话：4006336900";
    [view addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame     = CGRectMake(15, 120, ScreenWidth-30, 20);
    lab2.textAlignment  = NSTextAlignmentCenter;
    lab2.font           = [UIFont systemFontOfSize:16.0f];
    lab2.text           = @"山东珍味世家食品贸易有限公司";
    lab2.textColor      = CommonlyUsedBtnColor;
    [view addSubview:lab2];
    return view;
}
-(void)outAmount
{
    [self.delegate selectedMyViewControllerIndex:@"退出当前账号"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array=[self.dataArr objectAtIndex:indexPath.section];
    KGMineViewModel * model=[array objectAtIndex:indexPath.row];
    
    [self.delegate selectedMyViewControllerIndex:model.name];
    
}



@end
