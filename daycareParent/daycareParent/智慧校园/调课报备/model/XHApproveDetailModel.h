//
//  XHApproveDetailModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHApproveDetailModel : NSObject
@property(nonatomic,copy)NSString *appointedSubjectName;//!< 委任科目
@property(nonatomic,copy)NSString *appointedTeacherName;//!< 委任老师
@property(nonatomic,copy)NSString *auditor;//!< 审核人
@property(nonatomic,copy)NSString *auditorHeadPic;//!< 审核人头像
@property(nonatomic,copy)NSString *beginTime;//!< 上课时间
@property(nonatomic,copy)NSString *endTime;//!< 结束时间
@property(nonatomic,copy)NSString *bizType;//!< 业务类型(1:调课 2:代课)
@property(nonatomic,copy)NSString *clazzName;//!< 班级名字
@property(nonatomic,copy)NSString *createTime;//!< 创建时间
@property(nonatomic,copy)NSString *formerSubjectName;//!< 原任课程
@property(nonatomic,copy)NSString *formerTeacherName;//!< 原任老师
@property(nonatomic,copy)NSString *headPic;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *teacherName;
@property(nonatomic,copy)NSString *updateTime;
@property(nonatomic,copy)NSString *isAuditor;//!< 是否为审核人（0：否，1：是）
@property(nonatomic,copy)NSString *isStatus;//!< 状态(0:未审批 1:同意 2:拒绝)
@property(nonatomic,copy)NSString *isStudent;//!< 申请人是否为学生(0:否，1:是)
@property(nonatomic,copy)NSString *subjectNum;//!< 请假时长
@property(nonatomic,copy)NSString *bizDays;//!< 请假天数
@property(nonatomic,copy)NSString *content;//!< 请假内容
@property(nonatomic,copy)NSString *picUrl;//!< 请假图片
@property(nonatomic ,strong)NSMutableArray*picArry;//!<图片数组

-(id)initWithDic:(NSDictionary *)dic;
@end
