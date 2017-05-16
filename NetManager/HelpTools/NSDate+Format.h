//
//  NSDate+Format.h
//  MyTalk
//
//  Created by dingxin on 14-5-26.
//  Copyright (c) 2014年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

+(NSString*)nowStr;
+(NSDate *)dateFromString:(NSString*)dateString;

+(NSDate *)dateFromHourString:(NSString*)dateString;
+(NSDate *)dateFromCustomString:(NSString*)dateString;
+(NSDate *)dateFromString:(NSString*)dateString withFormat:(NSString *)formatStr;

-(NSString *)dateStringOther;

-(NSString *)dateString;

-(NSString *)dateStringToMinute;
- (NSString *)dateStringWithMonthHour;
-(NSString *)dateStringToHour;
-(NSString *)dateNormalString;
- (NSString *)dateStringWithMonthDay;
-(NSString *)dateStringWithWeekDay;

-(NSString*)dateStringWithFormat:(NSString *)formatStrin;
//时间戳格式的字符串
-(NSString *)customedDateStr;

- (NSString*)myDateFormatStr;

-(NSString *)helpFormateDateStr;
-(NSString *)helpFormateDateStrNotime;

-(NSString *)helpSumFormateDateStr;
-(NSString *)dateStringMonthCardFormatByGB;
-(NSString *)dateStringMonthCardChinesesFormatByGB;
//计算时间间隔
+(NSInteger)daysLeftSince:(NSDate *)theDate;
//剩余时间（分钟）
+(NSInteger)minutesLeftSice:(NSDate *)theDate;
//年 - 月 - 日
-(NSString *)dateStringOtherYear;
//2016.02.25 添加时间格式:2016.02.25 12:12:12
-(NSString*)nowPointStr;
//时间间隔
/**
 *  由数值类型的时间间隔生成时间字符串
 *
 *  @param theInterval NSTimeInterval类型的时间间隔
 *
 *  @return 格式化的时间字符串
 */
+(NSString *)dateDurationStrFromTimeInterval:(NSTimeInterval)theInterval;

@end
