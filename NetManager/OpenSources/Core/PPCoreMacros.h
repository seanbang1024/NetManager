//
//  PPCoreMacros.h
//  PPLibTest
//
//  Created by Paul Wang on 12-6-12.
//  Copyright (c) 2012年 pengjay.cn@gmail.com. All rights reserved.
//

#define PP_NIL(__POINTER) { __POINTER = nil; }
#define PP_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define PP_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }
#define PP_RETAIN(__new, __old) { [__new retain]; [__old release]; __old = __new; }
#define UICOLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UICOLOR_RGB(r, g, b) UICOLOR_RGBA(r, g, b, 1)
#define  UIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  UIColorFromRGBA(rgbValue,aalpha)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)aalpha]