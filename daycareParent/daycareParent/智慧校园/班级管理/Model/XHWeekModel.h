//
//  XHWeekModel.h
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"


typedef NS_ENUM(NSInteger,XHWeekModelType)
{
    XHWeekTipType = 1, //!< 星期类型
    XHWeekSyllabusType = 2, //!< 课程内容
};


typedef NS_ENUM(NSInteger,XHWeekModelSlectType)
{
    XHWeekSelectType = 1, //!< 选中状态
    XHWeekNormalType = 2, //!< 未选中状态
};




@interface XHWeekModel : BaseModel

@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *describe; //!< 描述

@property (nonatomic,assign) XHWeekModelType type;  //!< 数据模型类型
@property (nonatomic,assign) XHWeekModelSlectType selectType; //!< 选中类型

@property (nonatomic,strong) NSMutableArray *syllabusArray; //!< 课程数组







@end
