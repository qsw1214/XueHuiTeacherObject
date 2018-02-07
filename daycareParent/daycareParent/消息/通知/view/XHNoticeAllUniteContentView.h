//
//  XHNoticeAllUniteContentView.h
//  daycareParent
//
//  Created by Git on 2018/2/7.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"

#pragma mark 全选的视图


@interface XHNoticeAllUniteContentView : BaseControl


-(void)addAllSelectTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
