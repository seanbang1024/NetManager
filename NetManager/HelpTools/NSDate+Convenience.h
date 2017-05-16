//
//  NSDate+Convenience.h
//  Vurig Calendar
//
//  Created by robin on 14/8/26.
//  Copyright (c) 2014年 Vurig. All rights reserved.
// 
#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;
-(int)numDaysInMonth;
//计算从一个日期当前日期之间的天数
-(int)numDaysFrom:(NSDate *)fromDate;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;
- (int)hour;

+(NSString *)weekDayFrom:(NSDate *)fromDate;


+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

@end