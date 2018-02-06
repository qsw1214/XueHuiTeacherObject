//
//  XHAchievementModel.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger , XHAchievementModelContentType)
{
    XHAchievementTitleType = 0,
    XHAchievementContentType = 1,
};




@interface XHAchievementModel : BaseModel

@property (nonatomic,strong) NSString *subject; //!< 科目
@property (nonatomic,strong) NSString *batch; //!< 开学成绩
@property (nonatomic,strong) NSString *score; //!< 其中成绩
@property (nonatomic,strong) NSString *end; //!< 期末成绩
@property (nonatomic,assign) XHAchievementModelContentType contentType;







@end
