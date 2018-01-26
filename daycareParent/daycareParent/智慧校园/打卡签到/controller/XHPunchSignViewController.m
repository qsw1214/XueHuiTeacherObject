//
//  XHPunchSignViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/24.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPunchSignViewController.h"
#import "XHCustomDatePickerView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapLocationKit/AMapLocationKit.h>
@interface XHPunchSignViewController ()<XHCustomDatePickerViewDelegate,AMapLocationManagerDelegate>
{
    NSInteger _Tag;
    NSDate *_beginDate;
    NSDate *_endDate;
}
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,strong)BaseButtonControl *signBtn;
@property(nonatomic,strong)BaseButtonControl *beginDateBtn;
@property(nonatomic,strong)BaseButtonControl *endDateBtn;
@property(nonatomic,strong)XHCustomDatePickerView *beginPickerView;
@property(nonatomic,strong)XHCustomDatePickerView *endPickerView;
@end

@implementation XHPunchSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"签到详情"];
    _endDate=[NSDate date];
    _beginDate=[NSDate getDayBeforWithDate:_endDate dayBefor:6];
    UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    scr.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scr.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scr];
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    imgV.image=[UIImage imageNamed:@"user_qiandao_bg"];
    [scr addSubview:imgV];
   _signBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2.0, 10, 80, 100)];
    [_signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scr addSubview:_signBtn];
    [_signBtn setNumberImageView:1];
    [_signBtn setImageEdgeFrame:CGRectMake(0, 0, 80, 80) withNumberType:0 withAllType:NO];
    [_signBtn setImage:@"user_qiandao" withNumberType:0 withAllType:NO];
    [_signBtn setNumberLabel:1];
    [_signBtn setTitleEdgeFrame:CGRectMake(0, 90, 80, 20) withNumberType:0 withAllType:NO];
    [_signBtn setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    [_signBtn setTextColor:[UIColor orangeColor] withTpe:0 withAllType:NO];
    [_signBtn setText:@"打卡签到" withNumberType:0 withAllType:NO];
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
    _beginDateBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH/2.0-50, 40)];
    _beginDateBtn.tag=10;
    [_beginDateBtn addTarget:self action:@selector(dateBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
     [bgView addSubview:_beginDateBtn];
    //beginDate.backgroundColor=[UIColor orangeColor];
    [_beginDateBtn setNumberImageView:1];
    [_beginDateBtn setImageEdgeFrame:CGRectMake(0, 10, _beginDateBtn.width, _beginDateBtn.height-20) withNumberType:0 withAllType:NO];
    //[beginDate setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
    [_beginDateBtn setImageContentMode:UIViewContentModeScaleToFill withNumberType:0 withAllType:NO];
    [_beginDateBtn setImage:@"time-select" withNumberType:0 withAllType:NO];
    [_beginDateBtn setNumberLabel:1];
    [_beginDateBtn setTitleEdgeFrame:CGRectMake(5, 10, _beginDateBtn.width-20, _beginDateBtn.height-20) withNumberType:0 withAllType:NO];
    [_beginDateBtn setText:[NSString dateWithDateFormatter:YY_DEFAULT_TIME_FORM Date:_beginDate] withNumberType:0 withAllType:NO];
    [_beginDateBtn setFont:FontLevel4 withNumberType:0 withAllType:NO];
    #pragma mark  注释
   _endDateBtn=[[BaseButtonControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0+20, 0, SCREEN_WIDTH/2.0-50, 40)];
    _endDateBtn.tag=11;
    [_endDateBtn addTarget:self action:@selector(dateBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_endDateBtn];
   // endDate.backgroundColor=[UIColor orangeColor];
    [_endDateBtn setNumberImageView:1];
    [_endDateBtn setImageEdgeFrame:CGRectMake(0, 10, _endDateBtn.width, _endDateBtn.height-20) withNumberType:0 withAllType:NO];
    //[beginDate setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
    [_endDateBtn setImageContentMode:UIViewContentModeScaleToFill withNumberType:0 withAllType:NO];
    [_endDateBtn setImage:@"time-select" withNumberType:0 withAllType:NO];
    [_endDateBtn setNumberLabel:1];
    [_endDateBtn setTitleEdgeFrame:CGRectMake(5, 10, _endDateBtn.width-20, _endDateBtn.height-20) withNumberType:0 withAllType:NO];
    [_endDateBtn setText:[NSString dateWithDateFormatter:YY_DEFAULT_TIME_FORM Date:_endDate] withNumberType:0 withAllType:NO];
    [_endDateBtn setFont:FontLevel4 withNumberType:0 withAllType:NO];
}
#pragma mark    定位获取区域编码
- (void)startLocation
{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 10;
    
    [XHShowHUD showTextHud:@"获取位置..."];
    // 带逆地理（返回坐标和地址信息）
    @WeakObj(self);
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [XHShowHUD hideHud];
        if (error)
        {
            NSLog(@"locError:---%ld===%@",(long)error.code, error.localizedDescription);
            [XHShowHUD showNOHud:@"获取位置信息失败"];
        }
        if (regeocode)
        {
            @StrongObj(self);
            [self sign:location];
        }
    }];
    
}
#pragma mark  打卡方法
- (void)sign:(CLLocation *)location
{
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].schoolId forKey:@"schoolId"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%@",@(location.coordinate.latitude)] forKey:@"latitude"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%@",@(location.coordinate.longitude)] forKey:@"longitude"];
    [self.netWorkConfig postWithUrl:@"pmschool-teacher-api_/teacher/attendanceSheet/signIn" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject)
        {
            
        }
       else
        {
            
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark  显示日历按钮方法
-(void)dateBtnMethod:(BaseButtonControl *)btn
{
    _Tag=btn.tag;
    switch (btn.tag) {
        case 10:
            {
                [self.view addSubview:self.beginPickerView];
                   _beginPickerView.datePickerView.maximumDate=[NSDate getDayAfterWithDate:_endDate dayAfter:0];
                
            }
            break;
            
       case 11:
        {
            [self.view addSubview:self.endPickerView];
            _endPickerView.datePickerView.minimumDate=_beginDate;
        }
            break;
    }
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
                [self.beginDateBtn setText:dateStr withNumberType:0 withAllType:NO];
                _beginDate=[NSDate getDateWithDateStr:dateStr formatter:YY_DEFAULT_TIME_FORM];
                 _endPickerView.datePickerView.minimumDate=_beginDate;
            }
                break;
                
           case 11:
            {
                [self.endDateBtn setText:dateStr withNumberType:0 withAllType:NO];
                _endDate=[NSDate getDateWithDateStr:dateStr formatter:YY_DEFAULT_TIME_FORM];
                _beginPickerView.datePickerView.maximumDate=[NSDate getDayAfterWithDate:_endDate dayAfter:0];
                _beginDate=[NSDate getDayBeforWithDate:_endDate dayBefor:6];
                 [self.beginDateBtn setText:[NSString dateWithDateFormatter:YY_DEFAULT_TIME_FORM Date:_beginDate] withNumberType:0 withAllType:NO];
                _beginPickerView.datePickerView.date=_beginDate;
                
            }
                
                break;
        }
       
    }
    
}
#pragma mark-------------显示开始日历视图--------------
-(XHCustomDatePickerView *)beginPickerView
{
    if (_beginPickerView==nil) {
        _beginPickerView=[[XHCustomDatePickerView alloc] initWithFrame:WindowScreen];
        _beginPickerView.delegate=self;
        _beginPickerView.datePickerView.date=_beginDate;
    }
    [self.view addSubview:_beginPickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _beginPickerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _beginPickerView;
    
}
#pragma mark-------------显示结束日历视图--------------
-(XHCustomDatePickerView *)endPickerView
{
    if (_endPickerView==nil) {
        _endPickerView=[[XHCustomDatePickerView alloc] initWithFrame:WindowScreen];
        _endPickerView.delegate=self;
        _endPickerView.datePickerView.minimumDate=_beginDate;
    }
    [self.view addSubview:_endPickerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _endPickerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _endPickerView;
    
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
