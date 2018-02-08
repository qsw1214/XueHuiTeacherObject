//
//  XHCourseReportViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCourseReportViewController.h"
#import "XHNewBulidViewController.h"
#import "XHHistoryViewController.h"
@interface XHCourseReportViewController ()

@end

@implementation XHCourseReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XHNewBulidViewController *new = [XHNewBulidViewController new];
    new.segementVC=self;
    XHHistoryViewController *history = [XHHistoryViewController new];
    history.modelType=XHHistoryCourseReportType;
    [self setSegmentedControlItems:@[@"新建",@"记录"] WithControllersArry:@[new,history]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
