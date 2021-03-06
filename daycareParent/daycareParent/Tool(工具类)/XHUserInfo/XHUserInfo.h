//
//  XHUserInfo.h
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHClassListModel.h"
#import "XHSubjectListModel.h"

typedef void(^ClassListBlock)(BOOL isOK,NSMutableArray *classListArry);
typedef void(^SubjectListBlock)(BOOL isOK,NSMutableArray *subjectListArry);
typedef void (^AddressBookSucceedBlock) (BOOL isOK,NSMutableArray *array);




@interface XHUserInfo : NSObject

@property (nonatomic,copy) NSString *userType; //!< 类别
@property (nonatomic,copy) NSString *birthdate;//!< birthdate
@property (nonatomic,copy) NSString *headPic;//!< 个人设置头像
@property (nonatomic,copy) NSString *ID;//!< ID
@property (nonatomic,copy) NSString *loginName;//!< 登录名
@property (nonatomic,copy) NSString *nickName; //!< nickName

@property (nonatomic,copy) NSString *teacherName; //!< 通讯录名字
@property (nonatomic,copy) NSString *userPic; //!< 通讯录头像
@property (nonatomic,copy) NSString *userId; //!< 通讯录ID

@property (nonatomic,copy) NSString *selfId;   //!< teacherId
@property (nonatomic,copy) NSString *sessionId;//!< sessionId
@property (nonatomic,copy) NSString *sex;//!< 性别
@property (nonatomic,copy) NSString *sexName;//!< 性别
@property (nonatomic,copy) NSString *signature;//!< 签名
@property (nonatomic,copy) NSString *telphoneNumber;//!< 电话
@property (nonatomic,copy) NSString *token; //!<token
@property (nonatomic,copy) NSString *loginIp; //!<loginIp
@property (nonatomic,copy) NSString *isActive; //!<isActive
@property (nonatomic,copy) NSString *isRoot; //!<isRoot
@property (nonatomic,copy) NSString *schoolId; //!<schoolId

@property(nonatomic,assign) BOOL isClassList;//!< 是否请求过班级列表
@property(nonatomic,assign) BOOL isSubjectsList;//!< 是否请求过学科列表
@property(nonatomic,assign) BOOL isTeachersAddressBook;//!< 是否请求过教师通讯录列表
@property(nonatomic,assign) BOOL isparentsAddressBook;//!< 是否请求过家长通讯录列表
@property (nonatomic,strong) NSMutableArray *classListArry; //!<班级列表信息
@property(nonatomic,strong) XHNetWorkConfig *classListNet;  //!<班级列表请求
@property (nonatomic,strong) NSMutableArray *subjectListArry; //!<学科列表信息
@property(nonatomic,strong) XHNetWorkConfig *subjectListNet;  //!<学科列表请求

@property (nonatomic,strong) NSMutableArray *teachersAddressBookArray; //!< 教师通讯录
@property (nonatomic,strong) NSMutableArray *parentsAddressBookArray;  //!< 家长通讯录

@property(nonatomic,assign)NSInteger sum;//!< 未读消息

/**
 单例初始化方法
 
 @return 单例对象
 */


+ (instancetype)sharedUserInfo;



/**
 给单例赋值数据源

 @param object 传入数据源字典
 */
-(void)setItemObject:(NSDictionary*)object;



#pragma mark 获取班级列表
/**
 获取班级列表

 @param calssListBock 回调block
 */
-(void)getClassList:(ClassListBlock)calssListBock;

#pragma mark 获取学科列表
/**
 获取学科列表
 
 @param subjectListBock 回调block
 */
-(void)getSubjectList:(SubjectListBlock)subjectListBock;



#pragma mark 获取教师通讯录列表
/**
 获取教师通讯录列表

 @param block 回调的通讯录数组block
 */
-(void)getTeachersAddressBook:(AddressBookSucceedBlock)block;



#pragma mark 获取家长通讯录列表
/**
 获取家长通讯录列表
 
 @param block 回调的通讯录数组block
 */
-(void)getParentsAddressBook:(AddressBookSucceedBlock)block;

@end
