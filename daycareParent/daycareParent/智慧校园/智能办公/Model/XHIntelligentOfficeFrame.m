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
    
    
    switch (model.modelType)
    {
        case XHIntelligentOfficeClassSwitchingType:
        {
            [self setItemFrame:CGRectMake(10.0, 10.0, (SCREEN_WIDTH-20.0), 160.0)];
        }
            break;
        case XHIntelligentOfficeAskforleaveType:
        {
            [self setItemFrame:CGRectMake(10.0, 10.0, (SCREEN_WIDTH-20.0), 115.0)];
        }
            break;
        case XHIntelligentOfficeTakeOverClassType:
        {
            [self setItemFrame:CGRectMake(10.0, 10.0, (SCREEN_WIDTH-20.0), 115.0)];
        }
            break;
    }
    
    [self setCellHeight:(self.itemFrame.size.height+10.0)];
}

@end
