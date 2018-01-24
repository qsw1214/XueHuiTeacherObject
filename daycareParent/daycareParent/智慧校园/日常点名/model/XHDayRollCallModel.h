//
//  XHDayRollCallModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,XHDayRollCallModelType)
{
    DayRollCallNOSignType = 0,//!< 未签到
    DayRollCallSignType = 2,//!< 签到
    DayRollCallOtherType = 3,//!< 请假
};

@interface XHDayRollCallModel : NSObject
@property(nonatomic,copy)NSString *imagPic;
@property(nonatomic,copy)NSString *reasonStr;
@property(nonatomic,assign)BOOL IfSelect;
@property(nonatomic,assign)XHDayRollCallModelType modelType;
@end
