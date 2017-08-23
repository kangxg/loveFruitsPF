//
//  KGCustomButton.m
//  LoveFruits
//
//  Created by kangxg on 16/5/11.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "KGCustomButton.h"
#import "UIView+Extension.h"
@implementation KGCustomButton

@end

@implementation KGUpImageDownTextButton

-(void)layoutSubviews
{
    [super layoutSubviews];
   // CGFloat Offset = 15;
    if (self.titleLabel)
    {
        [self.titleLabel sizeToFit];
        self.titleLabel.frame = CGRectMake(0,self.v_height - 15, self.v_width , self.titleLabel.v_height);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    if (self.imageView)
    {
        
        self.imageView.frame = CGRectMake(0, 0, self.v_width, self.v_height - 15);
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    
}

@end

@implementation KGNavItemLeftImageButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Offset = 15;
    if (self.titleLabel)
    {
        [self.titleLabel sizeToFit];
        self.titleLabel.frame = CGRectMake(-Offset,self.v_height - 15, self.v_width- Offset, self.titleLabel.v_height);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    }
    
    if (self.imageView)
    {

        self.imageView.frame = CGRectMake(-Offset, 0, self.v_width - Offset, self.v_height - 15);
        self.imageView.contentMode = UIViewContentModeCenter;
    }


}

@end


@implementation KGNavItemRightImageButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Offset = 15;
    if (self.titleLabel)
    {
        [self.titleLabel sizeToFit];
        self.titleLabel.frame = CGRectMake(Offset,self.v_height - 15, self.v_width+ Offset, self.titleLabel.v_height);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    if (self.imageView)
    {
        
        self.imageView.frame = CGRectMake(Offset, 0, self.v_width + Offset, self.v_height - 15);
        self.imageView.contentMode = UIViewContentModeCenter;
    }
}


@end

