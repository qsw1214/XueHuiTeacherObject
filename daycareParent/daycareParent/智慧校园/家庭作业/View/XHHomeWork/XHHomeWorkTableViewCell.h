//
//  XHHomeWorkTableViewCell.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "XHHomeWorkFrame.h"

#pragma mark 智慧校园->家庭作业记录->内容承载视图->内容呈现的单元格


@interface XHHomeWorkTableViewCell : BaseTableViewCell

@property (nonatomic,strong) XHHomeWorkFrame *itemFrame;


@end
