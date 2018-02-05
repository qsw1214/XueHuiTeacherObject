//
//  XHAskforLeaveDetailViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
#pragma mark  请假记录详情

@class XHApproveModel;

@interface XHAskforLeaveDetailViewController : BaseViewController
@property(nonatomic,assign)BOOL isSelf;
@property(nonatomic,assign)NSInteger Tag;
@property(nonatomic,strong)XHApproveModel *model;
@end
