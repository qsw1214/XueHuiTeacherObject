//
//  XHHistoryViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHHistoryViewController.h"
#import "BaseTableView.h"
#import "XHNotifceTableViewCell.h"
#import "XHNewDetailViewController.h"
#define TITLE @[@"待审批",@"已审批"]
@interface XHHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    NSInteger _tag;
}
@end

@implementation XHHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getApproveBtn];
    [self getTableView];
}
-(void)getTableView
{
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_HEIGHT-110) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=70;
    [_tableView registerClass:[XHNotifceTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.dataArray addObject:@"1"];
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    [self.view addSubview:_tableView];
    
}
-(void)refreshHead
{
    [_tableView refreshReloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_tableView tableTipViewWithArray:self.dataArray];
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNotifceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ContentLab.frame=CGRectMake(80, 35, SCREEN_WIDTH-180, 30);
    cell.ContentLab.textColor=[UIColor blackColor];
    cell.myApplyLabel.frame=CGRectMake(SCREEN_WIDTH-90, 40, 80, 20);
    cell.myApplyLabel.textAlignment=NSTextAlignmentCenter;
    cell.myApplyLabel.textColor=[UIColor whiteColor];
    cell.myApplyLabel.backgroundColor=[UIColor orangeColor];
    cell.myApplyLabel.layer.cornerRadius=10;
    cell.myApplyLabel.layer.masksToBounds=YES;
    cell.myApplyLabel.text=@"我的申请";
    cell.smallLab.frame=CGRectMake(50, 9, 8, 8);
    cell.smallLab.layer.cornerRadius=4;
    cell.titleLab.frame=CGRectMake(80, 0, SCREEN_WIDTH-180, 30);
    cell.titleLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(16.0)];
    cell.headImageView.image=[UIImage imageNamed:@"addman"];
    cell.titleLab.text=@"李某某的调课";
    cell.ContentLab.text=@"等待王某某的审批";
    cell.detailLab.text=@"2018-01-02";
    if (indexPath.row==0&&_tag==10) {
        cell.myApplyLabel.text=@"我的申请";
        cell.myApplyLabel.hidden=NO;
    }
    else
    {
          cell.myApplyLabel.hidden=YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNewDetailViewController *detail=[XHNewDetailViewController new];
    [detail setNavtionTitle:_tag==10?@"待审批":@"已审批"];
    detail.Tag=_tag;
    switch (indexPath.row) {
        case 0:
        {
            detail.isSelf=YES;
        }
           
            break;
            
        default:
        {
            detail.isSelf=NO;
        }
            break;
    }
    detail.isRefresh = ^(BOOL ok)
    {
        if (ok) {
            BaseButtonControl *lastBtn=[self.view viewWithTag:10];
            [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
            [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
            BaseButtonControl *btn=[self.view viewWithTag:11];
            [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
            [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
            _tag=11;
            [_tableView beginRefreshing];
            //[_tableView refreshReloadData];
        }
    };
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark-------------审批选项列表--------------
-(void)getApproveBtn
{
    for (int i=0; i<2; i++) {
        BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2.0-60)/2.0+i*SCREEN_WIDTH/2.0, 64, 60, 46)];
        [btn setNumberLabel:2];
        [btn setText:TITLE[i] withNumberType:0 withAllType:NO];
        [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [btn setTitleEdgeFrame:CGRectMake(0, 0, btn.width, btn.height-2) withNumberType:0 withAllType:NO];
        [btn setTitleEdgeFrame:CGRectMake(0, btn.height-2, btn.width, 2) withNumberType:1 withAllType:NO];
        btn.tag=10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
          [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
           [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
            _tag=10;
        }
        [self.view addSubview:btn];
    }
   
}
#pragma mark-------------审批按钮方法--------------
-(void)btnClick:(BaseButtonControl *)btn
{
    BaseButtonControl *lastBtn=[self.view viewWithTag:_tag];
    [lastBtn setTextColor:[UIColor blackColor] withTpe:0 withAllType:NO];
    [lastBtn setTextBackGroundColor:[UIColor clearColor] withTpe:1 withAllType:NO];
    [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
    [btn setTextBackGroundColor:[UIColor orangeColor] withTpe:1 withAllType:NO];
    _tag=btn.tag;
    [_tableView beginRefreshing];
    
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
