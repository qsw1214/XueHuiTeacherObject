//
//  XHNattendanceModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNattendanceModel.h"

@implementation XHNattendanceModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _attendanceName=[dic objectItemKey:@"attendanceName"];
        _relationId=[dic objectItemKey:@"relationId"];
        _position=[dic objectItemKey:@"position"];
        _picUrl=[dic objectItemKey:@"picUrl"];
        _attendanceTime=[dic objectItemKey:@"attendanceTime"];
        _direction=[dic objectItemKey:@"direction"];
        _attendanceType=[[dic objectItemKey:@"attendanceType"] integerValue];
        switch (_attendanceType) {
            case XHAttendanceCard:
            {
                _attendanceStr=@"考勤卡";
            }
                break;
            case XHAttendanceManual:
            {
                _attendanceStr=@"手动打卡";
            }
                break;
            case XHAttendanceBuka:
            {
                _attendanceStr=@"手动补卡";
            }
                break;
            case XHAttendanceRFID:
            {
                _attendanceStr=@"rfid读头打卡";
            }
                break;
        }
    }
    return self;
}
@end
