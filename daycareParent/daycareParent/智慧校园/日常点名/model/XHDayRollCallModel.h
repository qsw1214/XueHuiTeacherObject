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
    DayRollCallSignType = 1,//!< 签到
    DayRollCallOtherType = 2,//!< 请假
};

@interface XHDayRollCallModel : NSObject
@property(nonatomic,copy)NSString *headPic;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *studentName;
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *beginTime;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,assign)BOOL IfSelect;
@property(nonatomic,assign)XHDayRollCallModelType modelType;
-(id)initWithDic:(NSDictionary *)dic;
@end
