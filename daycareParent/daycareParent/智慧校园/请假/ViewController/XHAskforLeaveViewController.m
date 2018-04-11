//
//  XHAskforLeaveViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveViewController.h"
#import "XHLeaveRecordViewController.h"
#import "XHAskforLeaveContentView.h"
#import "XHLeaveRecordViewController.h"


@interface XHAskforLeaveViewController ()

@property (nonatomic,strong) XHAskforLeaveContentView *contentView;


@end

@implementation XHAskforLeaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"请假"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"请假记录"];
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
        [self.contentView resetFrame:CGRectMake(0, self. navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}

-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHLeaveRecordViewController *leave=[[XHLeaveRecordViewController alloc] init];
    [self.navigationController pushViewController:leave animated:YES];
}
#pragma mark - Getter / Setter
-(XHAskforLeaveContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAskforLeaveContentView alloc]initWithObject:self];
    }
    return _contentView;
}


@end
