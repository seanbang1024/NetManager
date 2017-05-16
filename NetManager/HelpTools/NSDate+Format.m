//
//  NSDate+Format.m
//  MyTalk
//
//  Created by dingxin on 14-5-26.
//  Copyright (c) 2014年 dingxin. All rights reserved.
//

#import "NSDate+Format.h"
#import "NSDate+Convenience.h"

@implementation NSDate (Format)

+(NSString*)nowStr
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:[NSDate date]];
    return str;
}
+(NSDate *)dateFromString:(NSString*)dateString
{
    if (dateString==nil||[dateString isEqualToString:@""]) {
        return nil;
    }
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSDate *theDate=[format dateFromString:dateString];
    
    return theDate;
}
+(NSDate *)dateFromHourString:(NSString*)dateString;
{
    if (dateString==nil||[dateString isEqualToString:@""]) {
        return nil;
    }
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSDate *theDate=[format dateFromString:dateString];
    
    return theDate;
}
+(NSDate *)dateFromCustomString:(NSString*)dateString
{
    if (dateString==nil||[dateString isEqualToString:@""]) {
        return nil;
    }
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd"];
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSDate *theDate=[format dateFromString:dateString];
    
    return theDate;
}

+(NSDate *)dateFromString:(NSString*)dateString withFormat:(NSString *)formatStr
{
    if (dateString==nil||[dateString isEqualToString:@""]) {
        return nil;
    }
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:formatStr];
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSDate *theDate=[format dateFromString:dateString];
    
    return theDate;
}

-(NSString *)dateStringOther
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

-(NSString *)dateStringOtherYear
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}
//20161223
-(NSString *)dateStringMonthCardFormatByGB
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    return str;
}
//20161223
-(NSString *)dateStringMonthCardChinesesFormatByGB
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

-(NSString *)dateNormalString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}
//不要修改这个方法，消息中要用这个方法
-(NSString *)dateString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];

    return str;
}

-(NSString *)dateStringToHour
{
     NSDateFormatter *format=[[NSDateFormatter alloc] init];
     [format setDateFormat:@"HH:mm"];
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

-(NSString*)nowPointStr
{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    return str;
}

/**
 *  @author 郭榜, 15-11-20 13:11:24
 *
 *  当天时间,昨天 以00:00 为准
 *
 *  @return <#return value description#>
 */
-(NSString *)dateStringToHourHelp
{
    
    NSDate *now = [NSDate date];
    NSDate *theDate = self;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *nowDateStr = [dateFormat stringFromDate:now];
    NSString *tarDateStr = [dateFormat stringFromDate:theDate];
    
    if ([nowDateStr isEqualToString:tarDateStr]) {
        //当天
        [dateFormat setDateFormat:@"HH:mm"];
    }else {
        //非当天
        [dateFormat setDateFormat:@"MM-dd HH:mm"];
        
    }
    
    NSLocale *usLocale = [NSLocale currentLocale];
    [dateFormat setLocale:usLocale];

    NSString *str=[dateFormat stringFromDate:self];
    
    return str;
}


-(NSString *)dateStringToMinute
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

- (NSString *)dateStringWithMonthDay
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月dd日"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

- (NSString *)dateStringWithMonthAndDay
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd HH:mm"];
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

- (NSString *)dateStringWithMonthHour
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd HH:mm"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}

-(NSString *)dateStringWithWeekDay
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月dd日 cccc HH:mm"];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];
    
    return str;
}



-(NSString*)dateStringWithFormat:(NSString *)formatString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:formatString];
    //    format
    NSLocale *usLocale = [NSLocale currentLocale];
    [format setLocale:usLocale];
    NSString *str=[format stringFromDate:self];

    return str;
}

- (NSString*)myDateFormatStr
{
    NSString *dateStr = @"";
    
    NSDate *now = [NSDate date];
    NSDate *theDate = self;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *nowDateStr = [dateFormat stringFromDate:now];
    NSString *tarDateStr = [dateFormat stringFromDate:theDate];
    
    if ([nowDateStr isEqualToString:tarDateStr]) {
        //当天
        [dateFormat setDateFormat:@"a hh:mm"];
        dateStr = [dateFormat stringFromDate:theDate];
    }else {
        //非当天
        //是不是昨天
        NSDate *nowDayDate = [dateFormat dateFromString:nowDateStr];
        NSDate *tarDayDate = [dateFormat dateFromString:tarDateStr];
        NSTimeInterval dayInter = [nowDayDate timeIntervalSinceDate:tarDayDate];
        if (dayInter == 60*60*24) {
            //昨天
            [dateFormat setDateFormat:@"昨天 HH:mm"];
            dateStr = [dateFormat stringFromDate:theDate];
        }else{
            //昨天以前
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            dateStr = [dateFormat stringFromDate:theDate];
        }
        
    }
    
    
    return dateStr;
    
}

-(NSString *)helpFormateDateStr
{
    NSDate *nowDate = [NSDate date];
    
    NSDate *yesterdayDate = [nowDate offsetDay:-1];
    
    NSString *dateStr = @"";
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];//monday is first day
    NSDateComponents *tarDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:self];
    NSDateComponents *nowDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:nowDate];
    NSDateComponents *yesterdayDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:yesterdayDate];

    NSInteger tarDay = tarDateComponents.day;
    NSInteger tarWeekOfYear = tarDateComponents.weekOfYear;
    NSInteger tarYear = tarDateComponents.year;
    
    NSInteger nowDay = nowDateComponents.day;
    NSInteger nowWeekOfYear = nowDateComponents.weekOfYear;
    NSInteger nowYear = nowDateComponents.year;
    
    NSInteger yesterdayDay = yesterdayDateComponents.day;
    NSInteger yesterdayWeekOfYear = yesterdayDateComponents.weekOfYear;
    NSInteger yesterdayYear = yesterdayDateComponents.year;
    
    NSString *dateFormatStr = @"yy/MM/dd HH:mm";
    
    if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear && tarDay == nowDay) {
        //当天    :    上午 10:00
        dateFormatStr = @"HH:mm";
    }else {
        //昨天
        BOOL isYesterday = NO;
        if (tarYear == yesterdayYear && tarWeekOfYear == yesterdayWeekOfYear && tarDay == yesterdayDay) {
            //
            isYesterday = YES;
        }
        
        if (isYesterday && tarYear == nowYear) {
            //同一年的昨天 ->昨天  :  昨天 上午 10:00
            dateFormatStr = @"昨天 HH:mm";
            
        }else if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear) {
            //一周之内 :  星期三 上午 10:00
            dateFormatStr = @"cccc HH:mm";
        }else if (tarYear == nowYear){
            //同一年
            dateFormatStr = @"MM/dd HH:mm";
        }else{
            //不同年
            dateFormatStr = @"yy/MM/dd HH:mm";
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStr];
    
    dateStr = [dateFormatter stringFromDate:self];
    
    return dateStr;
}

-(NSString *)helpFormateDateStrNotime
{
    NSDate *nowDate = [NSDate date];
    
    NSDate *yesterdayDate = [nowDate offsetDay:-1];
    
    NSString *dateStr = @"";
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];//monday is first day
    NSDateComponents *tarDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:self];
    NSDateComponents *nowDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:nowDate];
    NSDateComponents *yesterdayDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:yesterdayDate];
    
    NSInteger tarDay = tarDateComponents.day;
    NSInteger tarWeekOfYear = tarDateComponents.weekOfYear;
    NSInteger tarYear = tarDateComponents.year;
    
    NSInteger nowDay = nowDateComponents.day;
    NSInteger nowWeekOfYear = nowDateComponents.weekOfYear;
    NSInteger nowYear = nowDateComponents.year;
    
    NSInteger yesterdayDay = yesterdayDateComponents.day;
    NSInteger yesterdayWeekOfYear = yesterdayDateComponents.weekOfYear;
    NSInteger yesterdayYear = yesterdayDateComponents.year;
    
    NSString *dateFormatStr = @"yy/MM/dd HH:mm";
    
    if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear && tarDay == nowDay) {
        //当天    :    上午 10:00
        dateFormatStr = @"HH:mm";
    }else {
        //昨天
        BOOL isYesterday = NO;
        if (tarYear == yesterdayYear && tarWeekOfYear == yesterdayWeekOfYear && tarDay == yesterdayDay) {
            //
            isYesterday = YES;
        }
        
        if (isYesterday && tarYear == nowYear) {
            //同一年的昨天 ->昨天  :  昨天 上午 10:00
            dateFormatStr = @"昨天";
            
        }else if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear) {
            //一周之内 :  星期三 上午 10:00
            dateFormatStr = @"cccc";
        }else if (tarYear == nowYear){
            //同一年
            dateFormatStr = @"MM/dd";
        }else{
            //不同年
            dateFormatStr = @"yy/MM/dd";
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStr];
    
    dateStr = [dateFormatter stringFromDate:self];
    
    return dateStr;
}

-(NSString *)helpSumFormateDateStr
{
    NSDate *nowDate = [NSDate date];
    
    NSDate *yesterdayDate = [nowDate offsetDay:-1];
    
    NSString *dateStr = @"";
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *tarDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:self];
    NSDateComponents *nowDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:nowDate];
    NSDateComponents *yesterdayDateComponents = [gregorian components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear|NSCalendarUnitDay fromDate:yesterdayDate];
   

    
    NSInteger tarDay = tarDateComponents.day;
    NSInteger tarWeekOfYear = tarDateComponents.weekOfYear;
    NSInteger tarYear = tarDateComponents.year;
    
    NSInteger nowDay = nowDateComponents.day;
    NSInteger nowWeekOfYear = nowDateComponents.weekOfYear;
    NSInteger nowYear = nowDateComponents.year;
    
    NSInteger yesterdayDay = yesterdayDateComponents.day;
    NSInteger yesterdayWeekOfYear = yesterdayDateComponents.weekOfYear;
    NSInteger yesterdayYear = yesterdayDateComponents.year;
    
    NSString *dateFormatStr = @"yy/MM/dd";
    
    if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear && tarDay == nowDay) {
        //当天    :    上午 10:00
        dateFormatStr = @"HH:mm";
    }else {
        //昨天
        BOOL isYesterday = NO;
        if (tarYear == yesterdayYear && tarWeekOfYear == yesterdayWeekOfYear && tarDay == yesterdayDay) {
            //
            isYesterday = YES;
        }

        if (isYesterday && tarYear == nowYear) {
            //同一年的昨天 ->昨天  :  昨天 上午 10:00
            dateFormatStr = @"昨天";
            
        }else if (tarYear == nowYear && tarWeekOfYear == nowWeekOfYear) {
            //一周之内 :  星期三 上午 10:00
            dateFormatStr = @"cccc";
        }else if (tarYear == nowYear){
            //同一年
            dateFormatStr = @"MM/dd";
        }else{
            //不同年
            dateFormatStr = @"yy/MM/dd";
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStr];
    
    dateStr = [dateFormatter stringFromDate:self];
    
    return dateStr;
}

//时间戳格式的字符串
-(NSString *)customedDateStr
{
    
    NSString *orderInfo = @"";
    NSMutableString *dateInfoStr = [[NSMutableString alloc] init];
    
    BOOL isLaterDate;  //是不是未来的日期
    
    NSTimeInterval tInterval = [self timeIntervalSinceNow];

    isLaterDate = tInterval>0;
    if (isLaterDate) {
        orderInfo = @"后";
    }else{
        orderInfo = @"前";
    }
    
    NSTimeInterval ti = fabs(tInterval);
    
    if(ti < 60) {
//        if (isLaterDate) {
//            return @"即将";
//        }else{
            return @"刚刚";
//        }
    }

    else if (ti < 3600) {
        
        int diff = round(ti / 60);
        
        [dateInfoStr setString:[NSString stringWithFormat:@"%d分钟", diff]];
        [dateInfoStr appendString:orderInfo];
        
        return dateInfoStr;
        
    } else if (ti < 60*60*24) {
        
//        int diff = round(ti / 60 / 60);
//        
//        [dateInfoStr setString:[NSString stringWithFormat:@"%d小时", diff]];
//        [dateInfoStr appendString:orderInfo];
//        
//        return dateInfoStr;
        
       return [self dateStringToHourHelp];
        
        
    } else if (ti < 60*60*24*12) {
        
//        int diff = round(ti / 60 / 60 / 24);
//        
//        [dateInfoStr setString:[NSString stringWithFormat:@"%d天", diff]];
//        [dateInfoStr appendString:orderInfo];
//        
//        return dateInfoStr;
        return [self dateStringWithMonthAndDay];
        
    } else if (ti<60*60*24*30*12)
    {
//        int diff=round(ti/60/60/24/30);
//        
//        [dateInfoStr setString:[NSString stringWithFormat:@"%d月", diff]];
//        [dateInfoStr appendString:orderInfo];
//        
//        return dateInfoStr;
        
        return [self dateStringWithMonthAndDay];
    }else {
//        int diff=round(ti/60/60/24/30/12);
//        
//        [dateInfoStr setString:[NSString stringWithFormat:@"%d年", diff]];
//        [dateInfoStr appendString:orderInfo];
//        
//        return dateInfoStr;
        return [self dateStringOtherYear];
    }
    
}

//-(NSString *)customedDateStrBeforeAfter
//{
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
//    return (int)[components year] ;
//}


//计算时间间隔
+(NSInteger)daysLeftSince:(NSDate *)theDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;  //计算单位 天
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date] toDate:theDate options:0];
    NSInteger days = [comps day];
    return days;
}

//剩余时间（分钟）
+(NSInteger)minutesLeftSice:(NSDate *)theDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMinuteCalendarUnit;  //计算单位 分
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date] toDate:theDate options:0];
    NSInteger minutes = [comps minute];
    return minutes;
}

//
//-(void)timerMethod:(NSTimer*)theTimer
//{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *doomsday = [[NSDateComponents alloc] init];//目标时间
//    [doomsday setYear:2012];
//    [doomsday setMonth:12];
//    [doomsday setDay:21];
//    [doomsday setHour:0];
//    [doomsday setMinute:0];
//    [doomsday setSecond:0];
//    NSDate *todate = [cal dateFromComponents:doomsday];//把目标时间装入date
//    [doomsday release];
//    
//    NSDate *today = [NSDate date];//当前时间
//    unsigned int unitFlag = NSYearCalendarUnit |NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *gap = [cal components:unitFlag fromDate:today toDate:todate options:0];//计算时间差
//    timerLab.text = [NSString stringWithFormat:@"距离世界末日还有：%d年%d月%d日%d时%d分%d秒",[gap year],[gap month], [gap day],[gap hour], [gap minute], [gap second]];
//}


//时间间隔
/**
 *  由数值类型的时间间隔生成时间字符串
 *
 *  @param theInterval NSTimeInterval类型的时间间隔
 *
 *  @return 格式化的时间字符串
 */
+(NSString *)dateDurationStrFromTimeInterval:(NSTimeInterval)theInterval
{
    NSDate *fromeDate = [NSDate date];
    NSDate *tarDate = [NSDate dateWithTimeInterval:theInterval sinceDate:fromeDate];
    
    NSDateComponents *dateDuration = [NSDate calculateDurationFromDate:fromeDate toDate:tarDate];
    
    NSString *durationStr = [NSString stringWithFormat:@"%02d:%02d:%02d",dateDuration.hour, dateDuration.minute, dateDuration.second];
    
    return durationStr;
}


+(NSDateComponents *)calculateDurationFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSYearCalendarUnit |NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateGap = [cal components:unitFlag fromDate:fromDate toDate:toDate options:0];//计算时间差
    
//    timerLab.text = [NSString stringWithFormat:@"距离世界末日还有：%d年%d月%d日%d时%d分%d秒",[gap year],[gap month], [gap day],[gap hour], [gap minute], [gap second]];
    
    return dateGap;
}


//+(NSDate *)getDateFrom
//{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *doomsday = [[NSDateComponents alloc] init];//目标时间
//    [doomsday setYear:2012];
//    [doomsday setMonth:12];
//    [doomsday setDay:21];
//    [doomsday setHour:0];
//    [doomsday setMinute:0];
//    [doomsday setSecond:0];
//    NSDate *todate = [cal dateFromComponents:doomsday];//把目标时间装入date
//
//    return todate;
//}

@end
