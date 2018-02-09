//
//  XHNoticeMarkModel.m
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeMarkModel.h"

@implementation XHNoticeMarkModel

-(NSString *)teacherID
{
    if ([self.teacherArray count])
    {
        _teacherID = [self.teacherArray componentsJoinedByString:@","];
    }
    else
    {
        _teacherID = @"";
    }
    return _teacherID;
}

-(NSString *)teacherPhone
{
    if ([self.teacherPhoneArray count])
    {
        _teacherPhone = [self.teacherPhoneArray componentsJoinedByString:@","];
    }
    else
    {
        _teacherPhone = @"";
    }
    return _teacherPhone;
}


-(NSString *)guardianID
{
    if ([self.guardianIDArray count])
    {
        _guardianID = [self.guardianIDArray componentsJoinedByString:@","];
    }
    else
    {
        _guardianID = @"";
    }
    return _guardianID;
}

-(NSString *)guardianNumber
{
    if ([self.guardianNumberArray count])
    {
        _guardianNumber = [self.guardianNumberArray componentsJoinedByString:@","];
    }
    else
    {
        _guardianNumber = @"";
    }
    return _guardianNumber;
}

-(NSMutableArray *)teacherArray
{
    if (!_teacherArray)
    {
        _teacherArray = [NSMutableArray array];
    }
    return _teacherArray;
}

-(NSMutableArray *)teacherPhoneArray
{
    if (!_teacherPhoneArray)
    {
        _teacherPhoneArray = [NSMutableArray array];
    }
    return _teacherPhoneArray;
}

-(NSMutableArray *)guardianIDArray
{
    if (!_guardianIDArray)
    {
        _guardianIDArray = [NSMutableArray array];
    }
    return _guardianIDArray;
}

-(NSMutableArray *)guardianNumberArray
{
    if (!_guardianNumberArray)
    {
        _guardianNumberArray = [NSMutableArray array];
    }
    return _guardianNumberArray;
}








@end
