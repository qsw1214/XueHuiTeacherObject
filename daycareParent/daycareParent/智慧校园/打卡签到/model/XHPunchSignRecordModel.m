//
//  XHPunchSignRecordModel.m
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignRecordModel.h"

@implementation XHPunchSignRecordModel


-(void)setItemObject:(NSDictionary *)object
{
    [self setTitle:[object objectItemKey:@"week"]];
    [self setDate:[object objectItemKey:@"attendanceDate"]];
    [self setTime:[object objectItemKey:@"attendancetime"]];
    
    NSString *timeType = [NSString safeString:[object objectItemKey:@"timeType"]];
    if ([timeType isEqualToString:@"上午"])
    {
        [self setMarkIcon:@"ico_morning"];
    }
    else if ([timeType isEqualToString:@"下午"])
    {
        [self setMarkIcon:@"ico_afternoon"];
    }
    else if ([timeType isEqualToString:@"晚上"])
    {
        [self setMarkIcon:@"ico_afternoon"];
    }
}


@end
