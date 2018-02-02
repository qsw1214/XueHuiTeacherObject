//
//  XHAddNoticeViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddNoticeViewController.h"
#import "XHAddNoticeContentView.h"
#import "XHNoticeListViewController.h"
#import "XHAddNoticeRecipientViewController.h"




@interface XHAddNoticeViewController ()

@property (nonatomic,strong) XHAddNoticeContentView *contentView;


@end

@implementation XHAddNoticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"发布通知"];
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
    XHAddNoticeRecipientViewController *noticeListView = [[XHAddNoticeRecipientViewController alloc]init];
    [self.navigationController pushViewController:noticeListView animated:YES];
}



#pragma mark - Getter / Setter
-(XHAddNoticeContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHAddNoticeContentView alloc]init];
    }
    return _contentView;
}

@end
