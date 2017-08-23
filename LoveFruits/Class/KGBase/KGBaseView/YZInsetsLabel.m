//
//  YZInsetsLabel.m
//  YZJOB-2
//
//  Created by kangxg on 15/9/2.
//  Copyright (c) 2015年 lfh. All rights reserved.
//

#import "YZInsetsLabel.h"

@implementation YZInsetsLabel

@synthesize insets=_insets;
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
@end
