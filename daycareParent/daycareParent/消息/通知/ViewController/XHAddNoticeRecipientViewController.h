//
//  XHAddNoticeRecipientViewController.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//


#pragma mark 智慧校园->通知公告->通知联系人


#import "BaseViewController.h"
#import "XHNoticeMarkModel.h"



typedef void (^MarkSuccessBlock) (BOOL sucess,XHNoticeMarkModel *model);

@interface XHAddNoticeRecipientViewController : BaseViewController


@property (nonatomic,copy) MarkSuccessBlock markSuccessBlock;


@end
