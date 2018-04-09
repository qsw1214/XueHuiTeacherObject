//
//  XHUserInfo.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserInfo.h"

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

#pragma mark 获取班级列表
/**
 获取班级列表
 
 @param calssListBock 回调block
 */
-(void)getClassList:(ClassListBlock)calssListBock
{
    if ([XHUserInfo sharedUserInfo].isClassList)
    {
        calssListBock(YES,self.classListArry);
        return;
    }
    [XHShowHUD showTextHud];
    [self.classListNet setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
    [self.classListNet postWithUrl:@"pmschool-teacher-api_/teacher/attendanceSheet/classList" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            [XHShowHUD hideHud];
            NSArray *arr=[object objectItemKey:@"object"];
            if (arr.count!=0)
            {
                [self.classListArry removeAllObjects];
                for (NSDictionary *dic in arr)
                {
                    XHClassListModel *model=[[XHClassListModel alloc] initWithDic:dic];
                    [self.classListArry addObject:model];
                }
                [XHUserInfo sharedUserInfo].isClassList=YES;
                calssListBock(YES,self.classListArry);
            }
            else
            {
                [XHShowHUD showNOHud:@"暂无数据"];
                calssListBock(NO,self.classListArry);
            }
            
        }
        else
        {
            calssListBock(NO,self.classListArry);
        }
    } error:^(NSError *error) {
        calssListBock(NO,self.classListArry);
    }];
}

#pragma mark 获取学科列表
/**
 获取学科列表
 
 @param subjectListBock 回调block
 */
-(void)getSubjectList:(SubjectListBlock)subjectListBock
{
    if ([XHUserInfo sharedUserInfo].isSubjectsList)
    {
        subjectListBock(YES,self.subjectListArry);
        return;
    }
    [XHShowHUD showTextHud];
    [self.subjectListNet setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.subjectListNet postWithUrl:@"pmschool-teacher-api_/teacher/schoolwork/getSubjectAll" sucess:^(id object, BOOL verifyObject){
        if (verifyObject)
        {
             [XHShowHUD hideHud];
            NSArray *arr=[object objectItemKey:@"object"];
            if (arr.count!=0)
            {
                [self.subjectListArry removeAllObjects];
                for (NSDictionary *dic in arr)
                {
                    XHSubjectListModel *model=[[XHSubjectListModel alloc] initWithDic:dic];
                    [self.subjectListArry addObject:model];
                }
                [XHUserInfo sharedUserInfo].isSubjectsList=YES;
                subjectListBock(YES,self.subjectListArry);
            }
            else
            {
                [XHShowHUD showNOHud:@"暂无数据"];
                subjectListBock(NO,self.subjectListArry);
            }
            
        }
        else
        {
             subjectListBock(NO,self.subjectListArry);
        }
    } error:^(NSError *error) {
        subjectListBock(NO,self.subjectListArry);
    }];
}


#pragma mark 获取教师通讯录列表
/**
 获取教师通讯录列表
 
 @param succeedBlock 回调的通讯录数组succeedBlock
 */
-(void)getTeachersAddressBook:(AddressBookSucceedBlock)succeedBlock
{
    if (userInfo.isTeachersAddressBook)
    {
        succeedBlock(YES,self.teachersAddressBookArray);
    }
    else
    {
        XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
        [netWorkConfig setObject:userInfo.schoolId forKey:@"schoolId"];
        [netWorkConfig setObject:userInfo.sessionId forKey:@"sessionId"];
        [netWorkConfig postWithUrl:@"zzjt-app-api_notice001" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 
                 NSDictionary *objectDictionary = [object objectItemKey:@"object"];
                 NSArray *itemArray = [objectDictionary objectItemKey:@"list"];
                 
                 
                 if ([NSObject isArray:itemArray])
                 {
                     [self.teachersAddressBookArray setArray:itemArray];
                 }
                 
                 if ([self.teachersAddressBookArray count])
                 {
                     [userInfo setIsTeachersAddressBook:YES];
                     succeedBlock(YES,self.teachersAddressBookArray);
                 }
                 else
                 {
                     [userInfo setIsTeachersAddressBook:NO];
                     succeedBlock(NO,self.teachersAddressBookArray);
                 }
                 
                 
             }
             else
             {
                 succeedBlock(NO,self.teachersAddressBookArray);
             }
         } error:^(NSError *error)
         {
             succeedBlock(NO,self.teachersAddressBookArray);
         }];
    }
}



#pragma mark 获取家长通讯录列表
/**
 获取家长通讯录列表
 
 @param succeedBlock 回调的通讯录数组succeedBlock
 */
-(void)getParentsAddressBook:(AddressBookSucceedBlock)succeedBlock
{
    if (userInfo.isparentsAddressBook)
    {
       succeedBlock(YES,userInfo.parentsAddressBookArray);
    }
    else
    {
        XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
        [netWorkConfig setObject:userInfo.selfId forKey:@"teacherId"];
        [netWorkConfig postWithUrl:@"zzjt-app-api_notice003" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 
                 NSArray *objectArray = [object objectItemKey:@"object"];
                 
                 if ([NSObject isArray:objectArray])
                 {
                     [userInfo.parentsAddressBookArray setArray:objectArray];
                 }
                 
                 if ([userInfo.parentsAddressBookArray count])
                 {
                     [userInfo setIsparentsAddressBook:YES];
                     succeedBlock(YES,userInfo.parentsAddressBookArray);
                 }
                 else
                 {
                     [userInfo setIsparentsAddressBook:NO];
                     succeedBlock(NO,userInfo.parentsAddressBookArray);
                 }
             }
             else
             {
                succeedBlock(YES,userInfo.parentsAddressBookArray);
             }
             
         } error:^(NSError *error)
         {
             succeedBlock(YES,userInfo.parentsAddressBookArray);
         }];
    }
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

-(NSMutableArray *)teachersAddressBookArray
{
    if (!_teachersAddressBookArray)
    {
        _teachersAddressBookArray = [NSMutableArray array];
    }
    return _teachersAddressBookArray;
}


-(NSMutableArray *)parentsAddressBookArray
{
    if (!_parentsAddressBookArray)
    {
        _parentsAddressBookArray = [NSMutableArray array];
    }
    return _parentsAddressBookArray;
}

-(XHNetWorkConfig *)classListNet
{
    if (_classListNet==nil)
    {
        _classListNet=[XHNetWorkConfig new];
    }
    return _classListNet;
}
-(XHNetWorkConfig *)subjectListNet
{
    if (_subjectListNet==nil)
    {
        _subjectListNet = [XHNetWorkConfig new];
    }
    return _subjectListNet;
}
@end
