//
//  XHNoticeRecipientTableViewCell.h
//  daycareParent
//
//  Created by Git on 2018/1/31.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "XHNoticeRecipientFrame.h"


@protocol XHNoticeRecipientTableViewCellDeletage <NSObject>

-(void)markControlAction:(id)object;

@end



@interface XHNoticeRecipientTableViewCell : BaseTableViewCell


@property (nonatomic,assign) NSInteger indexRow;

-(instancetype)initWithDeletage:(id<XHNoticeRecipientTableViewCellDeletage>)deletage;






@end
