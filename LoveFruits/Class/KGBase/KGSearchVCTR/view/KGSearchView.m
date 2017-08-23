//
//  KGSearchView.m
//  LoveFruits
//
//  Created by kangxg on 16/5/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGSearchView.h"
#import "DefineBlock.h"
#import "UIColor+Extension.h"
@interface KGSearchView()
@property (nonatomic,retain)UILabel              *      MSearchLabel;
@property (nonatomic,retain)UIButton             *      MCleanBtn;;
@property (nonatomic,assign)CGFloat                     MLastX;
@property (nonatomic,assign)CGFloat                     MLastY;
@property (nonatomic,copy)KGButtonClickBlock            MButtonClickBlock;
@property (nonatomic,copy)KGButtonClickBlock            MCleankBlock;
@end

@implementation KGSearchView
-(void)setKGSearchHeight:(CGFloat)KGSearchHeight
{

}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _MLastX = 0;
        _MLastY = 30;
        [self addSubview:self.MSearchLabel];
        [self addSubview:self.MCleanBtn];
    }
    
    return self;
}


-(id)initWithFrame:(CGRect)frame withtitle:(NSString *)buttonTitle withSearchArry:(NSArray *)arr withBlock:(KGButtonClickBlock)searchBlock withClean:(KGButtonClickBlock)cleanblock
{
    if (self = [self initWithFrame:frame])
    {
        
        self.MSearchLabel.text  = buttonTitle;
        _MButtonClickBlock = searchBlock;
        _MCleankBlock      = cleanblock;
        CGFloat btnW    = 0;
        CGFloat btnH    = 30;
        CGFloat addW    = 30;
        CGFloat marginX = 10;
        CGFloat marginY = 10;
        for (int i = 0; i<arr.count; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn.titleLabel sizeToFit];
           
            btn.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
            [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = 15;
//            btn.layer.borderWidth = 0.5;
            [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       
            btnW = btn.titleLabel.frame.size.width + addW;
            
            if (frame.size.width - _MLastX > btnW )
            {
                btn.frame = CGRectMake(_MLastX, _MLastY, btnW, btnH);
            } else {
                btn.frame = CGRectMake(0, _MLastY + marginY + btnH, btnW, btnH);
            }
            
            _MLastX = CGRectGetMaxX(btn.frame) + marginX;
            _MLastY = btn.frame.origin.y;
            _KGSearchHeight = CGRectGetMaxY(btn.frame);
            
            [self addSubview:btn];

        }
    }
    return self;
}


-(void)searchButtonClick:(UIButton *)btn
{
    _MButtonClickBlock(btn);
}

-(void)cleanClick:(UIButton *)btn
{
    _MCleankBlock(btn);
}
-(UILabel *)MSearchLabel
{
    if (_MSearchLabel == nil)
    {
        _MSearchLabel = [[UILabel alloc]init];
        _MSearchLabel.frame = CGRectMake(0, 0, self.frame.size.width - 60, 20);
        _MSearchLabel.font  = [UIFont systemFontOfSize:15.0f];
        _MSearchLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _MSearchLabel;
}

-(UIButton *)MCleanBtn
{
    if (_MCleanBtn == nil)
    {
        _MCleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [_MCleanBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        [_MCleanBtn.titleLabel sizeToFit];
        _MCleanBtn.frame =CGRectMake(self.frame.size.width-50-11, 2, _MCleanBtn.titleLabel.frame.size.width , 20);
        [_MCleanBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _MCleanBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
       
       
        [_MCleanBtn addTarget:self action:@selector(cleanClick:) forControlEvents:UIControlEventTouchUpInside];
//        _MCleanBtn.backgroundColor = [UIColor redColor];
    }
    return _MCleanBtn;
}
@end
