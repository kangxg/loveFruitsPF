//
//  KGSearchScanfGroup.m
//  LoveFruits
//
//  Created by kangxg on 16/9/18.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchScanfGroup.h"
#import "GlobelDefine.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"

@interface KGSearchScanfGroup()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UIView * MVBackView;
@property(strong,nonatomic)UITableView * MVTableview;

@property(strong,nonatomic)NSMutableArray * MDataArr;
@end
@implementation KGSearchScanfGroup
-(instancetype)initWithSuperview:(UIView *)superview andFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        _MVBackView = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, 0, ScreenWidth, ScreenHeight-frame.origin.y)];
//        
//        [self addSubview:_MVBackView];
        self.backgroundColor= [UIColor whiteColor];
        _MVTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        _MVTableview.backgroundColor=[UIColor whiteColor];
        _MVTableview.showsVerticalScrollIndicator=NO;
        _MVTableview.delegate=self;
        _MVTableview.dataSource=self;
//        _MVTableview.separatorColor=searchBottom;
        _MVTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:_MVTableview];

    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
-(void)dissmissMyself
{
    self.hidden = YES;
    
}

-(void)refreshUIWithArr:(NSMutableArray *)arr
{
    self.hidden = false;
    [self.MDataArr removeAllObjects];
    self.MDataArr=[arr mutableCopy];
    [self.MVTableview reloadData];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        UILabel * line = [[UILabel alloc]init];
        line.frame   = CGRectMake(0, 47.5, ScreenWidth, 0.5);
        line.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        [cell addSubview:line];
        
    }
    cell.textLabel.text=[self.MDataArr objectAtIndex:indexPath.row];
//    cell.textLabel.textColor=searchPlaceholder;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
//    cell.backgroundColor=searchBottom;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.KVDelegate && [self.KVDelegate respondsToSelector:@selector(pSearchGoods:)])
    {
        [self.KVDelegate pSearchGoods:[self.MDataArr  objectAtIndex:indexPath.row]];
    }
   
    
}

@end
