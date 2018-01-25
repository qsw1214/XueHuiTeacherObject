//
//  XHPunchSignViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignViewController.h"

@interface XHPunchSignViewController ()

@end

@implementation XHPunchSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"签到详情"];
    UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    scr.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scr.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scr];
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0    , SCREEN_WIDTH, 120)];
    imgV.image=[UIImage imageNamed:@"user_qiandao_bg"];
    [scr addSubview:imgV];
    BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2.0, 10, 80, 100)];
    [scr addSubview:btn];
    [btn setNumberImageView:1];
    [btn setImageEdgeFrame:CGRectMake(0, 0, 80, 80) withNumberType:0 withAllType:NO];
    [btn setImage:@"user_qiandao" withNumberType:0 withAllType:NO];
    [btn setNumberLabel:1];
    [btn setTitleEdgeFrame:CGRectMake(0, 80, 80, 20) withNumberType:0 withAllType:NO];
    [btn setText:@"打卡签到" withNumberType:0 withAllType:NO];
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
