//
//  XHNewDetailViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/17.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNewDetailViewController.h"
#import "BaseTableView.h"
#import "XHNewTableViewCell.h"
#import "XHNewHeardTableViewCell.h"
#import "XHHistoryDetailTableViewCell.h"
#import "XHHistoryHeadTableViewCell.h"
#import "XHApplyTableViewCell.h"
#define TITLE  @[@"李某某的课程",@"调整类型",@"原任课教师",@"课程名称",@"委任教师",@"委任课程",@"上课时间",@"上课班级",@"请假时长",@"审批人"]
@interface XHNewDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    NSInteger _tag;
}
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation XHNewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHHistoryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
    [_tableView registerClass:[XHHistoryHeadTableViewCell class] forCellReuseIdentifier:@"historyHeadCell"];
     [_tableView registerClass:[XHApplyTableViewCell class] forCellReuseIdentifier:@"applyCell"];
    [self.view addSubview:_tableView];
    [_tableView addSubview:self.imageV];
    //去掉留白方法
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else
    {
       return 0;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
             return 10;
            break;
            
        default:
            return 1;
            break;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==9) {
        return 110;
    }
    if (indexPath.section==0&&indexPath.row==0) {
        return 60;
    }
    if (indexPath.section==1) {
        return 80;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                    case 0:
                {
                    XHHistoryHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyHeadCell" forIndexPath:indexPath];
                    cell.titleLabel.text=@"张三的调课";
                    return cell;
                }
                    break;
                    break;
                case 9:
                {
                    XHHistoryDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
                    cell.approveLabel.text=TITLE[indexPath.row];
                    cell.nameLabel.text=@"李四";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
            }
            break;
            case 1:
        {
             XHApplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"applyCell" forIndexPath:indexPath];
            cell.nameLabel.text=@"张明";
            cell.applyLabel.text=@"发起申请";
            cell.dateLabel.text=@"2018-01-02";
            return cell;
        }
            break;
        
    }
    
    {
        XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text=TITLE[indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 1:
                cell.selectLabel.hidden=YES;
                break;
                
            default:
                cell.selectLabel.hidden=NO;
                break;
        }
        return cell;
    }
}
-(UIImageView *)imageV
{
    if (_imageV==nil) {
        _imageV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 30, 60, 60)];
        _imageV.layer.cornerRadius=30;
        _imageV.layer.masksToBounds=YES;
        _imageV.backgroundColor=[UIColor redColor];
    }
    return _imageV;
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
