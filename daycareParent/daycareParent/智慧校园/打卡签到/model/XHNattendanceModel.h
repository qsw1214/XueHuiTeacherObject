//
//  XHNattendanceModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,XHPunchSignModelType)
{
    XHAttendanceCard = 1,            //考勤卡
    XHAttendanceManual = 2,       //手动打卡
    XHAttendanceBuka = 3,      //手动补卡
    XHAttendanceRFID = 4      //rfid读头打卡
};

@interface XHNattendanceModel : NSObject
@property (nonatomic, copy) NSString *attendanceName,*relationId,*position,*picUrl;
@property (nonatomic, copy)  NSString *attendanceTime;
@property (nonatomic, copy)  NSString *attendanceStr;
@property (nonatomic, assign) XHPunchSignModelType attendanceType;//打卡类型" #1考勤机  2 手工打卡 3  RDF读头
@property (nonatomic, copy) NSString *direction;
-(id)initWithDic:(NSDictionary *)dic;
@end
