//
//  XHNoticeRecipientFrame.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseFrame.h"
#import "XHNoticeRecipientModel.h"
#import "XHNoticeRecipientGroupFrame.h"

@interface XHNoticeRecipientFrame : BaseFrame

@property (nonatomic,strong) XHNoticeRecipientModel *model; //!< 数据模型
@property (nonatomic,strong) NSMutableArray <XHNoticeRecipientGroupFrame*> *groupArray;




@end
