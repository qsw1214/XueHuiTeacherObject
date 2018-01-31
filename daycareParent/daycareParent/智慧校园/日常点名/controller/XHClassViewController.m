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
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=44;
    [_tableView registerClass:[XHClassTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self getClassData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHClassTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}
-(void)getClassData
{
    switch (self.classModelType) {
        case XHClassListType:
        {
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
            [self.netWorkConfig postWithUrl:@"pmschool-teacher-api_/teacher/attendanceSheet/classList" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    
                }
            } error:^(NSError *error) {
                
            }];
        }
            break;
            
        case XHClassSubjectType:
        {
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"teacherId"];
            [self.netWorkConfig postWithUrl:@"pmschool-teacher-api_/teacher/schoolwork/getSubjectAll" sucess:^(id object, BOOL verifyObject) {
                
            } error:^(NSError *error) {
                
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
