//
//  XHNoticeRecordViewController.m
//  daycareParent
//
//  Created by Git on 2018/2/8.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHNoticeRecordViewController.h"
#import "XHNoticeRecordDetailsViewController.h"




@implementation XHNoticeRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通知记录"];
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


#pragma mark - Deletage Method
#pragma mark  XHHomeWorkContentViewDeletage
-(void)didSelectAtIndex:(XHHomeWorkFrame *)frame
{
    XHNoticeRecordDetailsViewController *homeWorkDetails = [[XHNoticeRecordDetailsViewController alloc]init];
    [homeWorkDetails setItemObjet:frame];
    [self.navigationController pushViewController:homeWorkDetails animated:YES];
    homeWorkDetails.refeshBlock = ^(BOOL isRefesh)
    {
        if (isRefesh)
        {
            [self.contentView.tableView beginRefreshing];
        }
    };
}

#pragma mark - Getter / Setter
-(XHNoticeRecordContentView*)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHNoticeRecordContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}



@end
