//
//  XHAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookViewController.h"
#import "XHAddressBookContentView.h"
#import "XHAddressBookKey.h"

@interface XHAddressBookViewController ()<XHCustomViewDelegate>
@property (nonatomic,strong) XHAddressBookContentView *contentView; //!< 内容视图

@end

@implementation XHAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[XHHelper sharedHelper] setCurrentViewController:self];
    [self.contentView.tableView beginRefreshing];
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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height))];
        [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
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
-(XHAddressBookContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAddressBookContentView alloc]init];
    }
    return _contentView;
}
@end
