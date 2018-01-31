//
//  XHNoticeRecipientModel.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHNoticeRecipientModelType)
{
    XHNoticeRecipientFullSelectionType = 1, //!< 全选类型
    XHNoticeRecipientNormalType = 2, //!< 普通类型
    XHNoticeRecipientStudentType = 3, //!< 学生类型
    XHNoticeRecipientTeacherType = 4, //!< 老师类型
};

typedef NS_ENUM(NSInteger,XHNoticeRecipientSelectType)
{
    XHNoticeRecipientNormalityType = 1, //!< 普通类型
    XHNoticeRecipientSelectedType = 2, //!< 选中类型
};


#import "BaseModel.h"

@interface XHNoticeRecipientModel : BaseModel

@property (nonatomic,copy)   NSString *title; //!< 标题
@property (nonatomic,copy)   NSString *describe;
@property (nonatomic,assign) NSInteger total; //!< 总共
@property (nonatomic,assign) NSInteger select; //!< 选择




@property (nonatomic,assign) XHNoticeRecipientModelType modelType; //!< 数据内容类型
@property (nonatomic,assign) XHNoticeRecipientSelectType selectType; //!< 选择类型






@end
