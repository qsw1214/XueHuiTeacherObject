//
//  XHPunchSignRecordFrame.m
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignRecordFrame.h"

@implementation XHPunchSignRecordFrame

-(void)setModel:(XHPunchSignRecordModel *)model
{
    _model = model;
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75.0)];
    [self setCellHeight:self.itemFrame.size.height];
}

@end
