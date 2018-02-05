//
//  XHNoticeRecipientModel.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientModel.h"

@implementation XHNoticeRecipientModel

-(void)setTotal:(NSInteger)total
{
    _total = total;
    if (total)
    {
        [self setEnterType:XHNoticeRecipientCanEnteType];
    }
    else
    {
        [self setEnterType:XHNoticeRecipientNotccessibleType];
    }
}

@end
