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
#define TITLE  @[@"原任课教师",@"课程名称",@"上课班级",@"调整类型",@"委任教师",@"委任课程",@"上课时间",@"请假时长",@"审批人"]
@interface XHNewBulidViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    NSInteger _tag;
}
@end

@implementation XHNewBulidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self navtionHidden:YES];
//    self.view.backgroundColor=[UIColor orangeColor];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
            [cell.melodyBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.otherBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            
            break;
        case 2:
        case 7:
        {
            XHNewTextFieldTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"textcell" forIndexPath:indexPath];
           cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text=TITLE[indexPath.row];
            cell.textFeild.hidden=NO;
            cell.selectLabel.text=@"节课程";
            cell.textFeild.keyboardType=UIKeyboardTypeNumberPad;
            if (indexPath.row==2) {
                cell.selectLabel.text=@"请输入";
                cell.textFeild.hidden=YES;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            return cell;
        }
            break;
        case 8:
        {
            XHNewHeardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.approveLabel.text=TITLE[indexPath.row];
            cell.nameLabel.text=@"张三";
            [cell.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            
            break;
            
        default:
            
        {
            XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text=TITLE[indexPath.row];
            return cell;
        }
           
            break;
    }
    
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 2:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入上课班级" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertController.textFields.firstObject.text.length==0) {
                    [XHShowHUD showNOHud:@"班级不能为空"];
                    return ;
                }
              XHNewTextFieldTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.selectLabel.text=alertController.textFields.firstObject.text;
               
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
            
        default:
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
        }
            break;

        default:
            {
                [cell.melodyBtn setImage:@"ico_no" withNumberType:0 withAllType:NO];
                [cell.otherBtn setImage:@"ico_yes" withNumberType:0 withAllType:NO];
            }
            break;
    }
}
#pragma mark-------------审批人按钮--------------
-(void)headBtnClick
{
    NSLog(@"审批人按钮");
}
#pragma mark-------------提交按钮--------------
-(void)sureBtnClick
{
    NSLog(@"提交按钮");
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
