//
//  XHNoticeUniteItemContentView.h
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHNoticeRecipientGroupTableViewCell.h"


@protocol XHNoticeUniteItemDeletage <NSObject>

-(void)didSelectRowAtIndexObject:(id)object;


@end

@interface XHNoticeUniteItemContentView : BaseControl


@property (nonatomic,weak) id <XHNoticeUniteItemDeletage> deletage;


@end
