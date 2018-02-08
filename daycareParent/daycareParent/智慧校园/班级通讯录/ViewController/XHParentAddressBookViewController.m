//
//  XHParentAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentAddressBookViewController.h"
#import "XHParentAddressBookContentView.h"
#import "XHAddressBookKey.h"

@interface XHParentAddressBookViewController () <XHCustomViewDelegate>
@property (nonatomic,strong) XHParentAddressBookContentView *parentAddressBookContentView;

@end

@implementation XHParentAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.parentAddressBookContentView.tableView beginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.parentAddressBookContentView];
        [self.parentAddressBookContentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height))];
    }
}

-(void)getChildModel:(id*)childModel
{
    
}



#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
}

#pragma mark - Getter / Setter
-(XHParentAddressBookContentView *)parentAddressBookContentView
{
    if (!_parentAddressBookContentView)
    {
        _parentAddressBookContentView = [[XHParentAddressBookContentView alloc]init];
        [_parentAddressBookContentView setBackgroundColor:[UIColor blueColor]];
    }
    return _parentAddressBookContentView;
}
@end
