//
//  XHHomeWorkFrame.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkFrame.h"

@implementation XHHomeWorkFrame


-(void)setModel:(XHHomeWorkModel *)model
{
    
    _model = model;
    
    CGSize subjectSize = [NSObject contentSizeWithTitle:model.subject withFontOfSize:FontLevel3 withWidth:100.0];
    [self setSubjectSize:CGSizeMake(subjectSize.width+10.0, subjectSize.height)];
    switch (model.homeWorkType)
    {
        case HomeWorkType:
        {
            [self setItemFrame:CGRectMake(10, 10, SCREEN_WIDTH-20.0, 100.0)];
            [self setCellHeight:(self.itemFrame.size.height+10.0)];
        }
            break;
        case HomeWorkNoticeType:
        {
            [self setItemFrame:CGRectMake(10, 10, SCREEN_WIDTH-20.0, 100.0)];
            [self setCellHeight:(self.itemFrame.size.height+10.0)];
        }
            break;
    }
}








@end
