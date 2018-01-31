//
//  XHClassViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger ,XHClassModelType)
{
    XHClassListType=1,//!< 班级列表
    
    XHClassSubjectType=2 //!< 学科列表
};

@interface XHClassViewController : BaseViewController

@property(nonatomic,assign)XHClassModelType classModelType;
@property(nonatomic,copy)void(^getClassBock)(NSInteger number);
@end
