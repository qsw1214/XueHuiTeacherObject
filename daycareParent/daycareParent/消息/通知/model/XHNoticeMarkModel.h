//
//  XHNoticeMarkModel.h
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHNoticeMarkModel : NSObject


@property (nonatomic,strong) NSMutableArray *teacherArray;
@property (nonatomic,strong) NSMutableArray *teacherPhoneArray;
@property (nonatomic,strong) NSMutableArray *guardianIDArray;
@property (nonatomic,strong) NSMutableArray *guardianNumberArray;

@property (nonatomic,strong) NSString *teacherID;  //!< 老师ids
@property (nonatomic,strong) NSString *teacherPhone;  //!< 老师手机号
@property (nonatomic,strong) NSString *guardianID;  //!< 监护人
@property (nonatomic,strong) NSString *guardianNumber;  //!< 监护人
@property (nonatomic,assign) NSInteger count;  //!< 总共选择了多少人






@end
