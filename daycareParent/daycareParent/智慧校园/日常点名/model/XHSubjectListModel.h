//
//  XHSubjectListModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHSubjectListModel : NSObject
@property(nonatomic,copy)NSString *subjectName;//!< 学科名字
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *schoolId;
-(id)initWithDic:(NSDictionary *)dic;
@end
