//
//  XHSubjectListModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSubjectListModel.h"

@implementation XHSubjectListModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _subjectName=[dic objectItemKey:@"subjectName"];
        _ID=[dic objectItemKey:@"id"];
        _schoolId=[dic objectItemKey:@"schoolId"];
    }
    return self;
}
@end
