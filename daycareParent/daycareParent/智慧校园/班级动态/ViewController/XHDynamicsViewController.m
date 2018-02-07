//
//  XHDynamicsViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsViewController.h"
#import "XHDynamicsContentView.h"
#import "XHNewDynamicsViewController.h"

//!< 开始教师端开发标记测试


@interface XHDynamicsViewController ()

@property (nonatomic,strong) XHDynamicsContentView *contentView; //!< 内容视图


@end

@implementation XHDynamicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"班级动态"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"新增"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


#pragma mark - Getter / Setter
-(XHDynamicsContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHDynamicsContentView alloc]init];
    }
    return _contentView;
}
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    [UIAlertController actionSheetWithmessage:@"请选择类型" titlesArry:@[@"发送图片",@"发送视频"] controller:self indexBlock:^(NSInteger index, id object) {
        XHNewDynamicsViewController *new=[XHNewDynamicsViewController new];
        new.index=index;
        [self.navigationController pushViewController:new animated:YES];
    }];
}


@end
