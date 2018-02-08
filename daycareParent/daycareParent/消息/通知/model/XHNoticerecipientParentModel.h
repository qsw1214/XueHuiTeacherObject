//
//  XHNoticerecipientParentModel.h
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//



#pragma mark 监护人数据模型


#import "BaseModel.h"

@interface XHNoticerecipientParentModel : BaseModel





/**
 监护人的id
 */
@property (nonatomic,copy) NSString *parentID;

/**
 监护人手机号
 */
@property (nonatomic,copy) NSString *telphoneNumber;


@end
