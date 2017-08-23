//
//  KGProductDetailsdescriptionView.m
//  LoveFruits
//
//  Created by kangxg on 16/9/24.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGProductDetailsdescriptionView.h"
#import "KGProductDetailsModel.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
@interface KGProductDetailsdescriptionView()
@property (nonatomic,retain)UILabel       * MVTitleLabel;
@property (nonatomic,retain)UILabel       * MVDescriptLabel;

@end
@implementation KGProductDetailsdescriptionView
@synthesize  MVTitleLabel      = _MVTitleLabel;
@synthesize  MVDescriptLabel   = _MVDescriptLabel;
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self addSubview:self.MVTitleLabel];
        
        [self addSubview:self.MVDescriptLabel];
      
        
    }
    return self;
}

-(void)updateView:(KGProductDetailsModel *)model
{
    if (model)
    {
        NSString *labelText = model.description;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:9];//调整行间距
        NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       
                                       [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                       
                                       [UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName,
                                       
                                       paragraphStyle,NSParagraphStyleAttributeName,nil];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:attributeDict];
        
        _MVDescriptLabel.attributedText = attributedString;
        
        [_MVDescriptLabel sizeToFit];

    }
    
   
    
//    NSString *labelText =@"画江湖之不良人》是北京若森数字科技有限公司继《侠岚》在获取了巨大的市场成功之后推出的系列原创大型三维成人武侠动画钜制。故事的讲述方法非常符合国人的传统形式，弘扬传统文化，具有强烈的中国特色";
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:9];//调整行间距
//    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   
//                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
//                                   
//                                   [UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName,
//                                   
//                                   paragraphStyle,NSParagraphStyleAttributeName,nil];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:attributeDict];
//
//    _MVDescriptLabel.attributedText = attributedString;
//
//    [_MVDescriptLabel sizeToFit];
    

}

-(UILabel *)MVTitleLabel
{
    if (_MVTitleLabel == nil)
    {
        _MVTitleLabel = [[UILabel alloc]init];
        _MVTitleLabel.font = [UIFont systemFontOfSize:13.0f];
        _MVTitleLabel.textColor = [UIColor colorWithHexString:@"#2c2c2c"];
        _MVTitleLabel.text = @"产品详情";
        [_MVTitleLabel sizeToFit];
    }
    return _MVTitleLabel;
}

-(UILabel *)MVDescriptLabel
{
    if (_MVDescriptLabel == nil)
    {
        _MVDescriptLabel = [[UILabel alloc]init];
        _MVDescriptLabel.font = [UIFont systemFontOfSize:15.0f];
        _MVDescriptLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _MVDescriptLabel.numberOfLines = 0;
        _MVDescriptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
    }
    return _MVDescriptLabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
  
    _MVTitleLabel.frame =CGRectMake(11,15, self.v_width-22, _MVTitleLabel.v_height);

    CGRect rect = [_MVDescriptLabel.attributedText boundingRectWithSize:CGSizeMake(self.v_width-22, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    _MVDescriptLabel.frame  =CGRectMake(11,_MVTitleLabel.v_bottom+8 , self.v_width-22, rect.size.height);
    self.frame = CGRectMake(self.v_x, self.v_y, self.v_width, _MVDescriptLabel.v_bottom);
}
@end
