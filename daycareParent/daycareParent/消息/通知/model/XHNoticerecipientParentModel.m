//
//  XHNoticerecipientParentModel.m
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticerecipientParentModel.h"

@implementation XHNoticerecipientParentModel


-(void)setItemObject:(NSDictionary *)object
{
    [self setParentID:[object objectItemKey:@"id"]];
    [self setTelphoneNumber:[object objectItemKey:@"telphoneNumber"]];
}

@end
