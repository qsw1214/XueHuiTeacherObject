//
//  XHClassListModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHClassListModel : NSObject

@property(nonatomic,copy)NSString *clazz;//!< 班级名字

@property(nonatomic,copy)NSString *clazzId;//!< 班级id

@property(nonatomic,copy)NSString *grade;//!< 年纪名字

@property(nonatomic,copy)NSString *gradeId;//!< 年纪id

@property(nonatomic,copy)NSString *gradeAndClassName;//!< 年纪和班级名字

-(id)initWithDic:(NSDictionary *)dic;
@end
