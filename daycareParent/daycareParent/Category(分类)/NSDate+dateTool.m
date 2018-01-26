//
//  NSDate+dateTool.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "NSDate+dateTool.h"

@implementation NSDate (dateTool)

#pragma mark  时间字符串转时间date
+(NSDate *)getDateWithDateStr:(NSString *)dateStr formatter:(NSString *)formatter
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setDateFormat:formatter];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    return date;
}
#pragma mark  时间date转字符串
+(NSString *)getDateStrWithDateFormatter:(NSString *)dateFormatter Date:(NSDate *)date
{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = dateFormatter;
    NSString * dateStr = [dateFor stringFromDate:date];
    return dateStr;
}
#pragma mark  时间字符串转换为指定时间格式字符串
+(NSString *)dateStr:(NSString *)dateStr FromFormatter:(NSString *)fromFormatter ToFormatter:(NSString *)toFormatter
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setDateFormat:fromFormatter];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [myDateFormatter setDateFormat:toFormatter];
    NSString *String=[myDateFormatter stringFromDate:date];
    return String;
}
#pragma mark  得到指定日期几天前的日期
+(NSDate *)getDayBeforWithDate:(NSDate *)date dayBefor:(NSInteger )dayBefor
{
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60*dayBefor sinceDate:date];//前几天
    return lastDay;
}
#pragma mark  得到指定日期几天后的日期
+(NSDate *)getDayAfterWithDate:(NSDate *)date dayAfter:(NSInteger )dayAfter
{
     NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60*dayAfter sinceDate:date];//后一天
    return nextDat;
}
#pragma mark 从某时到某时多长时间
+(NSDateComponents *)howLongFromeDateStr:(NSString *)fromeDateStr toDateStr:(NSString *)toDateStr formatter:(NSString *)formatterStr
{
////    // 1.确定时间
//    NSString *time1 = @"2013-06-23";
//    NSString *time2 = @"2015-06-28";
////
    // 2.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSDate *fromeDate = [formatter dateFromString:fromeDateStr];
    NSDate *toDate = [formatter dateFromString:toDateStr];
    
    // 3.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 4.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:fromeDate toDate:toDate options:0];
    // 5.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps;
}
@end
