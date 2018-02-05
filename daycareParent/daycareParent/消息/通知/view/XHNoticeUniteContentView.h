//
//  XHNoticeUniteContentView.h
//  daycareParent
//
//  Created by Git on 2018/2/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHNoticeRecipientTableViewCell.h"


@protocol XHNoticeUniteDeletage <NSObject>

-(void)didSelectRowAtIndexObject:(id)object;


@end

@interface XHNoticeUniteContentView : BaseControl


@property (nonatomic,weak) id <XHNoticeUniteDeletage> deletage;


@end
