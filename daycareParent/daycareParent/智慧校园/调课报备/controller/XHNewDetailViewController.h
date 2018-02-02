//
//  XHNewDetailViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/17.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
#pragma mark-------------审批详情--------------
@class XHApproveModel;
@interface XHNewDetailViewController : BaseViewController
@property(nonatomic,assign)BOOL isSelf;
@property(nonatomic,assign)NSInteger Tag;
@property(nonatomic,strong)XHApproveModel *model;
@end
