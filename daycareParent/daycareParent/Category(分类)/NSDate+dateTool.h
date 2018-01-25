//
//  NSDate+dateTool.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YYMMDDHHMM @"yy-MM-dd HH:mm"
#define HH_DEFAULT_TIME_FORM @"HH:mm"
#define MM_DEFAULT_TIME_FORM @"MM-dd"
#define DEFAULT_TIME_FORM @"MM/dd HH:mm"
#define DEFAULT_TIME_FORM1 @"MM-dd HH:mm"
#define YY_DEFAULT_TIME_FORM @"yyyy-MM-dd"
#define YY_DEFAULT_TIME_FORM1 @"yy-MM-dd"
#define ALL_DEFAULT_TIME_FORM @"yyyy-MM-dd HH:mm:ss"
#define ALL_TIME_DEFAULT_TIME_FORM @"yyyy-MM-dd HH:mm"
#define ALL_DEFAULT_TIME_FORM_FFF @"yyyy-MM-dd HH:mm:ss.SSS"

@interface NSDate (dateTool)

/**
 时间date转时间字符串

 @param dateFormatter 时间格式
 @param date 时间
 @return 时间date转时间字符串
 */
+(NSString *)getDateStrWithDateFormatter:(NSString *)dateFormatter Date:(NSDate *)date;
/**
 时间字符串转日期date

 @param dateStr 时间字符串
 @param formatter 时间格式
 @return 日期date
 */
+(NSDate *)getDateWithDateStr:(NSString *)dateStr formatter:(NSString *)formatter;
/**
 制定日期几天前日期

 @param date 指定日期
 @param dayBefor 几天
 @return 制定日期几天前日期
 */
+(NSDate *)getDayBeforWithDate:(NSDate *)date dayBefor:(NSInteger )dayBefor;

/**
 制定日期几天后日期

 @param date 指定日期
 @param dayAfter 几天
 @return 制定日期几天后日期
 */
+(NSDate *)getDayAfterWithDate:(NSDate *)date dayAfter:(NSInteger )dayAfter;
@end
