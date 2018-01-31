//
//  XHClassViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassViewController.h"
#import "BaseTableView.h"
#import "XHClassTableViewCell.h"
#import "XHClassListModel.h"
#import "XHSubjectListModel.h"
@interface XHClassViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
}
@end

@implementation XHClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.classModelType) {
        case XHClassListType:
        {
            [self setNavtionTitle:@"班级列表"];
        }
            break;
            
        case XHClassSubjectType:
        {
            [self setNavtionTitle:@"学科列表"];
        }
            break;
    }
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=44;
    [_tableView registerClass:[XHClassTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    [self.view addSubview:_tableView];
    
}
-(void)refreshHead
{
    [self getClassData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_tableView tableTipViewWithArray:self.dataArray];
   return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHClassTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (self.classModelType) {
        case XHClassListType:
        {
            XHClassListModel *model=self.dataArray[indexPath.row];
            cell.contentLab.text=model.gradeAndClassName;
        }
            break;
        case XHClassSubjectType:
        {
            XHSubjectListModel *model=self.dataArray[indexPath.row];
            cell.contentLab.text=model.subjectName;
        }
            break;
      
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.getClassBock) {
        self.getClassBock(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getClassData
{
    switch (self.classModelType) {
        case XHClassListType:
        {
            [[XHUserInfo sharedUserInfo] getClassList:^(BOOL isOK, NSMutableArray *classListArry) {
                if (isOK) {
                    [self.dataArray setArray:classListArry];
                    [_tableView refreshReloadData];
                }
            }];
        }
            break;
            
        case XHClassSubjectType:
        {
            [[XHUserInfo sharedUserInfo] getSubjectList:^(BOOL isOK, NSMutableArray *subjectListArry) {
                if (isOK) {
                    [self.dataArray setArray:subjectListArry];
                    [_tableView refreshReloadData];
                }
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
