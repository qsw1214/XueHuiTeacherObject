//
//  XHDatePickerView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCustomDatePickerView.h"

@implementation XHCustomDatePickerView

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
        XHBaseLabel *label=[[XHBaseLabel alloc] initWithFrame:CGRectMake(cancleBtn.right, 8, sureBtn.left-cancleBtn.right, 45)];
        label.text=@"请选择日期";
        label.font=FontLevel1;
        label.textAlignment=NSTextAlignmentCenter;
        [_view addSubview:label];
        [self getDatePicker];
    }
    return self;
}


- (void)getDatePicker
{
    
    
    //初始化， DatePicker有默认宽高，实例后就可以获得系统提供的frame值
    datePickerView = [[UIDatePicker alloc]init];
    datePickerView.frame = CGRectMake(0,50, SCREEN_WIDTH, 170);
    //    datePickerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:datePickerView];
    
    //监听值的改变
    [datePickerView addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    datePickerView.datePickerMode = UIDatePickerModeDate;
    /**
     *  主动修改显示语言 CFStringTokenizer  默认根据设备语言变换
     *  英文："en"  简体中文："zh-Hans"  繁体中文:"zh-Hant"
     *
     */
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
    datePickerView.locale = locale;
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
            [_delegate getDateStr:[NSString dateWithDateFormatter:@"MM月dd日" Date:[NSDate date]]];
        }
    }
}

-(void)changeDate:(UIDatePicker*)datePicker
{
    NSLog(@"date=%@",datePicker.date);
    if ([[NSString dateWithDateFormatter:@"yyyy-MM-dd" Date:datePicker.date] compare:[NSString dateWithDateFormatter:@"yyyy-MM-dd" Date:[NSDate date]]]== NSOrderedDescending) {
        [datePickerView setDate:[NSDate date] animated:YES];
    }
    _dateStr=[NSString dateWithDateFormatter:@"MM月dd日" Date:datePicker.date];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
