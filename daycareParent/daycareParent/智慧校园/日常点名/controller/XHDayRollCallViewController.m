//
//  XHDayRollCallViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDayRollCallViewController.h"
#import "XHAddressPickerView.h"
@interface XHDayRollCallViewController ()<XHAddressPickerViewDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)XHAddressPickerView *datePickerView;
@end

@implementation XHDayRollCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"日常点名"];
    [self.view addSubview:self.headView];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"123"];
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
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    [self.view addSubview:self.datePickerView];
}
-(XHAddressPickerView *)datePickerView
{
    if (_datePickerView==nil) {
        _datePickerView=[[XHAddressPickerView alloc] initWithFrame:WindowScreen];
        _datePickerView.delegate=self;
    }
    [self.view addSubview:_datePickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _datePickerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _datePickerView;
}
#pragma mark-----------选择地址后回调代理方法----------
-(void)getDateStr:(NSString *)dateStr
{
    if (dateStr) {
        
        NSLog(@"=============%@",dateStr);
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
