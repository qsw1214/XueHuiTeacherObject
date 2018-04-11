//
//  XHClassManageContentView.m
//  daycareParent
//
//  Created by mac on 2018/4/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHClassManageContentView.h"
#import "XHWeekCollectionView.h"
#import "XHSyllabusCollectionView.h"
#import <WebKit/WebKit.h>
#import "XHDayRollCallViewController.h"
@interface XHClassManageContentView () <XHWeekCollectionViewDeletage,UIGestureRecognizerDelegate>

@property (nonatomic,strong) WKWebView *webView; //!< 成绩webView
@property (nonatomic,strong) BaseButtonControl *achievementControl; //!< 成绩管理
@property (nonatomic,strong) BaseButtonControl *homeWorkControl; //!< 布置作业
@property (nonatomic,strong) BaseButtonControl *noticeControl; //!< 发布通知
@property (nonatomic,strong) BaseButtonControl *contactParentsControl; //!< 联系家长
@property (nonatomic,strong) BaseButtonControl *parentMessageControl; //!< 家长留言
@property (nonatomic,strong) UILabel *weekTipLabel; //!< 星期提示标签
@property (nonatomic,strong) XHWeekCollectionView *weekCollectionView; //!< 星期滚动
@property (nonatomic,strong) XHSyllabusCollectionView *syllabusCollectionView; //!< 课程表内容






@end


@implementation XHClassManageContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.webView];
        [self addSubview:self.achievementControl];
        [self addSubview:self.homeWorkControl];
        [self addSubview:self.noticeControl];
        [self addSubview:self.contactParentsControl];
        [self addSubview:self.parentMessageControl];
        [self addSubview:self.weekTipLabel];
        [self addSubview:self.weekCollectionView];
        [self addSubview:self.syllabusCollectionView];
        
        [self setItemColor:YES];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    //!< 考勤情况Frame
    [self.webView setFrame:CGRectMake(0, 0, frame.size.width, 200.0)];
    CGFloat spaceWidth = (frame.size.width-3*80)/4.0;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTap:)];
    tapGestureRecognizer.delegate = self;
    [self.webView addGestureRecognizer:tapGestureRecognizer];
    
    //!< 成绩管理Frame
    [self.achievementControl resetFrame:CGRectMake(spaceWidth, (self.webView.bottom+20.0), 80.0, 80.0)];
    [self.achievementControl setTitleEdgeFrame:CGRectMake(0, 0, self.achievementControl.width, self.achievementControl.height) withNumberType:0 withAllType:NO];
    //!< 家庭作业Frame
    [self.homeWorkControl resetFrame:CGRectMake(self.achievementControl.right+spaceWidth, self.achievementControl.top, self.achievementControl.width, self.achievementControl.height)];
    [self.homeWorkControl setTitleEdgeFrame:CGRectMake(0, 0, self.homeWorkControl.width, self.homeWorkControl.height) withNumberType:0 withAllType:NO];
    //!< 发布通知Frame
    [self.noticeControl resetFrame:CGRectMake(self.homeWorkControl.right+spaceWidth, self.homeWorkControl.top, self.homeWorkControl.width, self.homeWorkControl.height)];
    [self.noticeControl setTitleEdgeFrame:CGRectMake(0, 0, self.noticeControl.width, self.noticeControl.height) withNumberType:0 withAllType:NO];
    //!< 联系家长
    [self.contactParentsControl resetFrame:CGRectMake(10.0,(self.homeWorkControl.bottom+20.0), (frame.size.width-30.0)/2.0, self.homeWorkControl.height)];
    [self.contactParentsControl setTitleEdgeFrame:CGRectMake(0, 0, self.contactParentsControl.width, self.contactParentsControl.height) withNumberType:0 withAllType:NO];
    //!< 家长留言
    [self.parentMessageControl resetFrame:CGRectMake((self.contactParentsControl.right+10.0),self.contactParentsControl.top, self.contactParentsControl.width, self.contactParentsControl.height)];
     [self.parentMessageControl setTitleEdgeFrame:CGRectMake(0, 0, self.parentMessageControl.width, self.parentMessageControl.height) withNumberType:0 withAllType:NO];
    //!< “课程表”提示
    [self.weekTipLabel setFrame:CGRectMake(self.contactParentsControl.left, (self.contactParentsControl.bottom+20.0), 60.0, 30.0)];
    //!< 星期滚动条
    [self.weekCollectionView resetFrame:CGRectMake((self.weekTipLabel.right+10.0), self.weekTipLabel.top, (frame.size.width-(self.weekTipLabel.right+10.0+10.0)), self.weekTipLabel.height)];
    [self.syllabusCollectionView resetFrame:CGRectMake(self.weekTipLabel.left,self.weekCollectionView.bottom+20.0, (frame.size.width-20.0), 100.0)];
    
    //!< 重置当前滚动视图的高度
    [self setContentSize:CGSizeMake(frame.size.width, self.syllabusCollectionView.bottom+20.0)];
}


#pragma mark - Delegate Method
#pragma mark XHWeekCollectionViewDeletage 代理方法
-(void)didSelectItemObjectAtIndexPath:(XHWeekFrame*)object
{
    [self.syllabusCollectionView setItemArray:object.model.syllabusArray];
}

-(void)handleTap:(UIGestureRecognizer *)gesture
{
    XHDayRollCallViewController *day=[[XHDayRollCallViewController alloc] initHiddenWhenPushHidden];
    
    [DCURLRouter pushViewController:day animated:YES];
}

#pragma mark - Getter /  Setter
-(WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
    }
    return _webView;
}


-(BaseButtonControl *)achievementControl
{
    if (!_achievementControl)
    {
        _achievementControl = [[BaseButtonControl alloc]init];
        [_achievementControl setNumberLabel:1];
        [_achievementControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_achievementControl setText:@"成绩管理" withNumberType:0 withAllType:NO];
    }
    return _achievementControl;
}


-(BaseButtonControl *)homeWorkControl
{
    if (!_homeWorkControl)
    {
        _homeWorkControl = [[BaseButtonControl alloc]init];
        [_homeWorkControl setNumberLabel:1];
        [_homeWorkControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_homeWorkControl setText:@"家庭作业" withNumberType:0 withAllType:NO];
    }
    return _homeWorkControl;
}

-(BaseButtonControl *)noticeControl
{
    if (!_noticeControl)
    {
        _noticeControl = [[BaseButtonControl alloc]init];
        [_noticeControl setNumberLabel:1];
        [_noticeControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_noticeControl setText:@"发布通知" withNumberType:0 withAllType:NO];
    }
    return _noticeControl;
}


-(BaseButtonControl *)contactParentsControl
{
    if (!_contactParentsControl)
    {
        _contactParentsControl = [[BaseButtonControl alloc]init];
        [_contactParentsControl setNumberLabel:1];
        [_contactParentsControl setText:@"联系家长" withNumberType:0 withAllType:NO];
        [_contactParentsControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    }
    return _contactParentsControl;
}

- (BaseButtonControl *)parentMessageControl
{
    if (!_parentMessageControl)
    {
        _parentMessageControl = [[BaseButtonControl alloc]init];
        [_parentMessageControl setNumberLabel:1];
        [_parentMessageControl setText:@"家长留言" withNumberType:0 withAllType:NO];
        [_parentMessageControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    }
    return _parentMessageControl;
}


-(UILabel *)weekTipLabel
{
    if (!_weekTipLabel)
    {
        _weekTipLabel = [[UILabel alloc]init];
        [_weekTipLabel setText:@"课程表"];
        [_weekTipLabel setBackgroundColor:[UIColor grayColor]];
        [_weekTipLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _weekTipLabel;
}


-(XHWeekCollectionView *)weekCollectionView
{
    if (!_weekCollectionView)
    {

        _weekCollectionView = [[XHWeekCollectionView alloc]init];
        [_weekCollectionView setWeekDeletage:self];
    }
    return _weekCollectionView;
}


-(XHSyllabusCollectionView *)syllabusCollectionView
{
    if (!_syllabusCollectionView)
    {
        
        _syllabusCollectionView = [[XHSyllabusCollectionView alloc]init];
    }
    return _syllabusCollectionView;
}


#pragma mark - setItemColor:(BOOL)color
-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.webView setBackgroundColor:[UIColor redColor]];
        [self.achievementControl setBackgroundColor:[UIColor orangeColor]];
        [self.homeWorkControl setBackgroundColor:[UIColor yellowColor]];
        [self.noticeControl setBackgroundColor:[UIColor purpleColor]];
        [self.contactParentsControl setBackgroundColor:[UIColor darkGrayColor]];
        [self.parentMessageControl setBackgroundColor:[UIColor orangeColor]];
    }
}

// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



@end

