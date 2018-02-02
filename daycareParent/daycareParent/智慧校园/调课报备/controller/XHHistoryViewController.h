//
//  XHHistoryViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
#pragma mark-------------课程报备---》记录--------------

typedef NS_ENUM(NSInteger,XHHistoryViewModelType)
{
    XHHistoryCourseReportType=1,//!<课程报备记录

    XHHistoryAskforLeaveType=2,//!< 请假记录

};

@interface XHHistoryViewController : BaseViewController

@property(nonatomic,assign)XHHistoryViewModelType modelType;

@end
