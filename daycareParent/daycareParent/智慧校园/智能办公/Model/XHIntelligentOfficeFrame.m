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
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0)];
    [self setCellHeight:self.itemFrame.size.height];
}

@end
