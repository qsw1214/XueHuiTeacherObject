//
//  XHDayRollCallViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallViewController.h"

@interface XHDayRollCallViewController ()
@property(nonatomic,strong)UIView *headView;
@end

@implementation XHDayRollCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"日常点名"];
    
}
-(UIView *)headView
{
    if (_headView==nil) {
        _headView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 120)];
        _headView.backgroundColor=RGB(254, 248, 242);
        [self.view addSubview:_headView];
    }
    return _headView;
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
