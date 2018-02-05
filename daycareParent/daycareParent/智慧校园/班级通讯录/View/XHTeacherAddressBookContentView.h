//
//  XHTeacherAddressBookContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHTeacherAddressBookKey.h"
#import "XHTeacherAddressBookCell.h"


/**
 在请假中使用
 因为请假、调课和通讯录中用到老师通讯录，界面和操作逻辑不一致，所以教师通讯录开发两种视图
 */



@protocol XHTeacherAddressBookContentViewDeletage <NSObject>

-(void)didSelectRowAtIndexItemObject:(XHTeacherAddressBookFrame*)object;
-(void)dissmissPopWithItemObjec:(XHTeacherAddressBookFrame*)object;

@end



@interface XHTeacherAddressBookContentView : BaseControl


@property (nonatomic,weak) id <XHTeacherAddressBookContentViewDeletage> deletage;



@end
