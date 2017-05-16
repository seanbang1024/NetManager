//
//  UIImage+Extend.m
//  MyVideo
//
//  Created by dingxin on 14/11/26.
//  Copyright (c) 2014年 wangfei. All rights reserved.
//

#import "UIImage+Extend.h"

#import "DeviceUtil.h"


#define kImageMaxWidthForLow  1024
#define kImageMaxHeightForLow 1024

#define kImageMaxWidth  2048
#define kImageMaxHeight 2048

@implementation UIImage (Extend)

//创建一个纯色的图片（根据颜色，大小创建）
+ (UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//给图片着色
- (UIImage *)imageWithColor:(UIColor *)tintColor
{
    CGFloat imageScale = [self scale];
    CGSize imagSize = CGSizeMake(self.size.width*imageScale, self.size.height*imageScale);
    UIGraphicsBeginImageContext(imagSize);
    
    CGRect drawRect = CGRectMake(0, 0, imagSize.width, imagSize.height);
    [self drawInRect:drawRect];
    [tintColor set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceAtop);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (imageScale == 1) {
        return image;
    }else{
        UIImage *tarImg = [UIImage imageWithCGImage:image.CGImage scale:imageScale orientation:UIImageOrientationUp];
        
        return tarImg;
    }
    
}

//缩放图片到指定的size
- (UIImage *)dx_scaleToSize:(CGSize)tarSize
{
    CGFloat imageScale = [self scale];
    CGSize imagSize = CGSizeMake(tarSize.width*imageScale, tarSize.height*imageScale);
    UIGraphicsBeginImageContext(imagSize);
    
    CGRect drawRect = CGRectMake(0, 0, imagSize.width, imagSize.height);
    [self drawInRect:drawRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (imageScale == 1) {
        return image;
    }else{
        UIImage *tarImg = [UIImage imageWithCGImage:image.CGImage scale:imageScale orientation:UIImageOrientationUp];
        
        return tarImg;
    }
}

//图片压缩处理(压缩到指定大小的NSData)
-(NSData *)compressImageToByteSize:(NSInteger)limitSizeByte
{
    NSData* data = UIImageJPEGRepresentation(self, 1);
    //缩略图
    //压缩处理
    if ([data length]>limitSizeByte) {
        
        for (int i=1; i<10; i++) {
            //每次降低0.1的图片质量，直到大小符合要求（新浪的是小于32k）
            CGFloat compressionQuality = 1.0-i/10.0;
            data = UIImageJPEGRepresentation(self, compressionQuality);
            
            if ([data length]<limitSizeByte) {
                break;
            }
        }
    }
    
    return data;
}


//纠正图片方向旋转图片
+(UIImage *)fixImageOrientation:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            return aImage;
//            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

+ (UIImage *)fixrotation:(UIImage *)image{
    
    
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)scaleToSize:(CGSize)size {
    /*UIGraphicsBeginImageContext(size);
     [self drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
     UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();*/
    return [self imageCompressForSize:self targetSize:size];
}
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


//图片压缩处理
+(UIImage *)scaleImageAdeptCurDevice:(UIImage *)theOrImg
{
    UIImage *scaledImg = theOrImg;
    
    BOOL lowDevice = NO;
    NSString *curDeviceModeStr = [[NSString alloc] initWithString:[DeviceUtil hardwareString]];
    Hardware curDeviceMode = [DeviceUtil hardware];
    Hardware lowDeviceMode = IPHONE_4S;
    if ([curDeviceModeStr rangeOfString:@"iPhone"].location != NSNotFound) {
        //iPhone设备
        lowDeviceMode = IPHONE_4S;  //iPhone4S
    }else if ([curDeviceModeStr rangeOfString:@"iPod"].location != NSNotFound) {
        //iPod设备
        lowDeviceMode = IPOD_TOUCH_5G;    //ipod touch 5
        
    }else if ([curDeviceModeStr rangeOfString:@"iPad"].location != NSNotFound) {
        //iPad设备
        lowDeviceMode = IPAD_2_CDMA;      //ipad 2()
    }
    
    if (curDeviceMode <= lowDeviceMode) {
        //设备型号不大于指定型号
        lowDevice = YES;
    }
    
    CGFloat maxWidth = lowDevice? kImageMaxWidthForLow:kImageMaxWidth;
    CGFloat maxHeight  = lowDevice? kImageMaxHeightForLow:kImageMaxHeight;
    
//    if (lowDevice) {
        //压缩图片
        CGSize imgSize = theOrImg.size;
        if (imgSize.width*imgSize.height > maxWidth*maxHeight)
        {
            //图片较大——>压缩图片
            CGSize scaleImgSize = CGSizeZero;
            
            if (imgSize.width!=0 && imgSize.height!=0) {
                if (imgSize.width/imgSize.height>1) {
                    //宽图
                    if (imgSize.width>kImageMaxWidth) {
                        CGFloat newWidth = kImageMaxWidth;
                        CGFloat newHeight = imgSize.height*(newWidth/imgSize.width);
                        
                        scaleImgSize = CGSizeMake(newWidth, newHeight);
                    }else{
                        scaleImgSize = imgSize;
                    }
                }else{
                    //长图
                    if (imgSize.height>kImageMaxHeight) {
                        CGFloat newHeight = kImageMaxHeight;
                        CGFloat newWidth = imgSize.width*(newHeight/imgSize.height);
                        
                        scaleImgSize = CGSizeMake(newWidth, newHeight);
                    }else{
                        scaleImgSize = imgSize;
                    }
                }
            }
            if (!CGSizeEqualToSize(scaleImgSize, CGSizeZero)) {
                scaledImg = [theOrImg dx_scaleToSize:scaleImgSize]; // should be thimg //for test
            }
        }
//    }
    
    
    return scaledImg;
}

@end
