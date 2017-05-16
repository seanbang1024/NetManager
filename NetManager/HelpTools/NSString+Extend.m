
//
//  NSString+Extend.m
//  NashWorkSpace
//
//  Created by njguo on 15/9/6.
//  Copyright (c) 2015年 yilv. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
#include <sys/stat.h>
#include <dirent.h>

@implementation  NSString (zzCategory)


- (NSString*)stripWhiteSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*)stripWhiteSpaceAndNewLine{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//md5加密     bitNumber 16 32 位数
- (NSString*)md5Hash:(NSInteger)bitNum{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[bitNum];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02X",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString*)sha1Hash{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15],
            result[16], result[17], result[18], result[19]
            ];
}

- (NSString*)encodeBase64
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [GTMBase64 encodeData:data];
    NSString* base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* base64Str = [NSString stringWithFormat:@"%@", base64String];
    return base64Str;
}

- (BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}




-(BOOL) validateCreaditNumber
{
    NSString *creaditRegex = @"/^(998801|998802|622525|622526|435744|435745|483536|528020|526855|622156|622155|356869|531659|622157|627066|627067|627068|627069)d{10}$/";
    NSPredicate *creaditTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", creaditRegex];
    return [creaditTest evaluateWithObject:self];
    
    
}
-(NSString *)cutStrToLength:(NSInteger)tarLength
{
    NSInteger oriLength = [self length];
    if (oriLength<=tarLength) {
        return self;
    }else{
        NSInteger cutNum = oriLength-tarLength+1;
        
        NSInteger headLength = (oriLength-cutNum)/2;
        NSInteger backLength = (oriLength-cutNum)-headLength;
        
        NSString *headStr = [self substringWithRange:NSMakeRange(0, headLength)];
        NSString *backStr = [self substringWithRange:NSMakeRange(oriLength-backLength, backLength)];
        NSString *tarStr = [NSString stringWithFormat:@"%@...%@", headStr, backStr];
        
        return tarStr;
    }
}

//从特定格式的图片URL中获取图片的尺寸
-(CGSize)getPicSizeFromStr
{
    //http://115.28.86.175:8080/media/pic//58e_6ce27_2ae26_size960x1208.jpg
    CGSize tarSize = CGSizeZero;
    
    NSRange tagRang = [self rangeOfString:@"size"];
    if (tagRang.location!=NSNotFound) {
        //有
        NSString *sizeToEndStr = [self substringFromIndex:tagRang.location];
        NSRange dotRang = [sizeToEndStr rangeOfString:@"."];
        if (dotRang.location!=NSNotFound) {
            NSString *sizeStr = [sizeToEndStr substringWithRange:NSMakeRange(tagRang.length, dotRang.location-tagRang.length)];
            NSArray *w_H_array = [sizeStr componentsSeparatedByString:@"x"];
            if ([w_H_array count]==2) {
                CGFloat width = [[w_H_array firstObject] floatValue];
                CGFloat height = [[w_H_array lastObject] floatValue];
                
                tarSize =  CGSizeMake(width, height);
            }
        }
    }
    
    return tarSize;
}

-(NSInteger)getAudioLength
{
    NSInteger audioDuration = 0;
    
    NSRange tagRang = [self rangeOfString:@"_length"];
    if (tagRang.location!=NSNotFound) {
        //有
        NSString *lengthToEndStr = [self substringFromIndex:tagRang.location];
        NSRange dotRang = [lengthToEndStr rangeOfString:@"."];
        if (dotRang.location!=NSNotFound) {
            NSString *lengthStr = [lengthToEndStr substringWithRange:NSMakeRange(tagRang.length, dotRang.location-tagRang.length)];
            if (lengthStr) {
                audioDuration = [lengthStr integerValue];
            }
        }
    }
    
    return audioDuration;
}


- (int)convertToInt
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}


- (NSUInteger)getToInt

{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return [da length];
}

- (int)calc_charsetNum
{
    unsigned result = 0;
    const char *tchar=[self UTF8String];
    if (NULL == tchar) {
        return result;
    }
    result = strlen(tchar);
    return result;
}


-(NSString*)stringByAddWidth:(CGFloat)width
{
    NSString *str= [NSString stringByAddWidth:width String:self];
    return str;
}
//将字符串加上高度参数
-(NSString*)stringByAddWidth:(CGFloat)width Height:(CGFloat)height
{
    NSString *str= [NSString stringByAddWidth:width Height:height String:self];
    NSLog(@"%@",str);
    return str;
}
//将字符串加上高度参数
+(NSString*)stringByAddWidth:(CGFloat)width Height:(CGFloat)height String:(NSString*)str
{
    height=[UIScreen mainScreen].scale*height;
    return [ [NSString stringByAddWidth:width String:str] stringByAppendingFormat:@"&height=%d",(int)height ];
}
//将字符串加上宽度参数
+(NSString*)stringByAddWidth:(CGFloat)width String:(NSString*)str
{
    width=[UIScreen mainScreen].scale*width;
    return [str stringByAppendingFormat:@"?width=%d",(int)width];
}



// 方法3：完全使用unix c函数
+ (long long) folderSizeAtPath3:(NSString*) folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}
+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}
+(NSString*)generateUUID;
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        result = (NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
        //        result = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    return [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end

