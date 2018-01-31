//
//  XHUserInfo.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserInfo.h"
#import "XHClassListModel.h"
#import "XHSubjectListModel.h"
@implementation XHUserInfo

static XHUserInfo *userInfo = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedUserInfo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    userInfo = [[self alloc]init];
    });
    
   return userInfo;
    
}

-(void)setItemObject:(NSDictionary*)object
{
    _sessionId=[object objectItemKey:@"sessionId"];
    _token=[object objectItemKey:@"token"];
    NSDictionary *dic=[object objectItemKey:@"user"];
    _birthdate=[dic  objectItemKey:@"birthdate"];
    _headPic=[dic objectItemKey:@"headPic"];
    _ID=[dic objectItemKey:@"id"];
    _loginName=[dic objectItemKey:@"loginName"];
     _nickName=[dic objectItemKey:@"nickName"];
    _selfId=[dic objectItemKey:@"selfId"];
      _sex=[dic objectItemKey:@"sex"];
     _signature=[dic objectItemKey:@"signature"];
    _telphoneNumber=[dic objectItemKey:@"telphoneNumber"];
     _userType=[dic  objectItemKey:@"userType"];
    _loginIp=[dic objectItemKey:@"loginIp"];
    _isActive=[dic objectItemKey:@"isActive"];
    _isRoot=[dic objectItemKey:@"isRoot"];
    _schoolId=[dic objectItemKey:@"relationCode"];
    _primaryFamilyId=[[object objectItemKey:@"propValue"] objectItemKey:@"primaryFamilyId"];
    _guardianModel=[[XHGuardianInfo alloc] initWithDic:[[object objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
    switch ([self.sex integerValue])
    {
        case 0:
        {
            _sexName=@"女";
        }
            break;
        case 1:
        {
            _sexName=@"男";
            
        }
            break;
    }
}
-(void)getClassList:(ClassListBlock)calssListBock
{
    [self.classListNet setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
    [self.classListNet postWithUrl:@"pmschool-teacher-api_/teacher/attendanceSheet/classList" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject)
        {
            NSArray *arr=[object objectItemKey:@"object"];
            [self.classListArry removeAllObjects];
            for (NSDictionary *dic in arr)
            {
                XHClassListModel *model=[[XHClassListModel alloc] initWithDic:dic];
                [self.classListArry addObject:model];
            }
            calssListBock(YES,self.classListArry);
        }
        else
        {
            calssListBock(NO,self.classListArry);
        }
    } error:^(NSError *error) {
        calssListBock(NO,self.classListArry);
    }];
}
-(void)getSubjectList:(SubjectListBlock)subjectListBock
{
    [self.subjectListNet setObject:[XHUserInfo sharedUserInfo].teacherModel.userId forKey:@"teacherId"];
    [self.subjectListNet postWithUrl:@"pmschool-teacher-api_/teacher/schoolwork/getSubjectAll" sucess:^(id object, BOOL verifyObject){
        if (verifyObject)
        {
                NSArray *arr=[object objectItemKey:@"object"];
                [self.subjectListArry removeAllObjects];
                for (NSDictionary *dic in arr)
                {
                    XHSubjectListModel *model=[[XHSubjectListModel alloc] initWithDic:dic];
                    [self.subjectListArry addObject:model];
                }
            
                subjectListBock(YES,self.subjectListArry);
        }
        else
        {
             subjectListBock(NO,self.subjectListArry);
        }
    } error:^(NSError *error) {
        subjectListBock(NO,self.subjectListArry);
    }];
}
-(XHTeacherInfo *)teacherModel
{
    if (_teacherModel==nil) {
      _teacherModel=[XHTeacherInfo new];
    }
    return _teacherModel;
}
-(NSMutableArray *)childListArry
{
    if (!_childListArry)
    {
        _childListArry = [NSMutableArray array];
    }
    return _childListArry;
}
-(NSMutableArray *)classListArry
{
    if (!_classListArry)
    {
        _classListArry = [NSMutableArray array];
    }
    return _classListArry;
}
-(NSMutableArray *)subjectListArry
{
    if (!_subjectListArry)
    {
        _subjectListArry = [NSMutableArray array];
    }
    return _subjectListArry;
}
                  
-(XHNetWorkConfig *)classListNet
{
    if (_classListNet==nil) {
        _classListNet=[XHNetWorkConfig new];
    }
    return _classListNet;
}
-(XHNetWorkConfig *)subjectListNet
{
    if (_subjectListNet==nil) {
        _subjectListNet=[XHNetWorkConfig new];
    }
    return _subjectListNet;
}
@end
