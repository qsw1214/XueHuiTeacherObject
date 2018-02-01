//
//  XHDayRollCallDetailViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallDetailViewController.h"
#import "XHDayRollReasonTableViewCell.h"
#import "XHNewTableViewCell.h"
#import "XHHistoryHeadTableViewCell.h"
#import "XHHistoryDetailTableViewCell.h"
#define TITLE  @[@"请假",@"开始时间",@"结束时间",@"理由"]
@interface XHDayRollCallDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation XHDayRollCallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"请假详情"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
   
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHHistoryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
    [_tableView registerClass:[XHHistoryHeadTableViewCell class] forCellReuseIdentifier:@"historyHeadCell"];
      [_tableView registerClass:[XHDayRollReasonTableViewCell class] forCellReuseIdentifier:@"reasonCell"];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   if (indexPath.row==0) {
        return 60;
    }
    if (indexPath.row==3) {
       
        return [self getCellHeight];
    }
    else
    {
        return 50;
    }
        
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        XHHistoryHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"historyHeadCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setItemObject:self.model];
        return cell;
    }
    if (indexPath.row==3) {
        XHDayRollReasonTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reasonCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=TITLE[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setItemObject:self.model];
        return cell;
    }
    else
    {
        XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.titleLabel.text=TITLE[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 1:
            {
                cell.selectLabel.text=self.model.beginTime;
            }
                break;
            case 2:
            {
                cell.selectLabel.text=self.model.endTime;
            }
                break;
        }
        return cell;
    }
}
-(CGFloat )getCellHeight
{
    if ([self.model.picUrl isEqualToString:@""])
    {
        if ([NSString contentSizeWithTitle:self.model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height<50)
        {
            return 50;
        }
        else
        {
            return [NSString contentSizeWithTitle:self.model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height-10;
        }
        
    }
    else
    {
        if ([NSString contentSizeWithTitle:self.model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height<50)
        {
            return 120;
        }
        {
            return [NSString contentSizeWithTitle:self.model.content withFontOfSize:FontLevel2 withWidth:SCREEN_WIDTH-70].height+70;
        }
        
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
