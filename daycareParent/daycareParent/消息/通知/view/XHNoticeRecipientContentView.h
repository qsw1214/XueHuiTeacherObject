//
//  XHNoticeRecipientContentView.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHNoticeRecipientTableViewCell.h"


@protocol XHNoticeRecipientDeletage <NSObject>

-(void)didSelectRowAtIndexObject:(id)object;


@end

@interface XHNoticeRecipientContentView : BaseControl <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHNoticeRecipientDeletage> deletage;


@end
