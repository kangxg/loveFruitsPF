//
//  KGSettingVCTR.m
//  LoveFruits
//
//  Created by kangxg on 16/10/8.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSettingVCTR.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "KGSwitchTableCell.h"
#import "KGRightIconNullCell.h"
#import "KGHeadNoneRightCell.h"
#import "KGAboutMineAlertView.h"
#import "KGUserModelManager.h"
@implementation KGSettingVCTR
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.KVTitleLabel.text = @"设置";
    UITableView * tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 10 ,ScreenWidth,  50*2) style:UITableViewStylePlain];
    tableview.backgroundColor=LFBNavigationHomeSearchColor;
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    tableview.separatorColor=[UIColor colorWithHexString:@"#d8d8d8"];
    [self.view addSubview:tableview];

    
    
    UIButton * outBtn=[[UIButton alloc]initWithFrame:CGRectMake(11,tableview.v_bottom+15, ScreenWidth-22, 40)];
    
    outBtn.backgroundColor= CommonlyUsedBtnColor;
    outBtn.layer.masksToBounds=YES;
    outBtn.layer.cornerRadius=5;
    [outBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(outAmount) forControlEvents:UIControlEventTouchUpInside];
    outBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [self.view addSubview:outBtn];
}
-(void)outAmount
{
    
    KGUserModelManager * manager = [KGUserModelManager shareInstanced];
    [manager exitLogin];
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGOut  object:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * resuse=@"cell";
    switch (indexPath.row)
    {
        case 0:
        {
            KGSwitchTableCell * cell= [[KGSwitchTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse cellSize:CGSizeMake(ScreenWidth, 50)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.KVTitleLabel.text  = @"消息提醒";
            return cell;
        }
            break;
//        case 1:
//        {
//            KGRightIconNullCell * cell = [[KGRightIconNullCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse cellSize:CGSizeMake(ScreenWidth, 50)];
//            cell.KVTitleLabel.text = @"检查更新";
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            // app版本
//            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            cell.contenLabel.text = app_Version;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//            break;
        case 1:
        {
            KGHeadNoneRightCell * cell = [[KGHeadNoneRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuse cellSize:CGSizeMake(ScreenWidth, 50)];
            
            cell.KVTitleLabel.text = @"关于我们";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
 
    
        return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
// 
//    return 10.0;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        KGAboutMineAlertView * alertView = [KGAboutMineAlertView createAlertView:EN_NTAlertViewStyleCorner];
        [alertView ShowView];
    }
    
}

@end
