//
//  XHIMNoticeViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHIMNoticeViewController.h"
#import "XHNoticeViewController.h"
#import "XHChatViewController.h"

@interface XHIMNoticeViewController ()

@end

@implementation XHIMNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   XHNoticeViewController * notific = [[XHNoticeViewController alloc] init];
   XHChatViewController* chat = [[XHChatViewController alloc] init];
    [self setSegmentedControlItems:@[@"公告",@"消息"] WithControllersArry:@[notific,chat]];
    [self navtionItemHidden:NavigationItemLeftType];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
