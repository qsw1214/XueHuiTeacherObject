//
//  XHIntelligentOfficeSignModel.h
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,XHIntelligentOfficeSignModelType)
{
    XHIntelligentOfficeSignEmptyType = 1,
    XHIntelligentOfficeSignTimeType = 2,
    XHIntelligentOfficeSigWeekAndDateType = 3,
    
};

@interface XHIntelligentOfficeSignModel : BaseModel

@property (nonatomic,assign) XHIntelligentOfficeSignModelType modelType;
@property (nonatomic,copy) NSString *date;

@end
