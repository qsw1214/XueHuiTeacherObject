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
#import "XHSetViewController.h"
#import "XHBindViewController.h"
#import "XHStudentInfoViewController.h"
#import "XHVIPViewController.h"
#import "XHStudyRecordViewController.h"
#import "XHMyAddressViewController.h"
#import "XHDiscuntViewController.h"
#import "XHChildListModel.h"
#import "XHVIPModel.h"
#import "XHEducationCloudWebViewController.h"
#import "BaseTableView.h"
#import "XHPasswordViewController.h"
#import "XHAboutUsViewController.h"
#define TITLE_LIST @[@"学习记录",@"收藏资源",@"下载记录",@"我的课程"]

@interface XHPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_HeaderView;
    BaseTableView *_tableView;
    NSArray *arry;
    NSArray *contentArry;
    UIButton *_h_btn;
    UILabel *_nameLabel;
//    UILabel* _conditionLabel;
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
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, SCREEN_HEIGHT-49-USER_HEARD-70) style:UITableViewStyleGrouped];
     _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    _tableView.bounces=NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.showsVerticalScrollIndicator=NO;
     [_tableView registerClass:[XHChildTableViewCell class] forCellReuseIdentifier:@"childcell"];
      [_tableView registerClass:[XHListTableViewCell class] forCellReuseIdentifier:@"listcell"];
     [_tableView registerClass:[XHSetTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];

     [self.view addSubview:self.h_view];
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
}
//-(NSMutableAttributedString *)chageTextColor:(NSString *)text fontColor:(UIColor *)fontColor
//{
//    NSString *labelStr = text; //初始化string为传入label.text的值
//    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];//创建一个字符串过滤参数,decimalDigitCharacterSet为过滤小数,过滤某个关键词,只需改变 decimalDigitCharacterSet类型  在将此方法增加一个 NSString参数即可
//    NSInteger remainSeconde = [[labelStr stringByTrimmingCharactersInSet:nonDigits]intValue];//获取过滤出来的数值
//    NSString *stringRange = [NSString stringWithFormat:@"%ld",(long)remainSeconde];//将过滤出来的Integer的值转换成String
//    NSRange range = [labelStr rangeOfString:stringRange];//获取过滤出来的数值的位置
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:text];//创建一个带属性的string
//    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:range];//给带属性的string添加属性,attrubute:添加的属性类型（颜色\文字大小\字体等等）,value:改变成的属性参数,range:更改的位置
//    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,5)];
//    return attrStr;
//}
//-(XHNetWorkConfig *)getVIPNet
//{
//
//    if (_getVIPNet==nil) {
//        _getVIPNet=[[XHNetWorkConfig alloc] init];
//    }
//    [_getVIPNet setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
//    [_getVIPNet postWithUrl:@"zzjt-app-api_vipInfo004" sucess:^(id object, BOOL verifyObject) {
//        if (verifyObject) {
//            id  dic=[object objectItemKey:@"object"];
//            if (![dic isEqual:@""]) {
//                XHVIPModel *model=[[XHVIPModel alloc] initWithDic:[dic objectItemKey:@"propValue"]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if ([model.expireType intValue]==0) {
//                        _conditionLabel.attributedText = [self chageTextColor:@"开通VIP" fontColor:KAITONG_VIPCOLOR];
//                        _vipbImageView.image=[UIImage imageNamed:@"ico_novip"];
//                    }
//                    if ([model.expireType intValue]==2) {
//                        _conditionLabel.attributedText = [self chageTextColor:@"续费VIP会员已过期" fontColor:KAITONG_VIPCOLOR];
//                        _vipbImageView.image=[UIImage imageNamed:@"ico_novip"];
//                    }
//                    if ([model.expireType intValue]==1) {
//                        if ([model.level intValue]==1) {
//                            _conditionLabel.attributedText = [self chageTextColor:[NSString stringWithFormat:@"白金VIP剩余%@天",model.day] fontColor:BAIJIN_VIPCOLOR];
//                            _vipbImageView.image=[UIImage imageNamed:@"ico_platinumvip"];
//                        }
//                        else
//                        {
//                            _conditionLabel.attributedText = [self chageTextColor:[NSString stringWithFormat:@"黄金VIP剩余%@天",model.day] fontColor:HUANGJIN_VIPCOLOR];
//                            _vipbImageView.image=[UIImage imageNamed:@"ico_vip"];
//                        }
//                    }
//                });
//            }
//
//        }
//    } error:^(NSError *error) {
//
//    }];
//    return _getVIPNet;
//}
//-(XHNetWorkConfig *)getChildListNet
//{
//    if (_getChildListNet==nil) {
//        _getChildListNet=[[XHNetWorkConfig alloc] init];
//    }
//    [_getChildListNet setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
//    [_getChildListNet postWithUrl:@"zzjt-app-api_smartCampus011" sucess:^(id object, BOOL verifyObject) {
//        if (verifyObject) {
//            [_ChildArry removeAllObjects];
//            for (NSDictionary *dic in [object objectItemKey:@"object"]) {
//                XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
//                [_ChildArry addObject:model];
//            }
//            [[XHUserInfo sharedUserInfo].childListArry setArray:_ChildArry];
//            [_ChildArry addObject:@""];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_tableView refreshReload];
//            });
//
//        }
//
//    } error:^(NSError *error) {
//        [_tableView refreshReload];
//    }];
//    return _getChildListNet;
//}
//
//-(void)refreshUserInfo
//{
//    if (![[XHUserInfo sharedUserInfo].guardianModel.familyId isEqualToString:@""]) {
//
//        return ;
//    }
//    XHLoginModel *model=[NSUserDefaults getLoginModel];
//    XHNetWorkConfig *net=[XHNetWorkConfig new];
//    [net setObject:model.loginName forKey:@"loginName"];
//    [net setObject:model.pwd forKey:@"pwd"];
//    [net setObject:@"3" forKey:@"type"];
//    [XHShowHUD showTextHud];
//    [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject) {
//        if (verifyObject)
//        {
//            XHGuardianInfo *guardianModel=[[XHGuardianInfo alloc] initWithDic:[[[object objectItemKey:@"object"] objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
//            [XHUserInfo sharedUserInfo].guardianModel=guardianModel;
//        }
//
//    } error:^(NSError *error) {
//
//    }];
//}
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
