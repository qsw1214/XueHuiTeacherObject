//
//  XHNoticeRecipientModel.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientGroupModel.h"

@implementation XHNoticeRecipientGroupModel


-(void)setTeacherObject:(NSDictionary*)object
{
    [self setTitle:[object objectItemKey:@"teacherName"]]; //!< 老师名称
    [self setObjectID:[object objectItemKey:@"id"]];  //!< 老师的id
}




-(void)setParentsObject:(NSDictionary*)object
{
    [self setTitle:[object objectItemKey:@"guardianName"]]; //!< 老师名称
    [self setObjectID:[object objectItemKey:@"id"]];  //!< 老师的id
}

@end
