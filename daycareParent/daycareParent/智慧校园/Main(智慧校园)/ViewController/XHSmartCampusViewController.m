//
//  XHSmartCampusViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSmartCampusViewController.h"
#import "XHSmartCampusContentView.h"
#import "XHHomeWorkViewController.h" //!< 家庭作业
#import "XHAskforLeaveViewController.h" //!< 请假
#import "XHEducationCloudViewController.h" //!< 浩学云（教育云）
#import "XHCookBookViewController.h" //!<  食谱
#import "XHSyllabusViewController.h"  //!< 课程表
#import "XHAchievementViewController.h" //!< 成绩
#import "XHDynamicsViewController.h" //!< 班级动态
#import "XHLoginViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "XHAssignmentHomeWorkViewController.h"  //!< 发布作业
#import "XHAddNoticeViewController.h" //!< 通知公告
#import "XHDayRollCallViewController.h"//!< 日常点名
#import "XHNewBulidViewController.h"//!< 课程报备
#import "XHChatListViewController.h"
#import "XHPunchSignViewController.h"//!< 打卡签到
#import "XHAddressBoardViewController.h" //!< 通讯录


@interface XHSmartCampusViewController () <XHFunctionMenuControlDeletage,XHAdvertisementControlDeletage>

@property (nonatomic,strong) XHSmartCampusContentView *contentView;

@end

@implementation XHSmartCampusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navtionHidden:YES];
    [self setNavtionTitle:@"智慧校园"];
    [self navtionItemHidden:NavigationItemLeftType];
    //[self updateVersion];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
    }
}

#pragma mark - Deletage Method
#pragma mark XHFunctionMenuControlDeletage (功能点击)
-(void)functionDidSelectItemAtindexObject:(XHFunctionMenuFrame *)object
{
    switch (object.model.tage)
    {
#pragma mark case 0 打卡签到
        case 0:
        {
             XHPunchSignViewController *punch = [[XHPunchSignViewController alloc]initHiddenWhenPushHidden];
            [punch setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:punch animated:YES];
          
        }
            break;
#pragma mark case 1 通知公告
        case 1:
        {
            XHAddNoticeViewController *notice = [[XHAddNoticeViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:notice animated:YES];
        }
            break;
#pragma mark case 2: 课程报备
        case 2:
        {
                XHNewBulidViewController *course = [[XHNewBulidViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:course animated:YES];
        }
            break;
#pragma mark case 3 课程表
        case 3:
        {
            XHSyllabusViewController *syllabus = [[XHSyllabusViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:syllabus animated:YES];
        }
            break;
#pragma mark case 4 成绩管理
        case 4:
        {
            XHAchievementViewController *achievement = [[XHAchievementViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:achievement animated:YES];
        }
            break;
#pragma mark case 5 请假
        case 5:
        {
            XHAskforLeaveViewController *leave = [[XHAskforLeaveViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:leave animated:YES];
        }
            break;
#pragma mark case 6 食谱管理
        case 6:
        {
            XHCookBookViewController *cookBook = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:cookBook animated:YES];
        }
            break;
#pragma mark case 7 通讯录
        case 7:
        {
            XHAddressBoardViewController *addressBook = [[XHAddressBoardViewController alloc]initHiddenWhenPushHidden];
            [addressBook setNavtionTitle:@"通讯录"];
            [self.navigationController pushViewController:addressBook animated:YES];
           
        }
            break;
#pragma mark case 8 班级动态
        case 8:
        {
            XHDynamicsViewController *dynamics = [[XHDynamicsViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:dynamics animated:YES];
        }
            break;
    }
}



#pragma mark 点击日常点名和发布作业按钮
-(void)advertisementAction:(BaseButtonControl*)sender
{
    switch (sender.tag)
    {
#pragma mark case 1 日常点名
        case 1:
        {
            XHDayRollCallViewController *rollCall=[[XHDayRollCallViewController alloc] initHiddenWhenPushHidden];
             [self.navigationController pushViewController:rollCall animated:YES];
        }
            break;
#pragma mark case 2 发布作业
        case 2:
        {
            XHAssignmentHomeWorkViewController *homeWork = [[XHAssignmentHomeWorkViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:homeWork animated:YES];
        }
            break;
    }

}

#pragma mark XHScrollPreviewControlDeletage (广告轮播)
-(void)scrollPreviewDidSelectItemAtindexObject:(XHFunctionMenuFrame *)object
{
    
}





#pragma mark - Getter / Setter
-(XHSmartCampusContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHSmartCampusContentView alloc]initWithDeletage:self];
        [_contentView resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50.0)];
    }
    return _contentView;
}

-(void)updateVersion
{
    XHNetWorkConfig *Net=[[XHNetWorkConfig alloc] init];
    [Net setObject:CFBundleShortVersionString forKey:@"localVersion"];////本地版本
    [Net setObject:@"ios" forKey:@"devType"];                                           //设备信息
    [Net setObject:@"1" forKey:@"appId"];//app的在iTunes的唯一标识符
    [Net postWithUrl:@"zzjt-app-api_appVersion001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            //不需要升级
            if ([dic[@"isUpdate"] intValue]== 0) {
                return;
            }
            //判断NSUserDefaults忽略版本跟version是否相同
            if ([[NSUserDefaults  objectItemForKey:hUMtypeVersion] isEqualToString:dic[@"topVersion"]]) {
                if ([dic[@"isUpdate"] intValue] != 2) {
                    return;
                }
            }
            //升级，可跳过升级
            if ([dic[@"isUpdate"] intValue]== 1) {
                NSString *introduceStr = [NSString stringWithFormat:@"%@版本 \n更新的内容有：%@",dic[@"topVersion"],dic[@"description"]];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:introduceStr  preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"跳过此版本" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [NSUserDefaults setItemObject:dic[@"topVersion"] forKey:hUMtypeVersion];
                }];
                
                UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"前往此版本" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
                        [NSUserDefaults  removeObjectItemForKey:hUMtypeVersion];
                    });
                    
                }];
                
                [alertC addAction:alertA];
                [alertC addAction:alertB];
                [self presentViewController:alertC animated:YES completion:nil];
                return;
            }
            //强制升级
            if ([dic[@"isUpdate"] intValue] == 2) {
                NSString *introduceStr = [NSString stringWithFormat:@"新版本更新的内容有：%@",dic[@"description"]];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"版本更新" message:introduceStr  preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"前往App Store" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NSUserDefaults  removeObjectItemForKey:hUMtypeVersion];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
                    });
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                return;
            }
        }
    } error:^(NSError *error) {
        
    }];
}



/**
 Description

 @param touches touches description
 @param event event description
 
 
 
 -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
 {
 [super touchesBegan:touches withEvent:event];
 XHDropDownMenuControl *dorp = [[XHDropDownMenuControl alloc]initWithDeletage:self];
 
 NSArray *menuArray = @[@"一年级三班",@"二年级四班",@"五年级六班",@"初中班",@"高中三班",@"初中一年级",@"幼儿园大班",@"一年级三班",@"二年级四班",@"五年级六班",@"初中班",@"高中三班",@"初中一年级",@"幼儿园大班",@"一年级三班",@"二年级四班",@"五年级六班",@"初中班",@"高中三班",@"初中一年级",@"幼儿园大班",@"一年级三班",@"二年级四班",@"五年级六班",@"初中班",@"高中三班",@"初中一年级",@"幼儿园大班"];
 NSMutableArray *tempMenuArray = [NSMutableArray array];
 for (NSString *title in menuArray)
 {
 XHDropDownMenuModel *model = [[XHDropDownMenuModel alloc]init];
 [model setObjectID:@"ABIER48KLS"];
 [model setTitle:title];
 [tempMenuArray addObject:model];
 }
 
 
 [dorp setItemArray:tempMenuArray];
 [dorp show];
 }
 */

@end
