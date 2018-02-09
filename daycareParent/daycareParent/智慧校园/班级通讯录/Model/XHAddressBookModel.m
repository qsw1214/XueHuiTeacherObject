//
//  XHAddressBookModel.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookModel.h"

@implementation XHAddressBookModel


-(NSMutableArray<NSString *> *)courseArray
{
    if (!_courseArray)
    {
        _courseArray = [NSMutableArray array];
    }
    return _courseArray;
}



-(void)setTeacherName:(NSString *)teacherName
{
    _teacherName = teacherName;
    [self setKey:[teacherName getFirstLetterFromString]];
}

-(void)setItemObject:(NSDictionary *)object
{
    [self setTeacherName:[object objectItemKey:@"teacherName"]];
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"headPic"])];
    [self setHeadPic:[object objectItemKey:@"headPic"]];
    [self setPhone:[object objectItemKey:@"telphoneNumber"]];
    [self setUserID:[object objectItemKey:@"id"]];
    [self.courseArray setArray:[self getArry:[object objectItemKey:@"clazzList"]]];
    [self setSelectType:XHAddressBookModelNormalType];
}

-(void)setParentsItemObject:(NSDictionary *)object
{
    
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"headPic"])];
    [self setHeadPic:[object objectItemKey:@"headPic"]];
    [self setPhone:[object objectItemKey:@"telphoneNumber"]];
    [self setUserID:[object objectItemKey:@"id"]];
    [self setObjectID:[object objectItemKey:@"studentBaseId"]];
    [self setSelectType:XHAddressBookModelNormalType];
}




-(NSArray *)getArry:(NSString *)str
{
    
    if ([[NSString safeString:str] isEqualToString:@""])
    {
        
        return @[@"暂无"];
    }
    else
    {
        return  [str componentsSeparatedByString:@","];
    }
    
}



@end
