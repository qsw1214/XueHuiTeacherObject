//
//  XHPersonalCenterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPersonalCenterViewController.h"
#import "SDWebImage.h"
#import "XHListTableViewCell.h"
#import "XHChildTableViewCell.h"
#import "XHSetTableViewCell.h"
#import "XHUserViewController.h"
#import "XHChildListModel.h"
#import "XHVIPModel.h"
#import "XHEducationCloudWebViewController.h"
#import "BaseTableView.h"
#import "XHPasswordViewController.h"
#import "XHAboutUsViewController.h"
#import "XHCookBookViewController.h"
#import "XHCalendarView.h"
#define TITLE_LIST @[@"学习记录",@"收藏资源",@"下载记录",@"我的课程"]

@interface XHPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_HeaderView;
    BaseTableView *_tableView;
    NSArray *arry;
    NSArray *contentArry;
    UIButton *_h_btn;
    UILabel *_nameLabel;
    UILabel *_sigerLabel;
    float fileSize;
}
@property(nonatomic,strong)UIView *h_view;

@end

@implementation XHPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navtionHidden:YES];
    arry=@[@"修改密码",@"食谱管理",@"清除缓存",@"关于我们"];
    contentArry=@[@"ico-modify",@"icoshiouguanli",@"ico-clean",@"ico-about"];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.showsVerticalScrollIndicator=NO;
     [_tableView registerClass:[XHChildTableViewCell class] forCellReuseIdentifier:@"childcell"];
      [_tableView registerClass:[XHListTableViewCell class] forCellReuseIdentifier:@"listcell"];
     [_tableView registerClass:[XHSetTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView=self.h_view;
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    //去掉留白方法
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    fileSize= (float)[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [_tableView reloadData];
}
-(void)refreshHead
{
    [self refreshHeadView];
}
#pragma mark----tableviewDelegate------

- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
            XHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.setImageView.image=[UIImage imageNamed:contentArry[indexPath.row]];
            cell.setLabel.font=FontLevel2;
            cell.setLabel.text=arry[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 2:
                cell.setContentLabel.text=[NSString stringWithFormat:@"清理缓存(%.2fM)",fileSize];
                break;
        }
            return cell;

    }

-(CGFloat)tableView:(BaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            XHPasswordViewController *password=[[XHPasswordViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:password animated:YES];
        }
            break;
            case 1:
        {
            //跳转到食谱管理界面
                XHCookBookViewController *cookBook = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:cookBook animated:YES];
        }
            break;
        case 2:
        {
            [XHShowHUD showTextHud];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [XHShowHUD showOKHud:@"清除完成!"];
                fileSize=0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
        }
            break;
        case 3:
        {
            XHAboutUsViewController *about=[[XHAboutUsViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
       
    }
}
#pragma mark----导航栏视图
-(UIView *)h_view
{
    if (_h_view==nil) {
        _h_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        UIImageView *imgV=[[UIImageView alloc] initWithFrame:_h_view.bounds];
        imgV.image=[UIImage imageNamed:@"bg_jiaoshiduan"];
        [imgV setContentMode:UIViewContentModeScaleAspectFill];
        [_h_view addSubview:imgV];
//        XHBaseLabel *label=[[XHBaseLabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2.0, 20, 100, 44)];
//        label.text=@"我的";
//        label.font=FontLevel1;
//        label.textAlignment=NSTextAlignmentCenter;
//        label.textColor=[UIColor whiteColor];
//        [_h_view addSubview:label];
        _h_btn=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2.0,54,  70, 70)];
        _h_btn.layer.cornerRadius=35;
        _h_btn.layer.masksToBounds=YES;
        [_h_btn addTarget:self action:@selector(heardBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _h_btn.backgroundColor=[UIColor whiteColor];
        _h_view.backgroundColor=MainColor;
        [_h_view addSubview:_h_btn];
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-90)/2.0,_h_btn.bottom+5, 90, 25)];
        //_nameLabel.font=FontLevel2;
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.textColor=[UIColor blackColor];
        [ _h_view addSubview:_nameLabel];
        [self refreshHeadView];
    }
        return _h_view;
}
#pragma mark------heardBtnClick----
-(void)heardBtnClick
{
    XHUserViewController *userVC=[XHUserViewController new];
    [userVC setHidesBottomBarWhenPushed:YES];
    userVC.isRefresh = ^(BOOL ok) {
        if (ok) {
             [self refreshHeadView];
        }
    };
    [self.navigationController pushViewController:userVC animated:YES];
}

#pragma mark---------签名按钮绑定方法-------
-(void)signBtnClick:(XHBaseBtn *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请设置你的个性签名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[alertController.textFields firstObject].text isEqualToString:@""]) {
            [XHShowHUD showNOHud:@"请输入签名内容！"];
            return ;
        }
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
        [self.netWorkConfig setObject:[alertController.textFields firstObject].text forKey:@"signature"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _sigerLabel.text=[alertController.textFields firstObject].text;
                    [XHUserInfo sharedUserInfo].signature=[alertController.textFields firstObject].text;
                });
              
            }
        } error:^(NSError *error) {
            
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark---------刷新导航栏视图vip等级
-(void)refreshHeadView
{
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    [_h_btn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(userInfo.headPic)]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (![userInfo.nickName isEqualToString:@""]) {
        _nameLabel.text=userInfo.nickName;
    }
    else
    {
        _nameLabel.text=@"昵称";
    }
    if (![userInfo.signature isEqualToString:@""]) {
        _sigerLabel.text=userInfo.signature;
    }
    else
    {
        _sigerLabel.text=@"无签名，不个性";
    }
    [_tableView refreshReload];
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
