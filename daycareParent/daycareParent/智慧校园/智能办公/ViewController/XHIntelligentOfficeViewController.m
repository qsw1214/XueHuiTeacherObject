//
//  XHIntelligentOfficeViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeViewController.h"
#import "XHIntelligentOfficeCell.h"

@interface XHIntelligentOfficeViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BaseTableView *tableView;


@end

@implementation XHIntelligentOfficeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"智能办公"];
    
    for (int i = 0; i < 1; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setType:XHIntelligentOfficeHeaderType];
        [frame setModel: model];
        [self.dataArray addObject:frame];
        
    }
    
    
    for (int i = 0; i < 1; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setType:XHIntelligentOfficeApprovalType];
        [frame setModel: model];
        [self.dataArray addObject:frame];
    }
    
    
    for (int i = 0; i < 10; i++)
    {
        XHIntelligentOfficeFrame *frame = [[XHIntelligentOfficeFrame alloc]init];
        XHIntelligentOfficeModel *model = [[XHIntelligentOfficeModel alloc]init];
        [model setType:XHIntelligentOfficeContentType];
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
        [self.tableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
        
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




@end
