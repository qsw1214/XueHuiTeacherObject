//
//  MainRootControllerHelper.m
//  ZhongBangShop
//
//  Created by Git on 2017/11/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "MainRootControllerHelper.h"
#import "XHGuideViewController.h"
#import "XHLoginViewController.h"
#import "MainPreviewViewController.h"
#import "AppDelegate.h"
@implementation MainRootControllerHelper

static MainRootControllerHelper *rootHelper = nil;

+ (instancetype)sharedRootHelperHelper
{
    
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        rootHelper = [[self alloc]init];
        
    });
    
    return rootHelper;
}

+(void)isFirstStartWithWindow:(UIWindow*)window
{
  
    NSString *appversion = [NSUserDefaults objectItemForKey:KeyAppVersion];
    if (![NSUserDefaults getLoginModel]&&[[NSString safeString:appversion] isEqualToString:AppVersion])
    {
        
        XHLoginViewController *login=[XHLoginViewController new];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        [window setRootViewController:nav];
        
    }
    else if ([NSUserDefaults getLoginModel]&&[[NSString safeString:appversion] isEqualToString:AppVersion])
    {
        MainPreviewViewController *pre = [[MainPreviewViewController alloc]init];
        [pre navtionHidden:YES];
        [window setRootViewController:pre];
        
        [[MainRootControllerHelper sharedRootHelperHelper] autoLoginWithWindow:window];
    }
    
    else
    {
        
        XHGuideViewController *mianViewController = [[XHGuideViewController alloc]init];
        [window setRootViewController:mianViewController];
    }
    
  
}

+(void)setAppVersion
{
    [NSUserDefaults setItemObject:AppVersion forKey:KeyAppVersion];
    XHLoginViewController *login=[XHLoginViewController new];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
    [kWindow setRootViewController:nav];
}



+(void)rootHelperWith:(RootHelperType)type withController:(UIViewController*)object
{
    switch (type)
    {
        case RootHelperMianTabBarType:
        {
            MianTabBarViewController *main = [[MianTabBarViewController alloc]init];
            [kWindow setRootViewController:main];
        }
            break;
        case RootHelperLoginType:
        {
            [object dismissViewControllerAnimated:YES completion:^{}];
        }
            break;
        case RootHelperLogoutMianTabBarType:
        {
            MianTabBarViewController *main = [[MianTabBarViewController alloc]init];
            [kWindow setRootViewController:main];
        }
            break;
        case RootHelperPresentLoginType:
        {
            XHLoginViewController *login=[XHLoginViewController new];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
            
            [object presentViewController:nav animated:YES completion:nil];
        }
            break;
    }
}

-(void)autoLoginWithWindow:(UIWindow*)window
{
    if ([AFNetworkingHelper connectedToNetWork])
    {
        XHLoginModel *model=[NSUserDefaults getLoginModel];
        XHNetWorkConfig *net=[XHNetWorkConfig new];
        [net setObject:model.loginName forKey:@"loginName"];
        [net setObject:model.pwd forKey:@"password"];
        [net setObject:@"2" forKey:@"userType"];
        [XHShowHUD showTextHud];
        [net postWithUrl:@"pmschool-teacher-api_/teacher/login" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject)
            {
                [[XHUserInfo sharedUserInfo] setItemObject:[object objectItemKey:@"object"]];
                if ([[XHUserInfo sharedUserInfo].selfId isEqualToString:@""]) {
                    [XHShowHUD showNOHud:@"自动登录失败！"];
                    XHLoginViewController *login=[XHLoginViewController new];
                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
                    
                    [window setRootViewController:nav];
                    return ;
                }
                AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                [app loginRongCloud:[XHUserInfo sharedUserInfo].token];
                [app setJpushAlias:[XHUserInfo sharedUserInfo].loginName];
                MianTabBarViewController *main=[MianTabBarViewController new];
                [kWindow setRootViewController:main];
            }
            else
            {
                XHLoginViewController *login=[XHLoginViewController new];
                UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
                
                [window setRootViewController:nav];
            }
        } error:^(NSError *error) {
            XHLoginViewController *login=[XHLoginViewController new];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
            
            [window setRootViewController:nav];
        }];
        
    }
    else
    {
        XHLoginViewController *login=[XHLoginViewController new];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        
        [window setRootViewController:nav];
    }
        
}

@end
