//
//  XHIntelligentOfficeModel.h
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,XHIntelligentOfficeModelType)
{
    XHIntelligentOfficeHeaderType = 1,    //!< 头部类型
    XHIntelligentOfficeApprovalType = 2, //!< 提醒类型
    XHIntelligentOfficeContentType = 3, //!< 内容类型
};





@interface XHIntelligentOfficeModel : BaseModel


@property (nonatomic,assign) XHIntelligentOfficeModelType type;

@end
