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


@property (nonatomic,assign) XHIntelligentOfficeModelType type;

@property (nonatomic,assign) XHIntelligentOfficeApproveModelType approveType;
@end
