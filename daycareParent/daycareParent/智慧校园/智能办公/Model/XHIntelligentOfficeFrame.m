//
//  XHIntelligentOfficeFrame.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeFrame.h"

@implementation XHIntelligentOfficeFrame


-(void)setModel:(XHIntelligentOfficeModel *)model
{
    _model = model;
    
    switch (model.type)
    {
        case XHIntelligentOfficeHeaderType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.0)];
        }
            break;
        case XHIntelligentOfficeApprovalType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
        }
            break;
        case XHIntelligentOfficeContentType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
        }
            break;
    }
    
    [self setCellHeight:self.itemFrame.size.height];
}

@end
