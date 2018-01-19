//
//  XHDayRollCallViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallViewController.h"
#import "XHCustomDatePickerView.h"
@interface XHDayRollCallViewController ()<XHCustomDatePickerViewDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)XHCustomDatePickerView *datePickerView;
@property(nonatomic,strong)BaseButtonControl *rightBtn;
@end

@implementation XHDayRollCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"日常点名"];
    [self.view addSubview:self.headView];
//    [self setItemContentType:NavigationIconAndTitle withItemType:NavigationItemRightype withIconName:@"ico_date" withTitle:@"123"];
    [self.view addSubview:self.rightBtn];
}
-(BaseButtonControl *)rightBtn
{
    if (_rightBtn==nil) {
        _rightBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 20, 100, 44)];
        //_rightBtn.backgroundColor=[UIColor yellowColor];
        [_rightBtn setNumberImageView:1];
        [_rightBtn setNumberLabel:1];
        [_rightBtn setImageEdgeFrame:CGRectMake(5, 15, 16, 16) withNumberType:0 withAllType:NO];
        [_rightBtn setImage:@"ico_date" withNumberType:0 withAllType:NO];
        [_rightBtn setTitleEdgeFrame:CGRectMake(25, 0, 70, 45) withNumberType:0 withAllType:NO];
        [_rightBtn setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_rightBtn setFont:FontLevel3 withNumberType:0 withAllType:NO];
        //[_rightBtn setTextBackGroundColor:[UIColor redColor] withTpe:0 withAllType:NO];
        [_rightBtn setText:[NSString dateWithDateFormatter:@"MM月dd日" Date:[NSDate date]] withNumberType:0 withAllType:NO];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
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
#pragma mark-------------点击显示日历--------------
-(void)rightBtnClick
{
    [self.view addSubview:self.datePickerView];
}
-(XHCustomDatePickerView *)datePickerView
{
    if (_datePickerView==nil) {
        _datePickerView=[[XHCustomDatePickerView alloc] initWithFrame:WindowScreen];
        _datePickerView.delegate=self;
    }
    [self.view addSubview:_datePickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _datePickerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _datePickerView;
}
#pragma mark-----------选择日期后回调代理方法----------
-(void)getDateStr:(NSString *)dateStr
{
    if (dateStr)
    {
        [self.rightBtn setText:dateStr withNumberType:0 withAllType:NO];
    }
    
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
