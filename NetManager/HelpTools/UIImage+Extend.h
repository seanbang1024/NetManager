//
//  UIImage+Extend.h
//  MyVideo
//
//  Created by dingxin on 14/11/26.
//  Copyright (c) 2014年 wangfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

//创建一个纯色的图片（根据颜色，大小创建）
+ (UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size;

//给图片着色
- (UIImage *)imageWithColor:(UIColor *)tintColor;

//缩放图片到指定的size
- (UIImage *)dx_scaleToSize:(CGSize)tarSize;

//图片压缩处理(压缩到指定大小的NSData)
-(NSData *)compressImageToByteSize:(NSInteger)limitSizeByte;

//纠正图片方向旋转图片
+(UIImage *)fixImageOrientation:(UIImage *)aImage;

+ (UIImage *)fixrotation:(UIImage *)image;

- (UIImage *)scaleToSize:(CGSize)size;

//图片压缩处理
+(UIImage *)scaleImageAdeptCurDevice:(UIImage *)theOrImg;

@end
