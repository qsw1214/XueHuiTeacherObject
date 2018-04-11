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
#import "XHApproveModel.h"
#import "XHAskforLeaveDetailViewController.h"
#define TITLE @[@"待审批",@"已审批"]
@interface XHHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    NSInteger _tag;
    NSInteger _pageNumber;
}
@end

@implementation XHHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavtionTitle:@"审批列表"];
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
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无审批申请哦" withTipImage:@"img_norecord"];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFoot)];
    [_tableView beginRefreshing];
    [self.view addSubview:_tableView];
    
}
-(void)refreshHead
{
    _pageNumber=1;
    [self getRefreshType:HeaderRefresh];
}
-(void)refreshFoot
{
   [self getRefreshType:FooterRefresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_tableView tableTipViewWithArray:self.dataArray];
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNotifceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell setItemObject:self.dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.modelType) {
        case XHHistoryCourseReportType:
        {
            XHNewDetailViewController *detail=[XHNewDetailViewController new];
            [detail setNavtionTitle:_tag==10?@"待审批":@"已审批"];
            detail.Tag=_tag;
            detail.model=self.dataArray[indexPath.row];
            detail.isRefresh = ^(BOOL ok)
            {
                if (ok) {
                    
                    [_tableView beginRefreshing];
                }
            };
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
            
        case XHHistoryAskforLeaveType:
        {
            XHAskforLeaveDetailViewController *detail=[XHAskforLeaveDetailViewController new];
            [detail setNavtionTitle:_tag==10?@"待审批":@"已审批"];
            detail.Tag=_tag;
            detail.model=self.dataArray[indexPath.row];
            detail.isRefresh = ^(BOOL ok)
            {
                if (ok) {
                    
                    [_tableView beginRefreshing];
                }
            };
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
    }
    
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
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:_tag==10?@"暂无审批申请哦":@"暂无审批记录哦" withTipImage:@"img_norecord"];
    [_tableView beginRefreshing];
}
-(void)getRefreshType:(BaseRefreshType)refreshType
{
    switch (self.modelType) {
        case XHHistoryCourseReportType:
        {
            [self.netWorkConfig setObject:@"1" forKey:@"bizType"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
            [self.netWorkConfig setObject:_tag==10?@"0":@"1" forKey:@"isStatus"];
            [self.netWorkConfig setObject:@"10" forKey:@"pageSize"];
            [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",_pageNumber] forKey:@"pageNumber"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_bizInfo002" sucess:^(id object, BOOL verifyObject){
                if (verifyObject)
                {
                    switch (refreshType)
                    {
                        case HeaderRefresh:
                        {
                            [self.dataArray removeAllObjects];
                        }
                            break;
                        case FooterRefresh:
                            break;
                            
                    }
                    NSDictionary *objectDic=[object objectItemKey:@"object"];
                    NSArray *arry=[objectDic objectItemKey:@"pageResult"];
                    for (NSDictionary *dic in arry)
                    {
                        NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                        XHApproveModel *model=[[XHApproveModel alloc] initWithDic:Dic];
                        model.historyModelType=XHCourseReportType;
                        if (_tag==10)
                        {
                            model.modelType=XHNoApproveType;
                        }
                        else
                        {
                          model.modelType=XHApproveType;
                        }
                        [self.dataArray addObject:model];
                    }
                    if (arry.count<10)
                    {
                        [_tableView noMoreData];
                    }
                    else
                    {
                        _pageNumber++;
                        [_tableView refreshReloadData];
                    }
                }
                else
                {
                    [_tableView refreshReloadData];
                }
                
                
            } error:^(NSError *error) {
                [_tableView refreshReloadData];
            }];
        }
            break;
            
        case XHHistoryAskforLeaveType:
        {
            [self.netWorkConfig setObject:@"0" forKey:@"bizType"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
            [self.netWorkConfig setObject:_tag==10?@"0":@"1" forKey:@"isStatus"];
            [self.netWorkConfig setObject:@"10" forKey:@"pageSize"];
            [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",_pageNumber] forKey:@"pageNumber"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_bizInfo002" sucess:^(id object, BOOL verifyObject){
                if (verifyObject)
                {
                    switch (refreshType)
                    {
                        case HeaderRefresh:
                        {
                            [self.dataArray removeAllObjects];
                        }
                            break;
                        case FooterRefresh:
                            break;
                            
                    }
                    NSDictionary *objectDic=[object objectItemKey:@"object"];
                    NSArray *arry=[objectDic objectItemKey:@"pageResult"];
                    for (NSDictionary *dic in arry)
                    {
                        NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                        XHApproveModel *model=[[XHApproveModel alloc] initWithDic:Dic];
                        model.historyModelType=XHAskforLeaveType;
                        if (_tag==10)
                        {
                            model.modelType=XHNoApproveType;
                        }
                        else
                        {
                            model.modelType=XHApproveType;
                        }
                        [self.dataArray addObject:model];
                    }
                    if (arry.count<10)
                    {
                        [_tableView noMoreData];
                    }
                    else
                    {
                        _pageNumber++;
                        [_tableView refreshReloadData];
                    }
                }
                else
                {
                    [_tableView refreshReloadData];
                }
                
                
            } error:^(NSError *error) {
                [_tableView refreshReloadData];
            }];
        }
            break;
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
