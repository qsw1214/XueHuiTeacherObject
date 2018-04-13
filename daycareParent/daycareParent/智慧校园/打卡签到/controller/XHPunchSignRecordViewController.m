//
//  XHPunchSignRecordViewController.m
//  daycareParent
//
//  Created by mac on 2018/4/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignRecordViewController.h"
#import "XHPunchSignRecordCell.h"
#import "XHDateSwitchControl.h"



@interface XHPunchSignRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) XHDateSwitchControl *dateSwitchControl;
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
        
        [self.dateSwitchControl resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        [self.view addSubview:self.dateSwitchControl];
        
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView resetFrame:CGRectMake(0, self.dateSwitchControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView setTipType:TipTitleType withTipTitle:@"暂无记录" withTipImage:nil];
        [self.view addSubview:self.tableView];
        
        [self.netWorkConfig setObject:[self.dateSwitchControl getNonceDate:NO] forKey:@"time"];
        [self getNetWorkDataWithType:YES];
        
        for (int i = 0; i<4; i++)
        {
            XHPunchSignRecordFrame *frame = [[XHPunchSignRecordFrame alloc]init];
            XHPunchSignRecordModel *model = [[XHPunchSignRecordModel alloc]init];
            [model setTitle:@"签到成功！"];
            [model setDate:@"2018-04-25"];
            [model setTime:@"12:56:36"];
            [model setMarkIcon:@"ico_morning"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        for (int i = 0; i<12; i++)
        {
            XHPunchSignRecordFrame *frame = [[XHPunchSignRecordFrame alloc]init];
            XHPunchSignRecordModel *model = [[XHPunchSignRecordModel alloc]init];
            [model setTitle:@"签到成功！"];
            [model setDate:@"2018-04-25"];
            [model setTime:@"12:56:36"];
            [model setMarkIcon:@"ico_afternoon"];
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
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


#pragma mark XHDateSwitchControlDelegate
-(void)dateSwitchAction:(NSString *)date
{
    [self.netWorkConfig setObject:date forKey:@"time"];
    [self getNetWorkDataWithType:YES];
}




#pragma mark - NetWork Method
 -(void)refreshHeaderAction
{
    [self getNetWorkDataWithType:YES];
}

#pragma mark 获取考勤记录

-(void)getNetWorkDataWithType:(BOOL)type
{
    @WeakObj(self);
    [XHShowHUD showTextHud];

    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"teacherId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_attendanceSheet005" sucess:^(id object, BOOL verifyObject)
     {
         @StrongObj(self);
         if (verifyObject)
         {
             NSArray *itemArray = [object objectForKey:@"object"];
             NSMutableArray *tempArray = [NSMutableArray array];
             [NSArray enumerateObjectsWithArray:itemArray usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop, BOOL forceStop)
              {
                  if (forceStop)
                  {
                      NSDictionary *object = [obj objectItemKey:@"propValue"];
                      XHPunchSignRecordFrame *frame = [[XHPunchSignRecordFrame alloc]init];
                      XHPunchSignRecordModel *model = [[XHPunchSignRecordModel alloc]init];
                      [model setItemObject:object];
                      [frame setModel:model];
                      [tempArray addObject:frame];
                  }
              }];
             
             [self.dataArray setArray:tempArray];
             [self.tableView refreshReloadData];
         }
         
         
     } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
    
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


-(XHDateSwitchControl *)dateSwitchControl
{
    if (!_dateSwitchControl)
    {
        _dateSwitchControl = [[XHDateSwitchControl alloc]init];
        [_dateSwitchControl setBackgroundColor:RGB(244.0, 244.0, 244.0)];
        [_dateSwitchControl setDelegate:self];
    }
    return _dateSwitchControl;
}

@end

