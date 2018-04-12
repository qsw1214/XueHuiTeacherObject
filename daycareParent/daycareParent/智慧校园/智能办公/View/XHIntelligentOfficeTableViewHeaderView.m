//
//  XHIntelligentOfficeTableViewHeaderView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/4/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIntelligentOfficeTableViewHeaderView.h"
#import "XHIntelligentOfficeSignInView.h"
#import "XHIntelligentOfficeListView.h"
@interface XHIntelligentOfficeTableViewHeaderView()
@property(nonatomic,strong)XHIntelligentOfficeSignInView *signInView;
@property(nonatomic,strong)XHIntelligentOfficeListView *listView;
@property(nonatomic,strong)ParentControl *infomationControl;
@property(nonatomic,strong)ParentLabel *tipLabel;
@end


@implementation XHIntelligentOfficeTableViewHeaderView




-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=RGB(245, 245, 245);
        [self.signInView resetFrame:CGRectMake(0, 0, frame.size.width, 260)];
        
        self.listView.frame=CGRectMake(0, self.signInView.bottom+10, frame.size.width, 85);
        self.infomationControl.frame=CGRectMake(15, self.listView.bottom+10, frame.size.width-30, 135);
        self.tipLabel.frame=CGRectMake(0, self.infomationControl.bottom+10, frame.size.width, 35);
        [self addSubview:self.signInView];
        [self addSubview:self.listView];
        [self addSubview:self.infomationControl];
         [self addSubview:self.tipLabel];
    }
    return self;
}
-(void)addTimer
{
    [self.signInView addTimer];
}
-(void)invalidate
{
    [self.signInView invalidate];
}
-(XHIntelligentOfficeSignInView *)signInView
{
    if (_signInView==nil) {
        _signInView=[[XHIntelligentOfficeSignInView alloc] init];
    }
    return _signInView;
}
-(XHIntelligentOfficeListView *)listView
{
    if (_listView==nil) {
        _listView=[[XHIntelligentOfficeListView alloc] init];
    }
    return _listView;
}

-(ParentControl *)infomationControl
{
    if (_infomationControl==nil) {
        _infomationControl=[[ParentControl alloc] init];
        _infomationControl.backgroundColor=[UIColor whiteColor];
        _infomationControl.layer.cornerRadius=7;
        _infomationControl.layer.masksToBounds=YES;
        [_infomationControl setNumberLabel:5];
        [_infomationControl setLabelCGRectMake:CGRectMake(5, 0, (SCREEN_WIDTH-30)/2.0, 30) withNumberIndex:0];
        [_infomationControl setLabelTextColor:RGB(51, 51, 51) withNumberIndex:0];
        [_infomationControl setLabelText:@"快乐劳动节" withNumberIndex:0];
        
        
        [_infomationControl setLabelCGRectMake:CGRectMake((SCREEN_WIDTH-30)/2.0, 0, (SCREEN_WIDTH-30)/2.0-5, 30) withNumberIndex:1];
        [_infomationControl setLabelTextColor:RGB(50, 50, 50) withNumberIndex:1];
        [_infomationControl setLabelText:@"4月26日 12:43" withNumberIndex:1];
        [_infomationControl setLabelFont:kFont(13) withNumberIndex:1];
        [_infomationControl setLabelTextAlignment:NSTextAlignmentRight withNumberIndex:1];
    
        
        [_infomationControl setLabelCGRectMake:CGRectMake(5, 30, (SCREEN_WIDTH-35), 65) withNumberIndex:2];
        [_infomationControl setLabelTextColor:RGB(50, 50, 50) withNumberIndex:2];
        [_infomationControl setLabelFont:kFont(13) withNumberIndex:2];
        [_infomationControl setLabelNumberOfLines:0 withNumberIndex:2];
        [_infomationControl setLabelText:@"  1886年5月1日，资本主义阵营老大哥美国芝加哥工人在这一天不约而同走上街头为争取8小时工作制罢工了，而且席卷全美，人数达35万之多。" withNumberIndex:2];
        
         [_infomationControl setLabelCGRectMake:CGRectMake(0, 95, (SCREEN_WIDTH-20), 1) withNumberIndex:3];
        [_infomationControl setLabelBackgroundColor:LineViewColor withNumberIndex:3];
        
        [_infomationControl setLabelCGRectMake:CGRectMake(0, 95, SCREEN_WIDTH-30, 40) withNumberIndex:4];
        [_infomationControl setLabelTextColor:MainColor withNumberIndex:4];
        [_infomationControl setLabelText:@"查看更多" withNumberIndex:4];
        [_infomationControl setLabelFont:kFont(15) withNumberIndex:4];
        [_infomationControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:4];
        
    }
    return _infomationControl;
}

-(ParentLabel *)tipLabel
{
    if (_tipLabel==nil) {
        _tipLabel=[[ParentLabel alloc] init];
        _tipLabel.backgroundColor=[UIColor whiteColor];
        [_tipLabel setText:@"  审批提醒"];
    }
    return _tipLabel;
}
@end
