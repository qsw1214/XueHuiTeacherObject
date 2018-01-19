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
#import "XHApproverTableViewCell.h"
#import "XHHistoryApproverDetailTableViewCell.h"
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
     [_tableView registerClass:[XHApproverTableViewCell class] forCellReuseIdentifier:@"approverCell"];
     [_tableView registerClass:[XHHistoryApproverDetailTableViewCell class] forCellReuseIdentifier:@"historyApproverCell"];
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
   
    if (indexPath.section==1) {
        if (self.isSelf&&self.Tag==10) {
            return 80;
        }
        else
        {
            return 145;
        }
    }
    else
    {
        if (indexPath.row==0) {
            return 60;
        }
        if (indexPath.row==9) {
            return 110;
        }
        else
        {
            return 50;
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            XHHistoryHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyHeadCell" forIndexPath:indexPath];
            cell.titleLabel.text=@"张三的调课";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==9) {
            XHHistoryDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.approveLabel.text=TITLE[indexPath.row];
            cell.nameLabel.text=@"李四";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
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
    else {
        if (self.Tag==11) {
#pragma mark-------------审批人显示cell--------------
            XHHistoryApproverDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyApproverCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i=0; i<2; i++) {
                UIImageView *selectImage=[cell.contentView viewWithTag:100+i];
                UIButton *headBtn=[cell.contentView viewWithTag:200+i];
                XHBaseLabel *nameLabel=[cell.contentView viewWithTag:300+i];
                XHBaseLabel *dateLabel=[cell.contentView viewWithTag:400+i];
                XHBaseLabel *applyLabel=[cell.contentView viewWithTag:500+i];
                if (i==1) {
                    selectImage.backgroundColor=[UIColor greenColor];
                    headBtn.backgroundColor=[UIColor redColor];
                    nameLabel.text=@"李四";
                    dateLabel.text=@"2018-01-03";
                    applyLabel.text=@"已同意";
                }
                else
                {
                    nameLabel.text=@"张明";
                    applyLabel.text=@"发起申请";
                    dateLabel.text=@"2018-01-02";
                }
                
            }
            
            return cell;
        }
        else
        {
            if (self.isSelf)
            {
#pragma mark--------------发起人显示cell--------------
                XHApplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"applyCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text=@"张明";
                cell.applyLabel.text=@"发起申请";
                cell.dateLabel.text=@"2018-01-02";
                return cell;
            }
            else
            {
#pragma mark-------------审批人显示cell--------------
                XHApproverTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"approverCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text=@"张明";
                cell.applyLabel.text=@"发起申请";
                cell.dateLabel.text=@"2018-01-02";
                for (int i=0; i<2; i++) {
                    XHBaseBtn *btn=[cell.contentView viewWithTag:10+i];
                    [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                return cell;
            }
        }
    }

}
-(void)selectBtnClick:(XHBaseBtn *)btn

{
    NSLog(@"-----%zd-----%@",btn.tag,btn.tag==10?@"拒绝":@"同意");
    //跳转到已审列表
    if (self.isRefresh) {
       self.isRefresh(YES);
        [self.navigationController popViewControllerAnimated:YES];
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
