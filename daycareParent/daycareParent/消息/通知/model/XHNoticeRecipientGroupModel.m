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
    [self setModelID:[object objectItemKey:@"id"]];  //!< 老师的id
    [self setTelphoneNumber:[object objectItemKey:@"telphoneNumber"]]; //!< 手机号
}




-(void)setParentsObject:(NSDictionary*)object
{
    [self setTitle:[object objectItemKey:@"studentName"]]; //!< 学生名称
    [self setObjectID:[object objectItemKey:@"studentId"]];  //!< 学生id
}


-(NSMutableArray<XHNoticerecipientParentModel *> *)parentArray
{
    if (!_parentArray)
    {
        _parentArray = [NSMutableArray array];
    }
    return _parentArray;
}

@end
