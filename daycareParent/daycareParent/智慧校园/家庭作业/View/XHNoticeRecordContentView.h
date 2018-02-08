//
//  XHNoticeRecordContentView.h
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHHomeWorkTableViewCell.h"


@protocol XHNoticeRecordContentViewDeletage <NSObject>


@optional
-(void)didSelectAtIndex:(XHHomeWorkFrame*)frame;

@end


@interface XHNoticeRecordContentView : BaseControl


-(instancetype)initWithDeletage:(id)deletage;

@end
