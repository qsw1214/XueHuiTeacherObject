//
//  XHNoticeRecipientFrame.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientFrame.h"

@implementation XHNoticeRecipientFrame


-(void)setModel:(XHNoticeRecipientModel *)model
{
    _model = model;
    
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
    
    [self setCellHeight:self.itemFrame.size.height];
}

-(NSMutableArray<XHNoticeRecipientGroupFrame *> *)groupArray
{
    if (!_groupArray)
    {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

@end
