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
@end
