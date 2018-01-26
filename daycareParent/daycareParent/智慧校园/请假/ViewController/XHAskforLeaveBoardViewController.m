//
//  XHAskforLeaveBoardViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAskforLeaveBoardViewController.h"
#import "XHAskforLeaveViewController.h"
#import "XHHistoryViewController.h"



@interface XHAskforLeaveBoardViewController ()

@end

@implementation XHAskforLeaveBoardViewController



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        XHAskforLeaveViewController *askforLeave = [[XHAskforLeaveViewController alloc]init];
        XHHistoryViewController *history = [[XHHistoryViewController alloc]init];
        [self setSegmentedControlItems:@[@"新建",@"记录"] WithControllersArry:@[askforLeave,history]];
    }
    return self;
}

-(instancetype)initHiddenWhenPushHidden
{
    self = [super initHiddenWhenPushHidden];
    if (self)
    {
        XHAskforLeaveViewController *askforLeave = [XHAskforLeaveViewController new];
        XHHistoryViewController *history = [XHHistoryViewController new];
        [self setSegmentedControlItems:@[@"新建",@"记录"] WithControllersArry:@[askforLeave,history]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
