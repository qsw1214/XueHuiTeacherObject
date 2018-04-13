//
//  XHNewBulidViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewBulidViewController.h"
#import "BaseTableView.h"
#import "XHNewTableViewCell.h"
#import "XHNewTextFieldTypeTableViewCell.h"
#import "XHNewHeardTableViewCell.h"
#import "XHNewChageTypeTableViewCell.h"
#import "XHClassListModel.h"
#import "XHSubjectListModel.h"
#import "XHDatePickerControl.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHHistoryViewController.h"
#import "XHCoursePeportModel.h"
#import "XHCalendarView.h"
typedef NS_ENUM(NSInteger,XHNewBulidModelType)
{
    XHNewBulidMelodyType=1,//!<调课类型
    XHNewBulidTipsayType=2,//!< 代课类型
    //    XHCoursePeportRemarkType=3,//!< 备注类型
    //    XHCoursePeportApproveType=4,//!< 审批类型
    //    XHCoursePeportCopyToType=5,//!< 抄送类型
};
#define TITLE  @[@"原任课教师",@"课程名称",@"上课班级",@"调整类型",@"委任教师",@"委任课程",@"上课时间",@"请假时长",@"审批人"]
//!<调课类型
#define kMelodyTitleArry @[@"调课日期",@"调课班级",@"调课节次",@"调课科目",@"对方教师",@"对方日期",@"对方节次",@"对方班级"]
#define kMelodyBackTitleArry @[@"请选择>",@"请输入",@"请选择>",@"请选择>",@"请输入",@"请选择>",@"请选择>",@"请选择>"]
//!<代课类型
#define kTipsayTitleArry @[@"代课日期",@"代课节次",@"代课科目",@"代课教师",@"上课班级"]
#define kTipsayBackTitleArry @[@"请选择>",@"请输入",@"请选择>",@"请选择>",@"请输入"]
@interface XHNewBulidViewController ()<UITableViewDelegate,UITableViewDataSource,XHDatePickerControlDeletage,XHCalendarViewDelegate>
{
    
    NSInteger _tag;
    NSString * _bizType ;  //!< 业务类型(1:调课 2:代课)
     NSString *_formerSubject ;//!< 原任课程
    NSString *_formerSubjectId ;//!< 原任课程Id
    NSString *_clazzName ; //!< 班级名字
    NSString *_appointedTeacher ;   //!< 委任教师
    NSString *_appointedTeacherId ;   //!< 委任教师Id
     NSString *_appointedSubject;//!<委任课程
    NSString *_appointedSubjectId;//!<委任课程Id
    NSString *_beginTime;//!< 上课时间 格式：yyyy-MM-dd HH:mm
    NSString *_subjectNum ;//!< 几节课
    NSString *_actorId;   //!<申请人ID（教师Id）
    NSString *_shr;//!< 审核人ID（限制一位审核人）
    NSString *_shrName;//!< 审核人（限制一位审核人）
    NSString *_shrHeadPic;//!< 审核人头像（限制一位审核人）
}
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,assign)XHNewBulidModelType modelType;
@property(nonatomic,strong)XHCalendarView *calendarView;
@end

@implementation XHNewBulidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"调课报备"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"历史记录"];
     _bizType=@"1";
    [self.view addSubview:self.tableView];//,@"备注",@"审批人",@"抄送人"
    [self refrehDataType:XHNewBulidMelodyType];
    [self.tableView reloadData];
}
#pragma mark- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count+2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>self.dataArray.count) {
        return 180;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        XHNewChageTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"chageTypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=@"类型选择";
        [cell.melodyBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.otherBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.row>self.dataArray.count)
    {
        XHNewHeardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.approveLabel.text=@"审批人";
        [cell.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString safeString:_shrHeadPic]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
        cell.nameLabel.text=[NSString safeString:_shrName];
        return cell;
    }
    else
    {
        XHCoursePeportModel *model=self.dataArray[indexPath.row-1];
        XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text=model.title;
        cell.selectLabel.text=model.backTitle;
        return cell;
    }
    
//    switch (indexPath.row) {
//            case 3:
//        {
//            XHNewChageTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"chageTypeCell" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.titleLabel.text=TITLE[indexPath.row];
//            [cell.melodyBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.otherBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            return cell;
//        }
//
//            break;
//        case 7:
//        {
//            XHNewTextFieldTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"textcell" forIndexPath:indexPath];
//           cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.titleLabel.text=TITLE[indexPath.row];
//            cell.textFeild.hidden=NO;
//            cell.selectLabel.text=@"节课程";
//            cell.textFeild.text=[NSString safeString:_subjectNum];
//            cell.textFeild.keyboardType=UIKeyboardTypeNumberPad;
//            [cell.textFeild addTarget:self action:@selector(textChage:) forControlEvents:UIControlEventEditingChanged];
//            return cell;
//        }
//            break;
//        case 8:
//        {
//            XHNewHeardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.approveLabel.text=TITLE[indexPath.row];
//            [cell.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [cell.headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString safeString:_shrHeadPic]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
//            cell.nameLabel.text=[NSString safeString:_shrName];
//            return cell;
//        }
//
//            break;
//
//        default:
//
//        {
//            XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//            cell.selectLabel.text=@"请选择";
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.titleLabel.text=TITLE[indexPath.row];
//            switch (indexPath.row) {
//                case 0:
//                {
//                    cell.selectLabel.text=[NSString safeString:[XHUserInfo sharedUserInfo].teacherName];
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                }
//                    break;
//                case 1:
//                {
//                    cell.selectLabel.text=[[NSString safeString:_formerSubject] isEqualToString:@""]?@"请选择":_formerSubject;
//                }
//                    break;
//                case 2:
//                {
//                    cell.selectLabel.text=[[NSString safeString:_clazzName] isEqualToString:@""]?@"请输入":_clazzName;
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                }
//                    break;
//                    case 4:
//                {
//                    cell.selectLabel.text=[[NSString safeString:_appointedTeacher] isEqualToString:@""]?@"请选择":_appointedTeacher;
//                }
//                    break;
//                case 5:
//                {
//                    cell.selectLabel.text=[[NSString safeString:_appointedSubject] isEqualToString:@""]?@"请选择":_appointedSubject;
//                }
//                    break;
//                case 6:
//                {
//                    cell.selectLabel.text=[[NSString safeString:_beginTime] isEqualToString:@""]?@"请选择":_beginTime;
//                }
//                    break;
//
//            }
//            return cell;
//        }
//
//            break;
//    }
    
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (indexPath.row >self.dataArray.count)
    {
        
    }
    else
    {
         [self.calendarView show];
        if (self.modelType==XHNewBulidMelodyType)
        {
            switch (indexPath.row) {
                case 1:
                {
                   
                }
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            
        }
    }
    

    /*
    switch (indexPath.row) {
             case 4:
        {
            XHTeacherAddressBookViewController *teacherAddressBook=[XHTeacherAddressBookViewController new];
            [self.navigationController pushViewController:teacherAddressBook animated:YES];
            teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
            {
                XHNewTextFieldTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.selectLabel.text=itemObject.model.teacherName;
                switch (indexPath.row) {
                    case 4:
                    {
                        _appointedTeacherId=itemObject.model.ID;
                     _appointedTeacher=itemObject.model.teacherName;
                    }
                        break;
                }
            };
        }
            break;
            case 1:
            case 5:
        {
            [UIAlertController alertSubjectListWithController:self indexBlock:^(NSInteger index, id object) {
                XHSubjectListModel *model=object;
                XHNewTextFieldTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.selectLabel.text=model.subjectName;
                switch (indexPath.row) {
                    case 1:

                    {
                        _formerSubjectId=model.ID;
                        _formerSubject=model.subjectName;
                    }
                        break;

                    case 5:
                    {
                        _appointedSubjectId=model.ID;
                        _appointedSubject=model.subjectName;
                    }
                        break;
                }
            }];

        }
            break;
        case 2:
        {
            [UIAlertController addtextFeildWithController:self indexBlock:^(NSInteger index, id object) {
                    XHNewTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.selectLabel.text=object;
                    _clazzName=object;
            }];

        }
            break;

            case 6:
        {
             [[XHDatePickerControl sharedObject] showWithDeletage:self];
        }
            break;
    }
     */
}
-(void)getCalendarDateStr:(NSString *)dateStr
{
    kNSLog(dateStr);
}
#pragma mark-------------选择调课类型按钮方法--------------
-(void)selectBtnClick:(BaseButtonControl *)btn
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //找到对应的cell
    XHNewChageTypeTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    
    switch (btn.tag) {
        case 100:
        {
            [cell.melodyBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
            [cell.otherBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
            _bizType=@"1";
            [self refrehDataType:XHNewBulidMelodyType];
        }
            break;

        default:
            {
                [cell.melodyBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
                [cell.otherBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
                _bizType=@"2";
                 [self refrehDataType:XHNewBulidTipsayType];
            }
            break;
    }
    [self.tableView  reloadData];
}
-(void)refrehDataType:(XHNewBulidModelType)modeltype
{
    
      [self.dataArray removeAllObjects];
    switch (modeltype) {
        case XHNewBulidTipsayType:
        {
            [kTipsayTitleArry enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 XHCoursePeportModel *model=[[XHCoursePeportModel alloc] init];
                 model.title=obj;
                 model.backTitle=kTipsayBackTitleArry[idx];
                 [self.dataArray addObject:model];
             }];
            self.modelType=XHNewBulidTipsayType;
        }
            break;
            
        case XHNewBulidMelodyType:
        {
            [kMelodyTitleArry enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 XHCoursePeportModel *model=[[XHCoursePeportModel alloc] init];
                 model.title=obj;
                 model.backTitle=kMelodyBackTitleArry[idx];
                 
                 [self.dataArray addObject:model];
             }];
            self.modelType=XHNewBulidMelodyType;
        }
            break;
    }
  
    
}
#pragma mark  选择时间选择器代理方法
-(void)datePickerClickObject:(NSString*)date
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    //找到对应的cell
    XHNewTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    cell.selectLabel.text=date;
    _beginTime=date;
}
-(void)textChage:(UITextField *)text
{
    _subjectNum=text.text;
}
#pragma mark-------------审批人按钮--------------
-(void)headBtnClick
{
    XHTeacherAddressBookViewController *teacherAddressBook=[XHTeacherAddressBookViewController new];
    [self.navigationController pushViewController:teacherAddressBook animated:YES];
    teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
    {
        NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        //找到对应的cell
        XHNewHeardTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        [cell.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:itemObject.model.headerUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
        cell.nameLabel.text=itemObject.model.teacherName;
        _shr=itemObject.model.ID;
        _shrName=itemObject.model.teacherName;
        _shrHeadPic=itemObject.model.headerUrl;
    };
}
#pragma mark-------------提交按钮--------------
-(void)sureBtnClick
{
    if ([[NSString safeString:_formerSubjectId]  isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择课程名称"];
        return;
    }
    if ([[NSString safeString:_clazzName] isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择班级"];
        return;
    }
    if ([[NSString safeString:_appointedTeacherId]  isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择委任老师"];
        return;
    }
    if ([[NSString safeString:_appointedSubjectId]  isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请委任课程"];
        return;
    }
    
    if ([[NSString safeString:_beginTime] isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择上课时间"];
        return;
    }
    if ([[NSString safeString:_subjectNum]  isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择节数"];
        return;
    }
    if ([[NSString safeString:_shr]  isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择审核人"];
        return;
    }
    [self.netWorkConfig setObject:_bizType forKey:@"bizType"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"formerTeacherId"];
    [self.netWorkConfig setObject:_formerSubjectId forKey:@"formerSubjectId"];
     [self.netWorkConfig setObject:_clazzName forKey:@"clazzName"];
     [self.netWorkConfig setObject:_appointedTeacherId forKey:@"appointedTeacherId"];
    [self.netWorkConfig setObject:_appointedSubjectId forKey:@"appointedSubjectId"];
    [self.netWorkConfig setObject:_beginTime forKey:@"beginTime"];
    [self.netWorkConfig setObject:_subjectNum forKey:@"subjectNum"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"actorId"];
    [self.netWorkConfig setObject:_shr forKey:@"shr"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_bizInfo001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {}];
}
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHHistoryViewController *history = [XHHistoryViewController new];
    history.modelType=XHHistoryCourseReportType;
    [self.navigationController pushViewController:history animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_tableView registerClass:[XHNewTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"XHNewTextFieldTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"textcell"];
        [_tableView registerNib:[UINib nibWithNibName:@"XHNewHeardTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
        [_tableView registerClass:[XHNewChageTypeTableViewCell class] forCellReuseIdentifier:@"chageTypeCell"];
    }
    return _tableView;
}
-(XHCalendarView *)calendarView
{
    if (_calendarView==nil) {
        _calendarView=[[XHCalendarView alloc] initWithDelegate:self];
    }
    return _calendarView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
