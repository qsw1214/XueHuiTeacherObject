//
//  XHNoticeRecipientModel.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHNoticeRecipientGroupModelType)
{
    XHNoticeRecipientGroupFullSelectionType = 1, //!< 全选类型
    XHNoticeRecipientGroupStudentType = 2, //!< 学生类型
    XHNoticeRecipientGroupTeacherType = 3, //!< 老师类型
};

typedef NS_ENUM(NSInteger,XHNoticeRecipientGroupSelectType)
{
    XHNoticeRecipientGroupNormalityType = 1, //!< 普通类型
    XHNoticeRecipientGroupSelectedType = 2, //!< 选中类型
};


#import "BaseModel.h"

@interface XHNoticeRecipientGroupModel : BaseModel

@property (nonatomic,copy)   NSString *title; //!< 标题
@property (nonatomic,copy)   NSString *describe;
@property (nonatomic,assign) NSInteger total; //!< 总共
@property (nonatomic,assign) NSInteger select; //!< 选择




@property (nonatomic,assign) XHNoticeRecipientGroupModelType modelType; //!< 数据内容类型
@property (nonatomic,assign) XHNoticeRecipientGroupSelectType selectType; //!< 选择类型


-(void)setTeacherObject:(NSDictionary*)object;
-(void)setParentsObject:(NSDictionary*)object;





@end
