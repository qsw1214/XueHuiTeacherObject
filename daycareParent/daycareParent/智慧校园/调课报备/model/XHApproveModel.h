//
//  XHApproveModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/1.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XHPreviewModel.h"

typedef NS_ENUM(NSInteger,XHHistoryModelType)
{
    XHCourseReportType=1,//!<课程报备记录
    
    XHAskforLeaveType=2,//!< 请假记录
    
};

typedef NS_ENUM(NSInteger,XHUnReadModelType)
{
    XHUnReadType=1,//!<未读
    
    XHReadType=2,//!< 已读
    
};
typedef NS_ENUM(NSInteger,XHIsMEModelType)
{
    XHNoMeType=1,//!<我的审核
    
    XHIsMEType=2,//!< 我的申请
    
};
typedef NS_ENUM(NSInteger,XHIsStatusModelType)
{
    XHStatusType=1,//!<未审批
    
    XHIsStatusType=2,//!< 同意
    
    XHNoStatusType=3,//!< 拒绝
    
};
typedef NS_ENUM(NSInteger,XHBizModelType)
{
    XHBizType=1,//!<调课
    
    XHNoBizType=2,//!< 代课
    
};
typedef NS_ENUM(NSInteger,XHApproveModelType)
{
    XHNoApproveType=1,//!<待审核
    
    XHApproveType=2,//!< 已审核
    
};
@interface XHApproveModel : NSObject
@property(nonatomic,copy)NSString *isMe;//!< 类型(0:我的审核 1:我的申请)
@property(nonatomic,assign)XHIsMEModelType isMeModelType;//!< 审核类型 (0:我的审核 1:我的申请)
@property(nonatomic,copy)NSString *bizType;//!< 业务类型(1:调课 2:代课)
@property(nonatomic,assign)XHBizModelType bizModelType;//!< 业务类型(1:调课 2:代课)

@property(nonatomic,copy)NSString *teacherName;//!< 老师名字
@property(nonatomic,copy)NSString *isStatus;//!< 状态(0:未审批 1:同意 2:拒绝)
@property(nonatomic,assign)XHIsStatusModelType  isStatusType;//!< 状态(0:未审批 1:同意 2:拒绝)
@property(nonatomic,copy)NSString *auditor;//!< 审核人姓名
@property(nonatomic,copy)NSString *headPic;//!< 头像
@property(nonatomic,copy)NSString *isRead;//!< 已读 1、未读 0
@property(nonatomic,assign)XHUnReadModelType  readType;//!< 已读、未读

@property(nonatomic,assign)XHApproveModelType modelType;//!< 选择审核类型

@property(nonatomic,assign)XHHistoryModelType historyModelType;//!< 课程报备记录或者请假列表记录

@property (nonatomic,strong) NSMutableArray <XHPreviewModel*> *imageUrlArray; //!< 图片数组

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *beginTime;
-(id)initWithDic:(NSDictionary *)dic;
@end
