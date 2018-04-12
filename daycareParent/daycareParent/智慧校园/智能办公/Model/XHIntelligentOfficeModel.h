//
//  XHIntelligentOfficeModel.h
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,XHIntelligentOfficeModelType)
{
    XHIntelligentOfficeAskforleaveType = 1,    //!< 请假类型
    XHIntelligentOfficeClassSwitchingType = 2, //!< 调课类型
    XHIntelligentOfficeTakeOverClassType = 3, //!<  代课类型
};


typedef NS_ENUM(NSInteger,XHIntelligentOfficeApproveModelType)
{
    XHIntelligentOfficeUnknownApproveType = 1,    //!< 未审批类型
    XHIntelligentOfficeApproveType = 2, //!< 审批通过类型
    XHIntelligentOfficeNOApproveType = 3, //!<  审批拒绝类型
};



@interface XHIntelligentOfficeModel : BaseModel

@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *teacher; //!< 当前老师
@property (nonatomic,copy) NSString *targetTeacher; //!< 对方老师
@property (nonatomic,copy) NSString *approveMark; //!< 审批状态



@property (nonatomic,assign) XHIntelligentOfficeModelType modelType; //!< 数据模型
@property (nonatomic,assign) XHIntelligentOfficeApproveModelType approveType; //!< 审批类型


@end
