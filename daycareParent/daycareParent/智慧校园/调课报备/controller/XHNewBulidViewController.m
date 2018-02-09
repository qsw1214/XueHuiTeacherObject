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
#define TITLE  @[@"原任课教师",@"课程名称",@"上课班级",@"调整类型",@"委任教师",@"委任课程",@"上课时间",@"请假时长",@"审批人"]
@interface XHNewBulidViewController ()<UITableViewDelegate,UITableViewDataSource,XHDatePickerControlDeletage>
{
    BaseTableView *_tableView;
    NSInteger _tag;
    NSString * _bizType ;  //!< 业务类型(1:调课 2:代课)
    NSString *_formerTeacherId ;   //!< 原任课教师Id
    NSString *_formerSubjectId ;//!< 课程Id
    NSString *_clazzName ; //!< 班级名字
    NSString *_appointedTeacherId ;   //!< 委任教师Id
    NSString *_appointedSubjectId;//!<委任课程Id
    NSString *_beginTime;//!< 上课时间 格式：yyyy-MM-dd HH:mm
    NSString *_subjectNum ;//!< 几节课
    NSString *_actorId;   //!<申请人ID（教师Id）
    NSString *_shr;//!< 审核人ID（限制一位审核人）

}
@end

@implementation XHNewBulidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //[_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     [_tableView registerClass:[XHNewTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTextFieldTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"textcell"];
      [_tableView registerNib:[UINib nibWithNibName:@"XHNewHeardTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
    [_tableView registerClass:[XHNewChageTypeTableViewCell class] forCellReuseIdentifier:@"chageTypeCell"];
    [self.view addSubview:_tableView];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==8) {
        return 180;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            case 3:
        {
            XHNewChageTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"chageTypeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=TITLE[indexPath.row];
             _bizType=@"1";
            [cell.melodyBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.otherBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            
            break;
        case 7:
        {
            XHNewTextFieldTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"textcell" forIndexPath:indexPath];
           cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=TITLE[indexPath.row];
            cell.textFeild.hidden=NO;
            cell.selectLabel.text=@"节课程";
            cell.textFeild.keyboardType=UIKeyboardTypeNumberPad;
            [cell.textFeild addTarget:self action:@selector(textChage:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }
            break;
        case 8:
        {
            XHNewHeardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.approveLabel.text=TITLE[indexPath.row];
            [cell.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            
            break;
            
        default:
            
        {
            XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectLabel.text=@"请选择";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text=TITLE[indexPath.row];
            if (indexPath.row==2) {
                cell.selectLabel.text=@"请输入";
               cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
           
            break;
    }
    
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            case 0:
             case 4:
        {
            XHTeacherAddressBookViewController *teacherAddressBook=[XHTeacherAddressBookViewController new];
            [self.navigationController pushViewController:teacherAddressBook animated:YES];
            teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
            {
                XHNewTextFieldTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.selectLabel.text=itemObject.model.teacherName;
                switch (indexPath.row) {
                    case 0:
                    {
                        _formerTeacherId=itemObject.model.ID;
                    }
                        break;
                        
                    case 4:
                    {
                        _appointedTeacherId=itemObject.model.ID;
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
                    }
                        break;
                        
                    case 5:
                    {
                        _appointedSubjectId=model.ID;
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
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入上课班级" preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//
//            }];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                if (alertController.textFields.firstObject.text.length==0) {
//                    [XHShowHUD showNOHud:@"班级不能为空"];
//                    return ;
//                }
//               XHNewTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//                cell.selectLabel.text=alertController.textFields.firstObject.text;
//                _clazzName=alertController.textFields.firstObject.text;
//            }]];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            }]];
//            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        
            case 6:
        {
             [[XHDatePickerControl sharedObject] showWithDeletage:self];
        }
            break;
    }
}
#pragma mark-------------选择调课类型按钮方法--------------
-(void)selectBtnClick:(BaseButtonControl *)btn
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //找到对应的cell
    XHNewChageTypeTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    switch (btn.tag) {
        case 100:
        {
            [cell.melodyBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
            [cell.otherBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
            _bizType=@"1";
        }
            break;

        default:
            {
                [cell.melodyBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
                [cell.otherBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
                _bizType=@"2";
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
    };
}
#pragma mark-------------提交按钮--------------
-(void)sureBtnClick
{
    if ([[NSString safeString:_formerTeacherId] isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"请选择原任老师"];
        return;
    }
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
    [self.netWorkConfig setObject:_formerTeacherId forKey:@"formerTeacherId"];
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
//        //数据还原
//            [self resetData];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark  数据还原
-(void)resetData
{
    _formerTeacherId =@"";
    _formerSubjectId =@"";
    _clazzName =@"";
    _appointedTeacherId =@"";
   _appointedSubjectId=@"";
    _beginTime=@"";
   _subjectNum =@"";
    _actorId=@"";
    _shr=@"";
    for (int i=0; i<9; i++) {
        if (i==2||i==7)
        {
            NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //找到对应的cell
            XHNewTextFieldTypeTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            if (i==2) {
               cell.selectLabel.text=@"请选择";
            }
            if (i==7)
            {
                cell.textFeild.text=@"";
            }
            
        }
        else if (i==8)
        {
            NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //找到对应的cell
            XHNewHeardTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            [cell.headBtn sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
            cell.nameLabel.text=@"";
        }
        else
        {
            NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //找到对应的cell
            XHNewTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.selectLabel.text=@"请选择";
        }
       
    }
   
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
