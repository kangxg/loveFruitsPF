//
//  UIDevice+Extension.m
//  LoveFruits
//
//  Created by kangxg on 16/4/29.
//  Copyright © 2016年 kangxg. All rights reserved.
//

#import "UIDevice+Extension.h"
#import "GlobelDefine.h"
@implementation UIDevice (Extension)
+(int)currentDeviceScreenMeasurement
{
     int  deviceScree = 3;
    if ((ScreenWidth == 568 && ScreenHeight == 320)||(1136 == ScreenHeight && 640 == ScreenWidth))
    {
         deviceScree = 4.0;
    }
    else if ((667 == ScreenHeight && 375 == ScreenWidth) || (1334 == ScreenHeight && 750 == ScreenWidth))
    {
        deviceScree = 5;
    } else if ((736 == ScreenHeight && 414 == ScreenWidth) || (2208 == ScreenHeight && 1242 == ScreenWidth)) {
        deviceScree = 6;
    }
    
    return deviceScree;
}
@end
