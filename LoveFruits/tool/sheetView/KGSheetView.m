//
//  KGSheetView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/17.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSheetView.h"
#import "UIColor+Extension.h"
#import "GlobelDefine.h"
@interface KGSheetView ()

@property(strong,nonatomic)UIView * backView;
@property(strong,nonatomic)UIView * showBackView;

@property(strong,nonatomic)NSArray * btnArr;
@end
@implementation KGSheetView
+(id)initWithSuperView:(UIView*)superView frame:(CGRect)frame titleContent:(NSString*)title cancleBtnName:(NSString *)cancleName otherBtnArr:(NSArray*)btnArr
{
    KGSheetView * view=[[KGSheetView alloc]initWithSuperView:superView frame:frame titleContent:title cancleBtnName:cancleName otherBtnArr:btnArr];
    return view;
}
+(id)initWithSuperView:(UIView*)superView frame:(CGRect)frame BtnArr:(NSArray*)btnArr
{
    KGSheetView  * view=[[KGSheetView  alloc]initWithSuperView:superView frame:frame BtnArr:btnArr];
    
    return view;
}
-(id)initWithSuperView:(UIView *)superView frame:(CGRect)frame titleContent:(NSString *)title cancleBtnName:(NSString *)cancleName otherBtnArr:(NSArray *)btnArr
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backView.backgroundColor=[UIColor blackColor];
        self.backView.alpha=0.2;
        [self addSubview:self.backView];
        
        if (title.length) {
            
            self.showBackView=[[UIView alloc]initWithFrame:CGRectMake(5, frame.size.height-(44*2+btnArr.count*44+10), frame.size.width-10, 44*2+btnArr.count*44)];
            UILabel * titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
            titleLabel.userInteractionEnabled=YES;
            titleLabel.text=title;
            titleLabel.font=[UIFont systemFontOfSize:12];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.textColor= CommonlyUsedBtnColor;
            [self.showBackView addSubview:titleLabel];

            
            [self.showBackView addSubview:titleLabel];
            
            UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, frame.size.width-10, 0.5)];
            [self.showBackView addSubview:line];
            line.backgroundColor=[UIColor colorWithHexString:@"#d8d8d8"];
            
            
        }
        else
        {
            self.showBackView=[[UIView alloc]initWithFrame:CGRectMake(5, frame.size.height-(btnArr.count*44+5+44+5), frame.size.width-10, btnArr.count*44)];
        }
        
        self.showBackView.backgroundColor=[UIColor whiteColor];
        self.showBackView.layer.masksToBounds=YES;
        self.showBackView.layer.cornerRadius=5;
        self.showBackView.layer.borderWidth=0.5;
        self.showBackView.layer.borderColor=[[UIColor colorWithHexString:@"#d8d8d8"]CGColor];
        [self addSubview:self.showBackView];
        
        CGFloat h=title.length?44:0;
        for (int i=0; i<btnArr.count; i++) {
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(5,h+i*44, self.showBackView.frame.size.width, 44)];
            label.userInteractionEnabled=YES;
            label.text=[btnArr objectAtIndex:i];
            label.font=[UIFont systemFontOfSize:16];
            label.textAlignment=NSTextAlignmentCenter;
            [self.showBackView addSubview:label];

            label.tag=i+1;
            label.textColor=CommonlyUsedBtnColor;;
            UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
            [label addGestureRecognizer:tap];
            
            UIView * line=[[UIView alloc]initWithFrame:CGRectMake(5,h+i*43.5, self.showBackView.frame.size.width, 0.5)];
            [self.showBackView addSubview:line];
            line.backgroundColor=[UIColor colorWithHexString:@"#d8d8d8"];
            
            
        }
        
        
        UILabel * cancleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, self.showBackView.frame.origin.y+self.showBackView.frame.size.height+5, self.showBackView.frame.size.width, 44)];
        cancleLabel.backgroundColor=[UIColor whiteColor];
        cancleLabel.userInteractionEnabled=YES;
        cancleLabel.text=cancleName;
        cancleLabel.font=[UIFont systemFontOfSize:16];
        cancleLabel.textAlignment=NSTextAlignmentCenter;
        cancleLabel.textColor=[UIColor colorWithHexString:@"#333333"];
        [self addSubview:cancleLabel];
        cancleLabel.layer.borderColor=[[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
        cancleLabel.layer.borderWidth=0.5;
        cancleLabel.tag=0;
        cancleLabel.layer.masksToBounds=YES;
        cancleLabel.layer.cornerRadius=5;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
        [cancleLabel addGestureRecognizer:tap];
        
        
    }
    
    
    [superView addSubview:self];
    return self;
}
-(id)initWithSuperView:(UIView*)superView frame:(CGRect)frame BtnArr:(NSArray*)btnArr
{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)tapLabel:(UITapGestureRecognizer*)tap
{
    
    
    [self.KVDelegate pSelectWithIndex:tap.view.tag];
    
    [self removeFromSuperview];
    
    
}

@end
