//
//  UIColor+Extend.h
//  NashWorkSpace
//
//  Created by njguo on 15/9/6.
//  Copyright (c) 2015年 yilv. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UICOLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UICOLOR_RGB(r, g, b) UICOLOR_RGBA(r, g, b, 1)
#define  UIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  UIColorFromRGBA(rgbValue,aalpha)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)aalpha]
@interface UIColor (Extend)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+(UIColor *)getColorFromHexStr:(NSString *)hexColorStr;
@end
