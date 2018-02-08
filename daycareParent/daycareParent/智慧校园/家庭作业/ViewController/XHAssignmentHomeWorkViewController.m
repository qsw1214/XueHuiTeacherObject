//
//  XHAssignmentHomeWorkViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAssignmentHomeWorkViewController.h"
#import "XHAssignmentHomeWorkContentView.h"
#import "XHHomeWorkViewController.h"



@interface XHAssignmentHomeWorkViewController ()

@property (nonatomic,strong) XHAssignmentHomeWorkContentView *contentView;



@end

@implementation XHAssignmentHomeWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"发布作业"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"记录"];
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


-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHHomeWorkViewController *homeWork = [[XHHomeWorkViewController alloc]init];
    [homeWork setType:HomeWorkNoticeType];
    [self.navigationController pushViewController:homeWork animated:YES];
}



#pragma mark - Getter / Setter
-(XHAssignmentHomeWorkContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHAssignmentHomeWorkContentView alloc]init];
    }
    return _contentView;
}

@end
