//
//  UIFont+Adapt.m
//  NashWorkSpace
//
//  Created by njguo on 15/9/6.
//  Copyright (c) 2015年 yilv. All rights reserved.
//

#import "UIFont+Adapt.h"

@implementation UIFont (Adapt)
+ (UIFont*) adaptFontOfSize:(CGFloat)size
{
    if (IPHONE6Plus) {
        size = 1*size;
    }
    
    return [UIFont systemFontOfSize:size];
}
@end
