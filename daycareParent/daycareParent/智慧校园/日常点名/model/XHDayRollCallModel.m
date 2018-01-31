//
//  XHDayRollCallModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallModel.h"

@implementation XHDayRollCallModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _headPic=[dic objectItemKey:@"headPic"];
        _ID=[dic objectItemKey:@"id"];
        _studentName=[dic objectItemKey:@"studentName"];
        _type=[dic objectItemKey:@"type"];
        _picUrl=[dic objectItemKey:@"picUrl"];
        _content=[dic objectItemKey:@"content"];
        _beginTime=[dic objectItemKey:@"beginTime"];
        _endTime=[dic objectItemKey:@"endTime"];
        switch ([_type integerValue]) {
            case 0:
            {
                _modelType=DayRollCallNOSignType;
            }
                break;
            case 1:
            {
                _modelType=DayRollCallSignType;
            }
                break;
            case 2:
            {
                _modelType=DayRollCallOtherType;
            }
                break;
           
        }
    }
    return self;
}
@end
