//
//  XHNoticeRecipientModel.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//


typedef NS_ENUM(NSInteger,XHNoticeRecipientGroupSelectType)
{
    XHNoticeRecipientGroupNormalityType = 1, //!< 普通类型
    XHNoticeRecipientGroupSelectedType = 2, //!< 选中类型
};

typedef NS_ENUM(NSInteger,XHNoticeRecipientGroupModelType)
{
    XHNoticeRecipientGroupTeacherType = 1, //!< 老师
    XHNoticeRecipientGroupStudentType = 2, //!< 学生
};

/**
 当前用户确认的状态,发送通知以该状态为准
 */
typedef NS_ENUM(NSInteger,XHNoticeRecipientGroupOptionSelectType)
{
    XHNoticeRecipientGroupOptionNormalityType = 1, //!< 普通类型
    XHNoticeRecipientGroupOptionSelectedType = 2, //!< 选中类型
};


#import "BaseModel.h"
#import "XHNoticerecipientParentModel.h"


@interface XHNoticeRecipientGroupModel : BaseModel



@property (nonatomic,copy) NSString *modelID; //!< 当前数据模型id
@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *telphoneNumber; //!< 手机号
@property (nonatomic,assign) NSInteger total; //!< 总共
@property (nonatomic,assign) NSInteger select; //!< 选择
@property (nonatomic,assign) NSInteger guardian; //!< 监护人




@property (nonatomic,strong) NSMutableArray <XHNoticerecipientParentModel*> *parentArray;

@property (nonatomic,assign) XHNoticeRecipientGroupModelType modelType;
@property (nonatomic,assign) XHNoticeRecipientGroupSelectType selectType; //!< 选择类型
@property (nonatomic,assign) XHNoticeRecipientGroupOptionSelectType optionSelectType; //!< 用户确认选择的类型


-(void)setTeacherObject:(NSDictionary*)object;
-(void)setParentsObject:(NSDictionary*)object;







@end
