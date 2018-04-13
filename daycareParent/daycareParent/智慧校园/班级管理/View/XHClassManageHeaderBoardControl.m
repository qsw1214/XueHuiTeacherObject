//
//  XHClassManageHeaderBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageHeaderBoardControl.h"
#import "XHAssignmentHomeWorkViewController.h" //家庭作业
#import "XHAddNoticeViewController.h"  //发布通知
#import "XHAchievementViewController.h" //成绩管理
#import "XHParentAddressBookViewController.h" //联系家长
#import "XHDayRollCallViewController.h"  //班级点名


@interface XHClassManageHeaderBoardControl ()



@property (nonatomic,copy) NSString *classid; //!< 班级id

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) BaseButtonControl *actualControl; //!< 实到人数
@property (nonatomic,strong) BaseButtonControl *leaveControl; //!< 请假人数
@property (nonatomic,strong) BaseButtonControl *lateControl; //!< 未到人数


@property (nonatomic,strong) BaseButtonControl *achievementControl; //!< 成绩管理
@property (nonatomic,strong) BaseButtonControl *homeWorkControl; //!< 布置作业
@property (nonatomic,strong) BaseButtonControl *noticeControl; //!< 发布通知
@property (nonatomic,strong) BaseButtonControl *contactParentsControl; //!< 联系家长
@property (nonatomic,strong) BaseButtonControl *parentMessageControl; //!< 家长留言

@end


@implementation XHClassManageHeaderBoardControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:RGB(250.0, 250.0, 250.0)];
        [self addSubview:self.imageView];
        [self addSubview:self.actualControl];
        [self addSubview:self.leaveControl];
        [self addSubview:self.lateControl];
        [self addSubview:self.achievementControl];
        [self addSubview:self.homeWorkControl];
        [self addSubview:self.noticeControl];
        [self addSubview:self.contactParentsControl];
        [self addSubview:self.parentMessageControl];
        
        [self setItemColor:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
   
  
    
    
    //!< 图片
    [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, 150.0)];
    [self.imageView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:5.0];
    
    //!< 实到人数Frame
    [self.actualControl resetFrame:CGRectMake(0, self.imageView.bottom, frame.size.width/3.0, 80.0)];
    [self.actualControl setTitleEdgeFrame:CGRectMake(0, 15, self.actualControl.width, (self.actualControl.height/2.0-15.0)) withNumberType:0 withAllType:NO];
    [self.actualControl setTitleEdgeFrame:CGRectMake(0, self.actualControl.height/2.0, self.actualControl.width, (self.actualControl.height/2.0-15.0)) withNumberType:1 withAllType:NO];
    [self.actualControl byRoundingCorners:UIRectCornerBottomLeft cornerRadii:5.0];
    
    //!< 请假人数Frame
    [self.leaveControl resetFrame:CGRectMake(self.actualControl.right, self.imageView.bottom, self.actualControl.width, self.actualControl.height)];
    [self.leaveControl setTitleEdgeFrame:CGRectMake(0, 15, self.leaveControl.width, (self.leaveControl.height/2.0-15.0)) withNumberType:0 withAllType:NO];
    [self.leaveControl setTitleEdgeFrame:CGRectMake(0, (self.leaveControl.height/2.0), self.leaveControl.width, self.leaveControl.height/2.0-15.0) withNumberType:1 withAllType:NO];
    [self.leaveControl resetLineViewFrame:CGRectMake(0.0, 20.0, 0.5, self.leaveControl.height-40.0) withNumberType:0 withAllType:NO];
    [self.leaveControl resetLineViewFrame:CGRectMake(self.leaveControl.width-0.5, 20.0, 0.5, self.leaveControl.height-40.0) withNumberType:1 withAllType:NO];
    
    //!< 未到人数Frame
    [self.lateControl resetFrame:CGRectMake(self.leaveControl.right, self.imageView.bottom, self.leaveControl.width, self.leaveControl.height)];
    [self.lateControl setTitleEdgeFrame:CGRectMake(0, 15.0, self.lateControl.width, (self.lateControl.height/2.0-15.0)) withNumberType:0 withAllType:NO];
    [self.lateControl setTitleEdgeFrame:CGRectMake(0, self.lateControl.height/2.0, self.lateControl.width, (self.lateControl.height/2.0-15.0)) withNumberType:1 withAllType:NO];
    [self.lateControl byRoundingCorners:UIRectCornerBottomRight cornerRadii:5.0];
    
    
    
    //!< 成绩管理Frame
    [self.achievementControl resetFrame:CGRectMake(0, self.leaveControl.bottom, frame.size.width/3.0, 110.0)];
    [self.achievementControl setTitleEdgeFrame:CGRectMake(0, 80.0, self.achievementControl.width, 30.0) withNumberType:0 withAllType:NO];
    [self.achievementControl setImageEdgeFrame:CGRectMake((self.achievementControl.width-60.0)/2.0, 10.0, 60.0, 60.0) withNumberType:0 withAllType:NO];
   
    //!< 家庭作业Frame
    [self.homeWorkControl resetFrame:CGRectMake(self.achievementControl.right, self.achievementControl.top, self.achievementControl.width, self.achievementControl.height)];
    [self.homeWorkControl setTitleEdgeFrame:CGRectMake(0, 80.0, self.homeWorkControl.width, 30.0) withNumberType:0 withAllType:NO];
    [self.homeWorkControl setImageEdgeFrame:CGRectMake((self.homeWorkControl.width-60.0)/2.0, 10.0, 60.0, 60.0) withNumberType:0 withAllType:NO];
    //!< 发布通知Frame
    [self.noticeControl resetFrame:CGRectMake(self.homeWorkControl.right, self.homeWorkControl.top, self.homeWorkControl.width, self.homeWorkControl.height)];
    [self.noticeControl setTitleEdgeFrame:CGRectMake(0, 80.0, self.noticeControl.width, 30.0) withNumberType:0 withAllType:NO];
    [self.noticeControl setImageEdgeFrame:CGRectMake((self.noticeControl.width-60.0)/2.0, 10.0, 60.0, 60.0) withNumberType:0 withAllType:NO];
    //!< 联系家长
    [self.contactParentsControl resetFrame:CGRectMake(20.0,(self.homeWorkControl.bottom+20.0), (frame.size.width-70.0)/2.0, 40.0)];
    [self.contactParentsControl setImageEdgeFrame:CGRectMake(20.0,(self.contactParentsControl.height-30.0)/2.0, 30.0, 30.0) withNumberType:0 withAllType:NO];
    [self.contactParentsControl setTitleEdgeFrame:CGRectMake(50.0, 0, (self.contactParentsControl.width-60.0), self.contactParentsControl.height) withNumberType:0 withAllType:NO];
    [self.contactParentsControl setLayerBorderWidth:1.0];
    [self.contactParentsControl setBorderColor:MainColor];
    [self.contactParentsControl setLayerCornerRadius:5.0];
    //!< 家长留言
    [self.parentMessageControl resetFrame:CGRectMake((self.contactParentsControl.right+30.0),self.contactParentsControl.top, self.contactParentsControl.width, self.contactParentsControl.height)];
    [self.parentMessageControl setImageEdgeFrame:CGRectMake(20.0,(self.parentMessageControl.height-30.0)/2.0, 30.0, 30.0) withNumberType:0 withAllType:NO];
    [self.parentMessageControl setTitleEdgeFrame:CGRectMake(50.0, 0, (self.parentMessageControl.width-60.0), self.parentMessageControl.height) withNumberType:0 withAllType:NO];
    [self.parentMessageControl setLayerBorderWidth:1.0];
    [self.parentMessageControl setBorderColor:MainColor];
    [self.parentMessageControl setLayerCornerRadius:5.0];
    
    
    
    [self setHeight:(self.parentMessageControl.bottom+10.0)];
    [self setLayerCornerRadius:5.0 withMasksToBounds:YES];
    
}




#pragma mark - 设置班级id用于获取当前班级考勤情况
-(void)setItemObject:(id)object withBlock:(XHClassManageHeaderBoardBackBlock)block
{
    [self setClassid:object];
    [self queryAttendanceCountWithClazzid:object withBlock:block];
}



#pragma mark  获取考勤情况
-(void)queryAttendanceCountWithClazzid:(NSString*)clazzid withBlock:(XHClassManageHeaderBoardBackBlock)block
{
    XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
    [netWorkConfig setObject:clazzid forKey:@"clazzId"];
    [netWorkConfig postWithUrl:@"zzjt-app-api_attendanceSheet003" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             NSDictionary *objectDictionary = [object objectItemKey:@"object"] ;
             NSDictionary *propValue = [objectDictionary objectItemKey:@"propValue"];
             NSString *attendanceCount = [propValue objectItemKey:@"attendanceCount"];  //!< 实到人数
             NSString *noAttendanceCount = [propValue objectItemKey:@"noAttendanceCount"]; //!< 未到人数
             NSString *bizCount = [propValue objectItemKey:@"bizCount"]; //!< 请假人数
             
             [self setActual:attendanceCount withLeave:bizCount withLate:noAttendanceCount];
             block(YES);
         }
         
     } error:^(NSError *error)
    {
        block(YES);
    }];
}



#pragma mark 填充考勤情况
-(void)setActual:(NSString*)actual withLeave:(NSString*)levae withLate:(NSString*)late
{
    [self.actualControl setText:actual withNumberType:0 withAllType:NO];
    [self.leaveControl setText:levae withNumberType:0 withAllType:NO];
    [self.lateControl setText:late withNumberType:0 withAllType:NO];
}


#pragma mark 按钮相应方法
-(void)manageControlAction:(BaseButtonControl*)sender
{
    switch (sender.tag)
    {
#pragma mark - case 123 考勤
        case 1:
        case 2:
        case 3:
        {
            XHDayRollCallViewController *dayroll = [[XHDayRollCallViewController alloc]initHiddenWhenPushHidden];
            [dayroll setIsRefresh:^(BOOL refresh)
             {
                 if (refresh)
                 {
                     
                 }
                 
             }];
            [dayroll setClassListModel:self.classModel];
            [DCURLRouter pushViewController:dayroll animated:YES];
        }
            break;
#pragma mark case 4 成绩管理
        case 4:
        {
            XHAchievementViewController *achievement = [[XHAchievementViewController alloc]initHiddenWhenPushHidden];
            [DCURLRouter pushViewController:achievement animated:YES];
        }
            break;
#pragma mark case 5 家庭作业
        case 5:
        {
            XHAssignmentHomeWorkViewController *homeWork = [[XHAssignmentHomeWorkViewController alloc]initHiddenWhenPushHidden];
            
            [DCURLRouter pushViewController:homeWork animated:YES];
        }
            break;
#pragma mark case 6 发布通知
        case 6:
        {
            XHAddNoticeViewController *notice = [[XHAddNoticeViewController alloc]initHiddenWhenPushHidden];
            [DCURLRouter pushViewController:notice animated:YES];
        }
            break;
#pragma mark case 7 联系家长
        case 7:
        {
            XHParentAddressBookViewController *parentAddressBook = [[XHParentAddressBookViewController alloc]initHiddenWhenPushHidden];
            [DCURLRouter pushViewController:parentAddressBook animated:YES];
        }
            break;
#pragma mark case 8 留言消息
        case 8:
        {
            
        }
            break;
    }
}

#pragma mark - Getter /  Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setImage:[UIImage imageNamed:@"pic_banji"]];
    }
    return _imageView;
}

#pragma mark 实到人数
-(BaseButtonControl *)actualControl
{
    if (!_actualControl)
    {
        _actualControl = [[BaseButtonControl alloc]init];
        [_actualControl setBackgroundColor:RGB(81,200,162)];
        [_actualControl setNumberLabel:2];
        [_actualControl setFont:[UIFont boldSystemFontOfSize:22.0] withNumberType:0 withAllType:NO];
        [_actualControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_actualControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_actualControl setTextColor:[UIColor whiteColor] withTpe:1 withAllType:NO];
        [_actualControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_actualControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_actualControl setTextAlignment:NSTextAlignmentCenter withNumberType:1 withAllType:NO];
        [_actualControl setText:@"0" withNumberType:0 withAllType:NO];
        [_actualControl setText:@"实到人数" withNumberType:1 withAllType:NO];
        [_actualControl setTag:1];
        [_actualControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actualControl;
}

#pragma mark 请假人数
-(BaseButtonControl *)leaveControl
{
    if (!_leaveControl)
    {
        _leaveControl = [[BaseButtonControl alloc]init];
        [_leaveControl setBackgroundColor:RGB(81,200,162)];
        [_leaveControl setNumberLabel:2];
        [_leaveControl setNumberLineView:2];
        [_leaveControl setFont:[UIFont boldSystemFontOfSize:22.0] withNumberType:0 withAllType:NO];
        [_leaveControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_leaveControl setTextColor:RGB(255,236,112) withTpe:0 withAllType:NO];
        [_leaveControl setTextColor:[UIColor whiteColor] withTpe:1 withAllType:NO];
        [_leaveControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_leaveControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_leaveControl setTextAlignment:NSTextAlignmentCenter withNumberType:1 withAllType:NO];
        [_leaveControl setText:@"0" withNumberType:0 withAllType:NO];
        [_leaveControl setText:@"请假人数" withNumberType:1 withAllType:NO];
        [_leaveControl setTag:2];
        [_leaveControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leaveControl;
}

#pragma mark 未到人数
-(BaseButtonControl *)lateControl
{
    if (!_lateControl)
    {
        _lateControl = [[BaseButtonControl alloc]init];
        [_lateControl setBackgroundColor:RGB(81,200,162)];
        [_lateControl setNumberLabel:2];
        [_lateControl setFont:[UIFont boldSystemFontOfSize:22.0] withNumberType:0 withAllType:NO];
        [_lateControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_lateControl setTextColor:RGB(255,104,105) withTpe:0 withAllType:NO];
        [_lateControl setTextColor:[UIColor whiteColor] withTpe:1 withAllType:NO];
        [_lateControl setFont:FontLevel3 withNumberType:1 withAllType:NO];
        [_lateControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_lateControl setTextAlignment:NSTextAlignmentCenter withNumberType:1 withAllType:NO];
        [_lateControl setText:@"0" withNumberType:0 withAllType:NO];
        [_lateControl setText:@"未到人数" withNumberType:1 withAllType:NO];
        [_lateControl setTag:3];
        [_lateControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _lateControl;
}


#pragma mark 成绩管理
-(BaseButtonControl *)achievementControl
{
    if (!_achievementControl)
    {
        _achievementControl = [[BaseButtonControl alloc]init];
        [_achievementControl setNumberLabel:1];
        [_achievementControl setNumberImageView:1];
        [_achievementControl setImage:@"ico_chengji" withNumberType:0 withAllType:NO];
        [_achievementControl setImageContentMode:UIViewContentModeScaleAspectFit withNumberType:0 withAllType:NO];
        [_achievementControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_achievementControl setText:@"成绩管理" withNumberType:0 withAllType:NO];
        [_achievementControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_achievementControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_achievementControl setTag:4];
        [_achievementControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _achievementControl;
}

#pragma mark 家庭作业
-(BaseButtonControl *)homeWorkControl
{
    if (!_homeWorkControl)
    {
        _homeWorkControl = [[BaseButtonControl alloc]init];
        [_homeWorkControl setNumberLabel:1];
        [_homeWorkControl setNumberImageView:1];
        [_homeWorkControl setImage:@"ico_zuoye" withNumberType:0 withAllType:NO];
        [_homeWorkControl setImageContentMode:UIViewContentModeScaleAspectFit withNumberType:0 withAllType:NO];
        [_homeWorkControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_homeWorkControl setText:@"家庭作业" withNumberType:0 withAllType:NO];
        [_homeWorkControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_homeWorkControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_homeWorkControl setTag:5];
        [_homeWorkControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeWorkControl;
}

#pragma mark 发布通知
-(BaseButtonControl *)noticeControl
{
    if (!_noticeControl)
    {
        _noticeControl = [[BaseButtonControl alloc]init];
        [_noticeControl setNumberLabel:1];
        [_noticeControl setNumberImageView:1];
        [_noticeControl setImage:@"ico_tongzhi" withNumberType:0 withAllType:NO];
        [_noticeControl setImageContentMode:UIViewContentModeScaleAspectFit withNumberType:0 withAllType:NO];
        [_noticeControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_noticeControl setText:@"发布通知" withNumberType:0 withAllType:NO];
        [_noticeControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_noticeControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_noticeControl setTag:6];
        [_noticeControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noticeControl;
}

#pragma mark 联系家长
-(BaseButtonControl *)contactParentsControl
{
    if (!_contactParentsControl)
    {
        _contactParentsControl = [[BaseButtonControl alloc]init];
        [_contactParentsControl setNumberLabel:1];
        [_contactParentsControl setNumberImageView:1];
        [_contactParentsControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_contactParentsControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_contactParentsControl setText:@"联系家长" withNumberType:0 withAllType:NO];
        [_contactParentsControl setImage:@"ico_calljia" withNumberType:0 withAllType:NO];
        [_contactParentsControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_contactParentsControl setItemColor:NO];
        [_contactParentsControl setTag:7];
        [_contactParentsControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactParentsControl;
}


#pragma mark 留言消息
- (BaseButtonControl *)parentMessageControl
{
    if (!_parentMessageControl)
    {
        _parentMessageControl = [[BaseButtonControl alloc]init];
        [_parentMessageControl setNumberLabel:1];
        [_parentMessageControl setNumberImageView:1];
        [_parentMessageControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_parentMessageControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_parentMessageControl setText:@"留言消息" withNumberType:0 withAllType:NO];
        [_parentMessageControl setImage:@"ico_liuyan" withNumberType:0 withAllType:NO];
        [_parentMessageControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_parentMessageControl setItemColor:NO];
        [_parentMessageControl setTag:8];
        [_parentMessageControl addTarget:self action:@selector(manageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _parentMessageControl;
}


#pragma mark - setItemColor:(BOOL)color
-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.achievementControl setBackgroundColor:[UIColor orangeColor]];
        [self.homeWorkControl setBackgroundColor:[UIColor yellowColor]];
        [self.noticeControl setBackgroundColor:[UIColor purpleColor]];
        [self.contactParentsControl setBackgroundColor:[UIColor darkGrayColor]];
        [self.parentMessageControl setBackgroundColor:[UIColor orangeColor]];
        [self.leaveControl setItemColor:color];
        [self.lateControl setItemColor:color];
        [self.actualControl setItemColor:color];
    }
}


@end
