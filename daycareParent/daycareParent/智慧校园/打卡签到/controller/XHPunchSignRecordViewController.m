//
//  XHPunchSignRecordViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignRecordViewController.h"
#import "XHPunchSignRecordCell.h"


@interface XHPunchSignRecordViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BaseTableView *tableView;


@end

@implementation XHPunchSignRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"考勤记录"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
        
        
        
        
        for (int i = 0; i<20; i++)
        {
            XHPunchSignRecordFrame *frame = [[XHPunchSignRecordFrame alloc]init];
            XHPunchSignRecordModel *model = [[XHPunchSignRecordModel alloc]init];
            [model setTitle:@"签到成功！"];
            [model setDate:@"2018-04-25"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        [self.tableView refreshReloadData];
        
    }
}



#pragma mark - Delegate Method

- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}


- (XHPunchSignRecordCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHPunchSignRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHPunchSignRecordCell alloc]init];
    }
    [cell setRecordFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
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


@end

