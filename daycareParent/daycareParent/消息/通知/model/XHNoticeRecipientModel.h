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
};

typedef NS_ENUM(NSInteger,XHNoticeRecipientSelectType)
{
    XHNoticeRecipientNormalityType = 1, //!< 普通类型
    XHNoticeRecipientSelectedType = 2, //!< 选中类型
};


typedef NS_ENUM(NSInteger,XHNoticeRecipientEnterType)
{
    XHNoticeRecipientCanEnteType = 1, //!< 可以进入
    XHNoticeRecipientNotccessibleType = 2, //!< 不可进入
};


typedef NS_ENUM(NSInteger,XHNoticeRecipientAllSelectType)
{
    XHNoticeRecipientUserAllSelectedType = 1, //!< 是否是用户主动选择全选
    XHNoticeRecipientOptionAllSelectedType = 2, //!< 程序选择了全选
};


#import "BaseModel.h"

@interface XHNoticeRecipientModel : BaseModel

@property (nonatomic,copy)   NSString *title; //!< 标题
@property (nonatomic,copy)   NSString *describe;
@property (nonatomic,assign) NSInteger total; //!< 总共
@property (nonatomic,assign) NSInteger select; //!< 选择




@property (nonatomic,assign) XHNoticeRecipientModelType modelType; //!< 数据内容类型
@property (nonatomic,assign) XHNoticeRecipientSelectType selectType; //!< 选择类型
@property (nonatomic,assign) XHNoticeRecipientEnterType enterType;  //!< 是否能正常进入，如果为的情况下，不允许点击
@property (nonatomic,assign) XHNoticeRecipientAllSelectType allSelectType; //!< 是否是用户选择全部选择










@end
