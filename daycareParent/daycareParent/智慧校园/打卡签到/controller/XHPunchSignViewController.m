//
//  XHPunchSignViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignViewController.h"
#import "XHCustomDatePickerView.h"
@interface XHPunchSignViewController ()<XHCustomDatePickerViewDelegate>
{
    NSInteger _Tag;
}
@property(nonatomic,strong)BaseButtonControl *beginDate;
@property(nonatomic,strong)BaseButtonControl *endDate;
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
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    imgV.image=[UIImage imageNamed:@"user_qiandao_bg"];
    [scr addSubview:imgV];
    BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2.0, 10, 80, 100)];
    [btn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scr addSubview:btn];
    [btn setNumberImageView:1];
    [btn setImageEdgeFrame:CGRectMake(0, 0, 80, 80) withNumberType:0 withAllType:NO];
    [btn setImage:@"user_qiandao" withNumberType:0 withAllType:NO];
    [btn setNumberLabel:1];
    [btn setTitleEdgeFrame:CGRectMake(0, 90, 80, 20) withNumberType:0 withAllType:NO];
    [btn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    [btn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
    [btn setText:@"打卡签到" withNumberType:0 withAllType:NO];
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 131, SCREEN_WIDTH, 40)];
    bgView.backgroundColor=RGB(240, 240, 240);
    [scr addSubview:bgView];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 171, SCREEN_WIDTH, 1)];
    view.backgroundColor=RGB(224, 224, 224);
    [scr addSubview:view];
    XHBaseLabel *label=[[XHBaseLabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2.0, 10, 20, 20)];
    label.text=@"至";
    label.textAlignment=NSTextAlignmentCenter;
    //label.backgroundColor=[UIColor redColor];
    label.font=FontLevel3;
    [bgView addSubview:label];
    _beginDate=[[BaseButtonControl alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH/2.0-50, 40)];
    _beginDate.tag=10;
    [_beginDate addTarget:self action:@selector(beginDateMethod:) forControlEvents:UIControlEventTouchUpInside];
     [bgView addSubview:_beginDate];
    //beginDate.backgroundColor=[UIColor orangeColor];
    [_beginDate setNumberImageView:1];
    [_beginDate setImageEdgeFrame:CGRectMake(0, 10, _beginDate.width, _beginDate.height-20) withNumberType:0 withAllType:NO];
    //[beginDate setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
    [_beginDate setImageContentMode:UIViewContentModeScaleToFill withNumberType:0 withAllType:NO];
    [_beginDate setImage:@"time-select" withNumberType:0 withAllType:NO];
    [_beginDate setNumberLabel:1];
    [_beginDate setTitleEdgeFrame:CGRectMake(5, 10, _beginDate.width-20, _beginDate.height-20) withNumberType:0 withAllType:NO];
    [_beginDate setText:[NSString dateWithDateFormatter:@"yyyy-MM-dd" Date:[NSDate date]] withNumberType:0 withAllType:NO];
    [_beginDate setFont:FontLevel4 withNumberType:0 withAllType:NO];
    #pragma mark  注释
   _endDate=[[BaseButtonControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0+20, 0, SCREEN_WIDTH/2.0-50, 40)];
    _endDate.tag=11;
    [_endDate addTarget:self action:@selector(beginDateMethod:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_endDate];
   // endDate.backgroundColor=[UIColor orangeColor];
    [_endDate setNumberImageView:1];
    [_endDate setImageEdgeFrame:CGRectMake(0, 10, _endDate.width, _endDate.height-20) withNumberType:0 withAllType:NO];
    //[beginDate setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
    [_endDate setImageContentMode:UIViewContentModeScaleToFill withNumberType:0 withAllType:NO];
    [_endDate setImage:@"time-select" withNumberType:0 withAllType:NO];
    [_endDate setNumberLabel:1];
    [_endDate setTitleEdgeFrame:CGRectMake(5, 10, _endDate.width-20, _endDate.height-20) withNumberType:0 withAllType:NO];
    [_endDate setText:[NSString dateWithDateFormatter:@"yyyy-MM-dd" Date:[NSDate date]] withNumberType:0 withAllType:NO];
    [_endDate setFont:FontLevel4 withNumberType:0 withAllType:NO];
}
#pragma mark  显示日历
-(void)beginDateMethod:(BaseButtonControl *)btn
{
    _Tag=btn.tag;
    self.datePickerView.delegate=self;
    [self.view addSubview:self.datePickerView];
}
#pragma mark  签到按钮
-(void)signBtnClick
{
    NSLog(@"签到按钮");
}
#pragma mark-----------选择日期后回调代理方法----------
-(void)getDateStr:(NSString *)dateStr
{
    if (dateStr)
    {
        switch (_Tag) {
            case 10:
            {
                [self.beginDate setText:dateStr withNumberType:0 withAllType:NO];
            }
                break;
                
           case 11:
            {
                [self.endDate setText:dateStr withNumberType:0 withAllType:NO];
            }
                break;
        }
       
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
