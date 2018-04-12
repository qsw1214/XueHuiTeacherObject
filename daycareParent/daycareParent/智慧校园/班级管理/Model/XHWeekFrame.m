//
//  XHWeekFrame.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHWeekFrame.h"

@implementation XHWeekFrame

-(void)setModel:(XHWeekModel *)model
{
    _model = model;
    switch (model.type)
    {
        case XHWeekTipType:
        {
            [self setItemSize:CGSizeMake((SCREEN_WIDTH-90.0)/5.0, 30.0)];
        }
            break;
        case XHWeekSyllabusType:
        {
            [self setItemSize:CGSizeMake((SCREEN_WIDTH-50.0), 50.0)];
        }
            break;
    }
}

@end
