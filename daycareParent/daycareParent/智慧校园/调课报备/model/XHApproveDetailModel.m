//
//  XHApproveDetailModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHApproveDetailModel.h"
#import "XHPreviewModel.h"
@implementation XHApproveDetailModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _appointedSubjectName=[dic objectItemKey:@"appointedSubjectName"];
        _appointedTeacherName=[dic objectItemKey:@"appointedTeacherName"];
        _auditor=[dic objectItemKey:@"auditor"];
        _auditorHeadPic=[dic objectItemKey:@"auditorHeadPic"];
        _beginTime=[dic objectItemKey:@"beginTime"];
        _bizType=[dic objectItemKey:@"bizType"];
        _clazzName=[dic objectItemKey:@"clazzName"];
        _createTime=[dic objectItemKey:@"createTime"];
        _formerSubjectName=[dic objectItemKey:@"formerSubjectName"];
        _formerTeacherName=[dic objectItemKey:@"formerTeacherName"];
        _headPic=[dic objectItemKey:@"headPic"];
        _ID=[dic objectItemKey:@"id"];
        _teacherName=[dic objectItemKey:@"teacherName"];
        _updateTime=[dic objectItemKey:@"updateTime"];
        _endTime=[dic objectItemKey:@"endTime"];
        _isAuditor=[dic objectItemKey:@"isAuditor"];
        _isStatus=[dic objectItemKey:@"isStatus"];
        _isStudent=[dic objectItemKey:@"isStudent"];
        _subjectNum=[dic objectItemKey:@"subjectNum"];
        _bizDays=[dic objectItemKey:@"bizDays"];
        _content=[dic objectItemKey:@"content"];
        _picUrl=[dic objectItemKey:@"picUrl"];
        if (![_picUrl isEqualToString:@""])
        {
            XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
            [imageModel setPreviewUrl:ALGetFileImageThumbnail([dic objectItemKey:@"picUrl"])];
            [imageModel setPreviewPic:[dic objectItemKey:@"picUrl"]];
            [self.picArry addObject:imageModel];
        }
    }
    return self;
}
-(NSMutableArray *)picArry
{
    if (_picArry==nil) {
        _picArry=[NSMutableArray array];
    }
    return _picArry;
}
@end
