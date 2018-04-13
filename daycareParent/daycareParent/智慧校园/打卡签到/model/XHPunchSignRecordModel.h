//
//  XHPunchSignRecordModel.h
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"

@interface XHPunchSignRecordModel : BaseModel


/*因为每个学校的时间段不一致，就暂切定义为四个时间段
 *
 */
@property (nonatomic,copy) NSString *title; //!< 周几
@property (nonatomic,copy) NSString *date; //!< 日期
@property (nonatomic,copy) NSString *time; //!< 具体时间
@property (nonatomic,copy) NSString *markIcon; //!< 显示的图片



@end
