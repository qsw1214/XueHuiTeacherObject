//
//  XHLoginViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLoginViewController.h"
#import "MainRootControllerHelper.h"
#import "XHPassWordTableViewCell.h"
#import "XHForgetViewController.h"
#import "XHLoginModel.h"
#import "MianTabBarViewController.h"
#import "AppDelegate.h"
#import "XHChildListModel.h"
#import "XHLoginTableViewCell.h"
@interface XHLoginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)XHBaseBtn *sureButton;
@property(nonatomic,strong)UIButton *forgetButton;
@end

@implementation XHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navtionHidden:YES];
    ParentImageView *imageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center=CGPointMake(SCREEN_WIDTH/2.0, 125);
    imageView.layer.cornerRadius=20;
    imageView.layer.masksToBounds=YES;
    imageView.image=[UIImage imageNamed:@"tubiao"];
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.sureButton];
 
    [self.view addSubview:self.forgetButton];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLoginTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItemObject:nil withIndexPathRow:indexPath.row];
    return cell;
}
- (void)buttonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            UITextField *telePhone=[_tableView viewWithTag:10086];
            UITextField *pwd=[_tableView viewWithTag:10086+1];
            if (![UITextView verifyPhone:telePhone.text]) {
                [XHShowHUD showNOHud:@"请输入正确手机号!"];
                return;
            }
            if ([pwd.text length]<6)
            {
                [XHShowHUD showNOHud:@"密码至少6位!"];
                return;
            }
            XHNetWorkConfig *net=[[XHNetWorkConfig alloc] init];
            [net setObject:telePhone.text forKey:@"loginName"];
            [net setObject:pwd.text forKey:@"password"];
            [net setObject:@"2" forKey:@"userType"];
            [XHShowHUD showTextHud];
            [net postWithUrl:@"pmschool-teacher-api_/teacher/login" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    XHLoginModel *loginModel=[[XHLoginModel alloc] init];
                    loginModel.loginName=telePhone.text;
                    loginModel.pwd=pwd.text;
                    loginModel.type=[@"2" integerValue];
                    [[XHUserInfo sharedUserInfo] setItemObject:[object objectItemKey:@"object"]];
                    
                    if ([[XHUserInfo sharedUserInfo].selfId isEqualToString:@""]) {
                        [XHShowHUD showNOHud:@"登录失败！"];
                        return ;
                    }
                    [NSUserDefaults  saveLocalObject:loginModel forKey:AutoLogin];
                    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                    [app loginRongCloud:[XHUserInfo sharedUserInfo].token];
                    [app setJpushAlias:[XHUserInfo sharedUserInfo].loginName];
                    MianTabBarViewController *main=[MianTabBarViewController new];
                    [kWindow setRootViewController:main];
                }
                
            } error:^(NSError *error) {
                
            }];
        }
            break;
            
        case 2:
        {
            XHForgetViewController *forget=[XHForgetViewController new];
            [self.navigationController pushViewController:forget animated:YES];
        }
            break;
    }
    
    
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(40, 210, SCREEN_WIDTH-80, 116)];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
        [_tableView registerClass:[XHLoginTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(XHBaseBtn *)sureButton
{
    if (_sureButton==nil) {
        _sureButton=[[XHBaseBtn alloc] initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2.0+110, SCREEN_WIDTH-80, 44)];
        [_sureButton setBackgroundColor:MainColor];
        //[_sureButton setBackgroundImage:[UIImage imageNamed:@"btn_logn"] forState:UIControlStateNormal];
        [_sureButton setTitle:@"没错，就是我！" forState:UIControlStateNormal];
        [_sureButton setTag:1];
        [_sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
-(UIButton *)forgetButton
{
    if (_forgetButton==nil)
    {
      _forgetButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        _forgetButton.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-40);
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font=FontLevel2;
        [_forgetButton setTitleColor:MainColor forState:UIControlStateNormal];
        [_forgetButton setTag:2];
        [_forgetButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
