//
//  XHAddressPickerView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressPickerView.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"
@implementation XHAddressPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _view=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220)];
        _view.backgroundColor=[UIColor whiteColor];
        [self addSubview:_view];
        UIButton *cancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_view addSubview:cancleBtn];
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 45, 45)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_view addSubview:sureBtn];
        XHBaseLabel *label=[[XHBaseLabel alloc] initWithFrame:CGRectMake(cancleBtn.right, 5, sureBtn.left-cancleBtn.right, 45)];
        label.text=@"请选择日期";
        [_view addSubview:label];
        [self uiConfig];
    }
    return self;
}


- (void)uiConfig
{

    //初始化， DatePicker有默认宽高，实例后就可以获得系统提供的frame值
    datePickerView = [[UIDatePicker alloc]init];
    datePickerView.frame = CGRectMake(0,50, SCREEN_WIDTH, 170);
//    datePickerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:datePickerView];
    //监听值的改变
    [datePickerView addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    
    
    /**
     *  时间选择器类型 datePickerMode
     *      typedef NS_ENUM(NSInteger, UIDatePickerMode) {
     UIDatePickerModeTime,
     UIDatePickerModeDate,
     UIDatePickerModeDateAndTime,
     UIDatePickerModeCountDownTimer,
     };
     *  @return return value description
     */
    datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    
    
    /**
     *  主动修改显示语言 CFStringTokenizer  默认根据设备语言变换
     *  英文："en"  简体中文："zh-Hans"  繁体中文:"zh-Hant"
     *
     */
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
    datePickerView.locale = locale;
    
    
    
    //设置通用日历(一般可以忽略设置）  if nil default is [NSCalendar currentCalendar]
    datePickerView.calendar = nil;
    
    
    /**
     *  设置UIDatePicker最远时间 有以下两种方法
     *
     */
    
    //方法1、根据当前日历时间设置 dateComponents 偏移值差，得到最大时间
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    //设置偏差
    //    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    //    [dateComponents setYear:10];
    //    [dateComponents setMonth:0];
    //    [dateComponents setDay:0];
    //    [dateComponents setMinute:0];
    //    [dateComponents setHour:0];
    //    [dateComponents setSecond:0];
    //
    //    NSDate *maxDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    //    datePickerView.minimumDate = [NSDate date];
    //    datePickerView.maximumDate = maxDate;
    
    //方法2、简单实用
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*365*20];
    datePickerView.minimumDate = [NSDate date];
    datePickerView.maximumDate = maxDate;
    
    
    //===========================================
    
    
    //当前在datePicker 中首先显示的日期
    //    datePickerView.date = [NSDate dateWithTimeIntervalSinceNow:3600*24];
    //    [datePickerView setDate:[NSDate date] animated:YES];
    
    
    //时区 GMT(详情见 NSTimeZone文章)
    //    datePickerView.timeZone = nil;
    
    
    //@countDownDuration
    datePickerView.countDownDuration = 10*60;
    
    
    //最小间隔分钟值   @minuteInterval （适用于 UIDatePickerModeTime、UIDatePickerModeCountDownTimer、UIDatePickerModeDateAndTime）
    datePickerView.minuteInterval = 5;
}

-(void)btnClick
{
    [self removeCustomView];
}
-(void)sureBtnClick
{
    [self removeCustomView];
    if ([_delegate respondsToSelector:@selector(getDateStr:)]) {
        if (![[NSString safeString:_dateStr] isEqualToString:@""]) {
           [_delegate getDateStr:_dateStr];
        }
        else
        {
           [_delegate getDateStr:[self date:[NSDate date]]];
        }
    }
}

-(void)changeDate:(UIDatePicker*)datePicker
{
    NSLog(@"date=%@",datePicker.date);
    _dateStr=[self date:datePicker.date];
     NSLog(@"dateStr===========%@",_dateStr);
}
-(NSString *)date:(NSDate *)date

{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = @"yyyy/MM/dd";
   NSString * dateStr = [dateFor stringFromDate:date];
    return dateStr;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeCustomView];
}
-(void)removeCustomView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _view.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
}
-(void)delayMethod
{
    [self removeFromSuperview];
}
@end
