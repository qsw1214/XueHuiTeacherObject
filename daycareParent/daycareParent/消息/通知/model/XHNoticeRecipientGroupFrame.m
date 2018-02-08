//
//  XHNoticeRecipientFrame.m
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecipientGroupFrame.h"

@implementation XHNoticeRecipientGroupFrame


-(void)setModel:(XHNoticeRecipientGroupModel *)model
{
    _model = model;
    //!< 设置监护人个数
    [_model setGuardian:[model.parentArray count]];
    
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
    
    [self setCellHeight:self.itemFrame.size.height];
}

@end
