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
#define TITLE  @[@"原任课教师",@"课程名称",@"上课班级",@"调整类型",@"委任教师",@"委任课程",@"上课时间",@"请假时长",@"审批人"]
@interface XHNewBulidViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
}
@end

@implementation XHNewBulidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTextFieldTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"textcell"];
    [self.view addSubview:_tableView];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==8) {
        return 190;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==7||indexPath.row==2) {
        XHNewTextFieldTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"textcell" forIndexPath:indexPath];
        cell.accessoryType = cell.accessoryType = UITableViewCellAccessoryNone;;
        cell.titleLabel.text=TITLE[indexPath.row];
        cell.textFeild.hidden=NO;
        cell.selectLabel.text=@"节课程";
        if (indexPath.row==2) {
            cell.selectLabel.text=@"请输入";
            cell.textFeild.hidden=YES;
        }
        return cell;
    }
    else
    {
        XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text=TITLE[indexPath.row];
        return cell;
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
