//
//  NSString+Extend.h
//  NashWorkSpace
//
//  Created by njguo on 15/9/6.
//  Copyright (c) 2015年 yilv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:str]

//判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil||[str isEqualToString:@""])
//判断字符串不为空并且不为空字符串
#define StringNotNullNorEmpty(str) (str!=nil&&![str isEqualToString:@""])
//快速格式化一个字符串
#define _S(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]

@interface NSString (zzCategory)

/**
 去除两端空格。
 */
- (NSString*)stripWhiteSpace;

/**
 去除两端空格及换行。
 */
- (NSString*)stripWhiteSpaceAndNewLine;

/**
 计算md5hash
 */
- (NSString*)md5Hash:(NSInteger)bitNum;

/**
 计算sha1hash
 */
- (NSString*)sha1Hash;

//是否合法邮箱地址
- (BOOL)validateEmail;

-(BOOL) validateCreaditNumber;

-(NSString *)cutStrToLength:(NSInteger)tarLength;

//从特定格式的图片URL中获取图片的尺寸
//如：http://115.28.86.175:8080/media/pic//58e_6ce27_2ae26_size960x1208.jpg
-(CGSize)getPicSizeFromStr;

-(NSInteger)getAudioLength;

- (int)convertToInt;
- (NSUInteger)getToInt;
//- (int)calc_charsetNum;

-(NSString*)stringByAddWidth:(CGFloat)width;
//将字符串加上高度参数
-(NSString*)stringByAddWidth:(CGFloat)width Height:(CGFloat)height;

+ (long long) folderSizeAtPath3:(NSString*) folderPath;
+(NSString*)generateUUID;

- (NSString *)generateTradeNO;

+(NSString*)DataTOjsonString:(id)object;
@end
