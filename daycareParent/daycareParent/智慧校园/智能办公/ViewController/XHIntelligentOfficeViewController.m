//
//  XHIntelligentOfficeViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeViewController.h"
#import "XHIntelligentOfficeCell.h"
#import "XHIntelligentOfficeTableViewHeaderView.h"
@interface XHIntelligentOfficeViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BaseTableView *tableView;

@property (nonatomic,strong) XHIntelligentOfficeTableViewHeaderView *headerView;
@end

@implementation XHIntelligentOfficeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"智能办公"];
    [self navtionHidden:YES];
    
    for (int i = 0; i < 1; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setModelType:XHIntelligentOfficeClassSwitchingType];
        [model setStartTime:@"2017-03-11 第二节语文课"];
        [model setTeacher:@"姚立志"];
        [model setEndTime:@"2017-03-17 第二节语文课"];
        [model setTargetTeacher:@"光头强"];
        [model setApproveType:XHIntelligentOfficeNOApproveType];
        [frame setModel: model];
        [self.dataArray addObject:frame];
        
    }
    
    
    for (int i = 0; i < 1; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setModelType:XHIntelligentOfficeTakeOverClassType];
        [model setStartTime:@"2017-03-11 第三节美术"];
        [model setTeacher:@"光头强"];
        [model setApproveType:XHIntelligentOfficeUnknownApproveType];
        [frame setModel: model];
        [self.dataArray addObject:frame];
    }
    
    
    for (int i = 0; i < 10; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setModelType:XHIntelligentOfficeAskforleaveType];
        [model setStartTime:@"2017-03-11 15:36"];
        [model setEndTime:@"2017-03-17 18:30"];
        [model setTargetTeacher:@"光头强"];
        [model setApproveType:XHIntelligentOfficeApproveType];
        [frame setModel: model];
        [self.dataArray addObject:frame];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.tableView.tableHeaderView=self.headerView;
        [self.tableView refreshReloadData];
    }
}



#pragma mark - Delegate Method
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}


- (XHIntelligentOfficeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHIntelligentOfficeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHIntelligentOfficeCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




#pragma mark - Getter /  Setter
-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}

-(XHIntelligentOfficeTableViewHeaderView *)headerView
{
    if (_headerView==nil) {
        _headerView=[[XHIntelligentOfficeTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 545)];
    }
    return _headerView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.headerView addTimer];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.headerView invalidate];
}

@end
