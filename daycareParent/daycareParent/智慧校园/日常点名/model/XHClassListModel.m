//
//  XHClassListModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassListModel.h"

@implementation XHClassListModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _clazz=[dic objectItemKey:@"clazz"];
        _clazzId=[dic objectItemKey:@"clazzId"];
        _grade=[dic objectItemKey:@"grade"];
        _gradeId=[dic objectItemKey:@"gradeId"];
        _gradeAndClassName=[NSString stringWithFormat:@"%@%@",_grade,_clazz];
    }
    return self;
}
@end
