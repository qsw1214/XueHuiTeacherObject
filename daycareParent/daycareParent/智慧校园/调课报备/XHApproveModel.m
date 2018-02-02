//
//  XHApproveModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/1.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHApproveModel.h"

@implementation XHApproveModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
       _isMe=[dic objectItemKey:@"isMe"];
        _bizType=[dic objectItemKey:@"bizType"];
        _teacherName=[dic objectItemKey:@"teacherName"];
        _isStatus=[dic objectItemKey:@"isStatus"];
        _auditor=[dic objectItemKey:@"auditor"];
        _headPic=[dic objectItemKey:@"headPic"];
        _isRead=[dic objectItemKey:@"isRead"];
        _ID=[dic objectItemKey:@"id"];
        _beginTime=[dic objectItemKey:@"beginTime"];
        [self getModelType];
    }
    return self;
}
-(void)getModelType
{
    switch ([_isMe integerValue]) {
        case 0:
        {
            _isMeModelType=XHNoMeType;
        }
            break;
            
        case 1:
        {
            _isMeModelType=XHIsMEType;
        }
            break;
    }
    switch ([_isStatus integerValue]) {
        case 0:
            {
                _isStatusType=XHStatusType;
            }
            break;
        case 1:
        {
            _isStatusType=XHIsStatusType;
        }
            break;
        case 2:
        {
            _isStatusType=XHNoStatusType;
        }
            break;
    }
    switch ([_isRead integerValue]) {
        case 0:
        {
            _readType=XHUnReadType;
        }
            break;
            
        case 1:
        {
            _readType=XHReadType;
        }
            break;
    }
    switch ([_bizType integerValue]) {
        case 1:
        {
            _bizModelType=XHBizType;
        }
            break;
            
        default:
        {
            _bizModelType=XHNoBizType;
        }
            break;
    }
}
@end
