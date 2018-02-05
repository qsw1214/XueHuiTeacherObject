//
//  XHAddressBookModel.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,XHAddressBookModelSelectType)
{
    XHAddressBookSelectType = 1,   //!< 选中类型
    XHAddressBookModelNormalType = 2, //正常类型
};

typedef NS_ENUM(NSInteger,XHAddressBookModelType)
{
    XHAddressBookTeacherType = 1,   //!< 教师类型
    XHAddressBookParentType = 2, // 家长端类型
};


#import "BaseModel.h"

@interface XHAddressBookModel : BaseModel

@property (nonatomic,copy) NSString *key; //!< 当前数据模型的key值
@property (nonatomic,copy) NSString *headerUrl; //!< 全部头像url
@property (nonatomic,copy) NSString *headPic; //!< 原头像pic
@property (nonatomic,copy) NSString *teacherName; //!< 老师名称
@property (nonatomic,copy) NSString *phone; //!< 手机
@property (nonatomic,copy) NSString *userID; //!< 用户ID
@property (nonatomic,strong) NSMutableArray <NSString *> *courseArray; //!< 课程数组




@property (nonatomic,assign) XHAddressBookModelType modelType;
@property (nonatomic,assign) XHAddressBookModelSelectType selectType;


-(void)setParentsItemObject:(NSDictionary *)object;

@end
