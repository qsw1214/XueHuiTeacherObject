//
//  XHHelper.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHHelper : NSObject

@property(nonatomic,strong) UIViewController *currentViewController;//!< 获取当前视图控制器

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedHelper;


#pragma mark 发布食谱
/**
 发布食谱
 
 @param booking 发布食谱
 */
+(NSString*)BookingSituation:(NSString*)booking;


#pragma mark 拨打电话
/**
 拨打电话
 
 @param phone 电话号码
 */
-(void)telephone:(NSString*)phone;



#pragma mark 发送信息
/**
 发送信息

 @param phone 手机号
 */
-(void)sendMessage:(NSString*)phone;



+ (void)uploadImage:(UIImage *)image name:(NSString *)name uploadCallback:(void (^)(BOOL success, NSError *error))uploadCallback withProgressCallback:(void (^)(float progress))progressCallback;
+ (NSString *)ageFarment:(NSDate *)date;

+ (void)uploadVideo:(NSData *)videoData name:(NSString *)name uploadCallback:(void (^)(BOOL success, NSError * error))uploadCallback withProgressCallback:(void (^)(float progress))progressCallback;
/**
 *创建UUID
 */
+ (NSString *)createGuid;


#pragma mark 返回周几
/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSString*)weekdayWithDate:(NSString*)fromDate;

/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSInteger)weekdayWithNowDate:(NSDate*)fromDate;



#pragma mark 返回星期几
/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSString*)weekdayStringWithNowDate:(NSDate*)fromDate;


/**
 返回当前日期 如：4月30日
 
 @return 4月30日
 */
+(NSString*)monthAndDay;
/**
 判断是否为iphonex
 
 @return 判断是否为iphonex
 */
- (BOOL)isIphoneX;

+(NSString*)iphoneType;

@end
