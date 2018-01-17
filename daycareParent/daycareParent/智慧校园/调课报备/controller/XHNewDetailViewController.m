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
    _tableView.sectionHeaderHeight=10;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNewHeardTableViewCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
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
       return 5;
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
        return 180;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 9:
            switch (indexPath.section) {
                case 0:
                {
                    XHNewHeardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"headcell" forIndexPath:indexPath];
                    [cell.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //[cell.headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
                   // [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }
                    
                    break;
            }
            break;
            
    }
    {
        XHNewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text=TITLE[indexPath.row];
        return cell;
    }
}
-(UIImageView *)imageV
{
    if (_imageV==nil) {
        _imageV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 60, 60)];
        _imageV.layer.cornerRadius=30;
        _imageV.layer.masksToBounds=YES;
        _imageV.backgroundColor=[UIColor redColor];
    }
    return _imageV;
}
-(void)letfItemAction:(BaseNavigationControlItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"-------消失成功");
    }];
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
