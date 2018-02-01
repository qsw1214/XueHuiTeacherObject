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
    }
    return self;
}
@end
