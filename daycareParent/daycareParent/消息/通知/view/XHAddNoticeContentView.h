//
//  XHAddNoticeContentView.h
//  daycareParent
//
//  Created by Git on 2018/1/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->通知公告->发布公告->内容视图



@protocol XHAddNoticeContentViewDeletage <NSObject>

-(void)addNoticeContentAction:(BaseButtonControl*)sender;


@end

#import "BaseScrollView.h"

@interface XHAddNoticeContentView : BaseScrollView


@property (nonatomic,weak) id <XHAddNoticeContentViewDeletage> addDeletage;


@end
